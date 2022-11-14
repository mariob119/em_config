#!/bin/bash

# Script for setting up slim linux for raspberry py

echo ""
echo "======================================================================"

echo "Do update"
echo ""
apt-get update

echo ""
echo "======================================================================"
echo ""

echo "Do upgrade"
echo ""
apt-get upgrade -y

echo ""
echo "======================================================================"
echo ""

echo "Install needed applications"
echo ""
apt-get install \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

echo ""
echo "======================================================================"
echo ""

echo "Enable SSH"
echo ""
sudo systemctl start ssh
sudo systemctl enable ssh

echo ""
echo "======================================================================"
echo ""

echo "Set up everything for docker!"
echo ""
sudo mkdir -p /etc/apt/keyrings -y
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update
sudo chmod a+r /etc/apt/keyrings/docker.gpg
sudo apt-get update

echo ""
echo "======================================================================"
echo ""

echo "Install docker!"
echo ""
sudo apt-get install docker-ce -y
sudo apt-get docker-ce-cli -y
sudo apt-get containerd.io -y
sudo apt-get docker-compose-plugin -y

echo ""
echo "======================================================================"
echo ""

echo "Setup Portainer"
echo ""
docker volume create portainer_data

echo ""
echo "======================================================================"
echo ""

echo "Install Portainer"
echo ""

docker run -d -p 8000:8000 -p 9443:9443 -p 9000:9000 --name portainer \
--restart=always \
-v /var/run/docker.sock:/var/run/docker.sock \
-v portainer_data:/data \
portainer/portainer-ce:2.9.3

docker ps

echo ""
echo "======================================================================"
echo ""

echo "Install Git"
echo ""

apt-get install Git

echo ""
echo "======================================================================"
echo ""