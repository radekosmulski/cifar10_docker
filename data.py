import os, shutil, re
from glob import glob
from subprocess import run

path = 'data/'
for ds in ['train', 'test']:
    paths = glob('{}cifar/{}/*'.format(path, ds))
    for cls in ('airplane', 'automobile', 'bird', 'cat', 'deer', 'dog', 'frog', 'horse', 'ship', 'truck'):
        run('mkdir -p {}cifar10/{}/{}'.format(path, ds, cls).split())
    for fpath in paths:
        cls = re.search('_(.*)\.png$', fpath).group(1)
        fname = re.search('\w*.png$', fpath).group(0)
        shutil.copy(fpath, '{}cifar10/{}/{}/{}'.format(path, ds, cls, fname))
