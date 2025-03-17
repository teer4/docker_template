#!/bin/bash
#run in ./{project_name}
# === 修改为你的镜像名 ===
IMAGE_NAME=my_image

docker build -t $IMAGE_NAME .
