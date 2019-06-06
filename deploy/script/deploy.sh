#!/bin/bash
set -e
DEPLOY_ROOT=/home/jenkins/deploy/
YAML_ROOT=/home/jenkins/yaml
PORT=80
MODULE=$1
echo "项目名称为：${MODULE}"
cd ${DEPLOY_ROOT}${MODULE}
IMAGE=`cat IMAGE_NAME`
echo "镜像名称为：${IMAGE}"
EXPOSE=`grep "EXPOSE" Dockerfile`
PORT=`echo ${EXPOSE#* }`
echo "容器暴露的端口为：${PORT}"
cd ${YAML_ROOT}
sed -e "s#{IMAGE_NAME}#${IMAGE}#g;s#{APP_NAME}#${MODULE}#g" k8s-deployment.tpl > ${MODULE}-deployment.yaml
sed -e "s#{APP_NAME}#${MODULE}#g;s#{T_PORT}#${PORT}#g" k8s-service.tpl > ${MODULE}-service.yaml
sed -e "s#{APP_NAME}#${MODULE}#g" k8s-ingress.tpl > ${MODULE}-ingress.yaml
echo "update image to:${IMAGE}"
kubectl apply -f secret.yaml
kubectl apply -f ${MODULE}-deployment.yaml
kubectl apply -f ${MODULE}-service.yaml
kubectl apply -f ${MODULE}-ingress.yaml
rm -rf ${MODULE}-deployment.yaml
rm -rf ${MODULE}-service.yaml
rm -rf ${MODULE}-ingress.yaml