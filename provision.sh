#!/bin/bash

#install docker and docker-compose
if ! command -v docker &> /dev/null
then
    curl -fsSL https://get.docker.com -o get-docker.sh
    sudo sh get-docker.sh
    sudo usermod -aG docker vagrant
fi

echo "Docker installed"

if ! command -v docker-compose &> /dev/null
then
    sudo curl -L "https://github.com/docker/compose/releases/download/1.28.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
fi

mkdir loadbalancer
cd ./loadbalancer

sudo yes | cp -rf /vagrant/html1 ./
sudo yes | cp -rf /vagrant/html2 ./
sudo yes | cp -rf /vagrant/html3 ./
sudo yes | cp -rf /vagrant/docker-compose.yml ./
sudo yes | cp -rf /vagrant/default.conf ./

sudo chown -R vagrant:vagrant ../loadbalancer

sudo docker-compose up -d
