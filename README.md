## About

This branch contains a notebook for training on CIFAR10 using Tensorflow and the 1cycle policy. The training is very bare bones and there are ample opportunities to further improve on the result (as noted in the notebook). Nonetheless, this still achieves over 92% accuracy in ~20 epochs.

You will need to have [docker](https://docs.docker.com/install/linux/docker-ce/ubuntu/) and [nvidia-docker](https://github.com/NVIDIA/nvidia-docker) installed in order to run this.

Once you start the docker container, all you have to do is access https://localhost:8888 and enter `jupyter` as password. Open the notebook and hit run all.

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
