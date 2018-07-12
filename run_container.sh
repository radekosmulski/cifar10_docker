#! /bin/bash
IMAGE_NAME=$1

if [[ $# -eq 0 ]] ; then
    echo 'ERROR: No argument passed for image name.'
    exit 0
fi

CONTAINER="nvidia-docker run -it --ipc=host --net=host -v $PWD/workspace/:/root/workspace $IMAGE_NAME"
echo 'Starting container with commmand: '$CONTAINER
eval $CONTAINER
