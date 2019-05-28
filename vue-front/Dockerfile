FROM centos:centos7
MAINTAINER guonl

RUN yum -y update \
        && yum clean all \
        && yum install -y epel-release \
        && yum install -y nginx iproute

EXPOSE 80
COPY code/ /usr/share/nginx/html/
CMD ["nginx", "-g", "daemon off;"]