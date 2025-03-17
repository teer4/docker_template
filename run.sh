#!/bin/bash

# === 修改为你的镜像名和容器名 ===
IMAGE_NAME=my_image
CONTAINER_NAME=my_container

PROJECT_PATH=$(pwd)

docker run -it \
    --network host \
    --gpus all \
    -v $PROJECT_PATH:/workspace \
    --name $CONTAINER_NAME \
    $IMAGE_NAME
