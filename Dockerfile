FROM tensorflow/tensorflow:latest-gpu-py3
LABEL maintainer="Radek Osmulski <www.github.com/radekosmulski>"

ENV LANG=C.UTF-8 LC_ALL=C.UTF-8

# This will set the password on the notebook to 'jupyter'. To generate a hash corresponding to a password
# of your choice, run the code below inside a Python interpreter
# from notebook.auth import passwd; print(passwd(<your_password>))
ARG jupass=sha1:85ff16c0f1a9:c296112bf7b82121f5ec73ef4c1b9305b9e538af

RUN echo "c.NotebookApp.password = u'"$jupass"'" >> $HOME/.jupyter/jupyter_notebook_config.py
RUN echo "c.NotebookApp.ip = '*'\nc.NotebookApp.open_browser = False" >> $HOME/.jupyter/jupyter_notebook_config.py

# create ssl cert for jupyter notebook
RUN openssl req -x509 -nodes -days 365 -newkey rsa:1024 -keyout $HOME/mykey.key -out $HOME/mycert.pem -subj "/C=IE"

WORKDIR /root

COPY data.py .
RUN mkdir data
RUN apt update && apt install -y wget
RUN wget http://pjreddie.com/media/files/cifar.tgz -P data/
RUN tar -xf data/cifar.tgz -C data/
RUN python data.py
RUN rm -rf data/cifar.tgz data/cifar
RUN pip install opencv-python-headless
RUN rm -rf /notebooks

CMD jupyter notebook --certfile=mycert.pem --keyfile mykey.key --allow-root --notebook-dir workspace
