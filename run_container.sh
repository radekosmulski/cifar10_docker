#! /bin/bash
IMAGE_NAME=$1

if [[ $# -eq 0 ]] ; then
    echo 'ERROR: No argument passed for image name.'
    exit 0
fi

CONTAINER="docker run -id --runtime=nvidia -e NVIDIA_DRIVER_CAPABILITIES=compute,utility -e NVIDIA_VISIBLE_DEVICES=all \
  --ipc=host --net=host -v $PWD/workspace/:/root/workspace $IMAGE_NAME"
echo 'Starting container with commmand: '$CONTAINER
eval $CONTAINER
