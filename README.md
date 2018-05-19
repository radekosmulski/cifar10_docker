This repository contains the [fastai](http://www.fast.ai) [DAWNbench](https://dawn.cs.stanford.edu/benchmark/#cifar10-train-time) result adapted to training on 1080ti. It is missing many of the optimizations that allowed the fastai team to achieve 94% accuracy in 2m 54s (no fp16, no data prefetching, etc). On my box with a 1080ti I am able to train to 94% accuracy (with TTA) in 13 minutes 30 seconds.

You will need to have [docker](https://docs.docker.com/install/linux/docker-ce/ubuntu/) and [nvidia-docker](https://github.com/NVIDIA/nvidia-docker) installed in order to run this.

Once you start the docker container, all you have to do is access https://localhost:8888 and enter `jupyter` as password. Open the notebook and hit run all.

Instructions for building and running the container:
1. cd into cloned repo
2. `docker build -t cifar .`
3. `./run_container.sh cifar`
