#!/bin/bash

yum -y install docker

mkdir -p /opt/rancher-data/mysql

service docker start

docker run -d --restart=unless-stopped \
-v /opt/rancher-data/mysql:/var/lib/mysql \
-p 80:80 -p 443:443 \
--privileged rancher/rancher:latest