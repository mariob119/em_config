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