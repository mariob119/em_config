#!/bin/bash

# Script for setting up slim linux for raspberry py

echo "Do update"
apt-get update
echo ""

echo "Do upgrade"
apt-get upgrade -y
echo ""

sudo chmod a+r /etc/apt/keyrings/docker.gpg
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin