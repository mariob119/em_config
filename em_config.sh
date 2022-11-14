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

echo "Set up everything for docker!"
echo ""
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
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
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin