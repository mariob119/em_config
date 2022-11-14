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

echo "Create verify install folder"
echo ""

cd /.
if [[ ! -d /verifyinstall ]]; then
  cd /.
  mkdir verifyinstall
  echo "Verifyinstall folder created"
fi

echo ""
echo "======================================================================"
echo ""

echo "Install needed applications"
echo ""

if [[ ! -d /verifyinstall/packages ]]; then
  apt-get install \
      ca-certificates \
      curl \
      gnupg \
      lsb-release \
      apt-transport-https \
      software-properties-common \
      gnupg \
      lsb-release

    cd /.
    mkdir verifyinstall/packages
    echo "Installed all needed packages"
fi

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
if [[ ! -d /energymanager ]]; then
  cd /.
  git clone https://github.com/mariob119/energymanager.git
fi

cd energymanager
git pull https://github.com/mariob119/energymanager.git

echo ""
echo "======================================================================"
echo ""

echo "Enable SSH"
echo ""
sudo apt-get install systemctl -y
sudo systemctl start ssh
sudo systemctl enable ssh
cp energymanager/root/sshd_config /etc/ssh/sshd_config

echo ""
echo "======================================================================"
echo ""

echo "Set up everything for docker!"
echo ""

sudo apt-get update

if [[ ! -d /etc/apt/keyrings ]]; then
  sudo mkdir -p /etc/apt/keyrings
  curl -fsSL https://download.docker.com/linux/debian/gpg
  sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
fi

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
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
portainer/portainer-ce:latest

docker ps

echo ""
echo "======================================================================"
echo ""

echo "Building EnergyManager Image"
echo ""
cd energymanager
docker build -t energymanagerimage .

echo ""
echo "======================================================================"
echo ""

echo "Starting EnergyManager"
echo ""
docker run -p 3000:3000 -p 1883:1883 -p 23:22 -p 502:502 -p 80:80 --name energymanager --restart always energymanagerimage