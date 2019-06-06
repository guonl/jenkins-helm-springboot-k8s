#!/usr/bin/env bash
MODULE=$1
BUILD_TAG=$2
WORK_ROOT=/home/jenkins/deploy/
PREFIX=registry.cn-shanghai.aliyuncs.com/tigerobo_t3/
IMAGE_NAME=${PREFIX}${MODULE}:${BUILD_TAG}
echo "镜像名称为："${IMAGE_NAME}
#docker 登录
sudo docker login --username=tigerobo_t3 registry.cn-shanghai.aliyuncs.com -p 123QWEasd
cd ${WORK_ROOT}${MODULE}
sudo docker build -t ${IMAGE_NAME} .
sudo docker push ${IMAGE_NAME}
sudo docker rmi ${IMAGE_NAME}
#为deploy脚本传递参数
echo "${IMAGE_NAME}" > IMAGE_NAME