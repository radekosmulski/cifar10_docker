FROM nvidia/cuda:9.0-base
LABEL maintainer="Radek Osmulski <www.github.com/radekosmulski>"

ENV LANG=C.UTF-8 LC_ALL=C.UTF-8
ENV PATH /opt/conda/bin:$PATH

RUN apt-get update --fix-missing && apt-get install -y wget bzip2 ca-certificates \
    libglib2.0-0 libxext6 libsm6 libxrender1 git

RUN wget --quiet https://repo.continuum.io/archive/Anaconda3-5.2.0-Linux-x86_64.sh -O ~/anaconda.sh && \
    /bin/bash ~/anaconda.sh -b -p /opt/conda && \
    rm ~/anaconda.sh && \
    ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh && \
    echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc && \
    echo "conda activate fastai" >> ~/.bashrc

WORKDIR /root

RUN git clone https://github.com/fastai/fastai.git && cd fastai && conda env create

# configure jupyter
RUN jupyter notebook --generate-config

# This will set the password on the notebook to 'jupyter'. To generate a hash corresponding to a password
# of your choice, run the code below inside a Python interpreter
# from notebook.auth import passwd; print(passwd(<your_password>))
ARG jupass=sha1:85ff16c0f1a9:c296112bf7b82121f5ec73ef4c1b9305b9e538af

RUN echo "c.NotebookApp.password = u'"$jupass"'" >> $HOME/.jupyter/jupyter_notebook_config.py
RUN echo "c.NotebookApp.ip = '*'\nc.NotebookApp.open_browser = False" >> $HOME/.jupyter/jupyter_notebook_config.py

# create ssl cert for jupyter notebook
RUN openssl req -x509 -nodes -days 365 -newkey rsa:1024 -keyout $HOME/mykey.key -out $HOME/mycert.pem -subj "/C=IE"

RUN apt-get install -y curl grep sed dpkg && \
    TINI_VERSION=`curl https://github.com/krallin/tini/releases/latest | grep -o "/v.*\"" | sed 's:^..\(.*\).$:\1:'` && \
    curl -L "https://github.com/krallin/tini/releases/download/v${TINI_VERSION}/tini_${TINI_VERSION}.deb" > tini.deb && \
    dpkg -i tini.deb && \
    rm tini.deb && \
    apt-get clean

COPY data.py .
RUN mkdir data
RUN wget http://pjreddie.com/media/files/cifar.tgz -P data/
RUN tar -xf data/cifar.tgz -C data/
RUN python data.py
RUN rm -rf data/cifar.tgz data/cifar

VOLUME workspace /root/workspace

EXPOSE 8888

RUN cd fastai && /bin/bash -c "source activate fastai && python setup.py install"

ENTRYPOINT [ "/usr/bin/tini", "--" ]
SHELL [ "/bin/bash", "-c" ]
CMD source activate fastai && jupyter notebook --certfile=mycert.pem --keyfile mykey.key --allow-root --notebook-dir='workspace'
