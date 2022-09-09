#!/bin/bash
# Free for All
# Made with love by Jeremie CUADRADO (kuma-consulting)
# version: v1

sudo systemctl stop NetworkManager.service
sudo systemctl disable NetworkManager.service

source /etc/os-release
sudo apt install -t ${VERSION_CODENAME}-backports cockpit -y
sudo systemctl enable cockpit.service
sudo systemctl start cockpit.service
sudo apt remove cockpit-networkmanager -y
