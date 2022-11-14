#!/bin/bash

apt-get update
echo "Hello"
apt-get upgrade -y
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin