FROM centos:centos8.1.1911
MAINTAINER Mauricio Muriel (mauricio.muriel@sientifica.com)

# Update to last packages and installs epel-release repo
RUN dnf -y update && dnf install -y dnf-utils
COPY nginx.repo /etc/yum.repos.d/nginx.repo

RUN dnf config-manager --enable nginx-mainline
RUN dnf install -y nginx

#Add user sientifica
RUN adduser sientifica && mkdir /home/sientifica/app

#Starting nginx
RUN nginx start
EXPOSE 80

