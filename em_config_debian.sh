#!/bin/bash

# Script for setting up slim linux for raspberry py

echo ""
echo "======================================================================"
echo ""
echo "Test echo 6"
echo ""
echo "======================================================================"
echo ""

echo ""
echo "======================================================================"

echo "Do update"
echo ""
cd
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

sudo apt-get update
apt-get install \
  ca-certificates \
  curl \
  gnupg \
  lsb-release \
  apt-transport-https \
  software-properties-common \
  gnupg \
  lsb-release

echo "Installed all needed packages"

echo ""
echo "======================================================================"
echo ""

echo "Install Git"
echo ""

apt-get install git -y

echo ""
echo "======================================================================"
echo ""

echo "Install mcedit"
echo ""
apt-get install mcedit -y

echo ""
echo "======================================================================"
echo ""

echo "Get EnergyManager data"
echo ""

cd /.
if [[ ! -d energymanager ]]; then
  cd /.
  git clone https://github.com/mariob119/energymanager.git
fi

cd /.
cd energymanager
git pull https://github.com/mariob119/energymanager.git

echo ""
echo "======================================================================"
echo ""

echo "Enable SSH"
echo ""
cd
apt-get install systemctl -y
apt-get install openssh-server -y
systemctl start ssh
systemctl enable ssh
cd /.
cp energymanager/root/sshd_config etc/ssh/sshd_config

echo ""
echo "======================================================================"
echo ""

echo "Set up everything for docker!"
echo ""

cd
apt-get update

sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg -y

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo chmod a+r /etc/apt/keyrings/docker.gpg
sudo apt-get update

echo "Docker is prepared!"

echo ""
echo "======================================================================"
echo ""

echo "Install docker!"
echo ""
cd
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin

echo "Docker is installed!"

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
cd
docker run -d -p 8000:8000 -p 9443:9443 -p 9000:9000 --name portainer \
--restart=always \
-v /var/run/docker.sock:/var/run/docker.sock \
-v portainer_data:/data \
portainer/portainer-ce:latest

docker ps

echo ""
echo "======================================================================"
echo ""

echo "Building EnergyManager Image"
echo ""
cd /.
cd energymanager
docker build -t energymanagerimage .

echo ""
echo "======================================================================"
echo ""

echo "Starting EnergyManager"
echo ""
docker run -p 3000:3000 -p 1883:1883 -p 23:22 -p 502:502 -p 80:80 --name energymanager --restart always energymanagerimage