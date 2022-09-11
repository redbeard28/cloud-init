#!/bin/bash
# Free for All
# Made with love by Jeremie CUADRADO (kuma-consulting)
# version: v1
echo ""
echo ""
echo "################# COCKPIT INSTALL ################"
sudo systemctl stop NetworkManager.service
sudo systemctl disable NetworkManager.service

source /etc/os-release
if [[ $NAME -eq "Ubuntu" ]];then
  sudo apt install -t ${VERSION_CODENAME}-backports cockpit -y
  cp -rf kumalabs /usr/share/cockpit/branding/
  sudo systemctl enable cockpit.service
  sudo echo "ID=kumalabs" >>  /lib/systemd/system/cockpit.service
  sudo systemctl daemon-reload
  sudo systemctl start cockpit.service
  sudo apt remove cockpit-networkmanager -y
fi
echo "################# COCKPIT END ################"
echo ""
echo ""