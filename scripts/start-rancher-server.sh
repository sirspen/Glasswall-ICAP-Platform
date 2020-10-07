!#/bin/bash

yum -y install docker

export HOST_VOLUME=$HOME/rancher-data/mysql
mkdir -p $HOST_VOLUME

sudo docker run -d --restart=unless-stopped \
-v $HOST_VOLUME:/var/lib/mysql \
-p 80:80 -p 443:443 \
--privileged rancher/rancher:latest