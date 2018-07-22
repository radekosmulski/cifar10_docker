## About

This repository contains the [fastai](http://www.fast.ai) [DAWNbench](https://dawn.cs.stanford.edu/benchmark/#cifar10-train-time) result adapted to training on 1080ti. It is missing many of the optimizations that allowed the fastai team to achieve 94% accuracy in 2m 54s (no fp16, no data prefetching, etc) on an AWS p3.16xlarge instance with 8 V100 GPUs. On my box with a single 1080ti I am able to train to 94% accuracy (with TTA) in 13 minutes 30 seconds.

The second notebook adapts recent work by fastai and trains with AdamW and the 1 cycle policy cutting down the number of required epochs to 18. You can read more about this approach on the [fastai blog](http://www.fast.ai/2018/07/02/adam-weight-decay/) or in the [official repositiory](https://github.com/sgugger/Adam-experiments).

You will need to have [docker](https://docs.docker.com/install/linux/docker-ce/ubuntu/) and [nvidia-docker](https://github.com/NVIDIA/nvidia-docker) installed in order to run this.

Once you start the docker container, all you have to do is access https://localhost:8888 and enter `jupyter` as password. Open the notebook and hit run all.

For Tensorflow code please checkout the [tensorflow branch](https://github.com/radekosmulski/cifar10_docker/tree/tensorflow). The implementation there is very minimal but still might be useful as a starting point for experimenting.

## Instructions for building and running the container
1. cd into cloned repo
2. `docker build -t cifar .`
3. `./run_container.sh cifar`


*SIDENOTE*: You might need to run the commands with sudo. I prefer to do the following:
```
sudo groupadd docker
sudo usermod -aG docker $USER
```
(this effectively grants docker sudo powers so is not more secure than running docker with sudo)
