#!/bin/bash
# Free for All
# Made with love by Jeremie CUADRADO (kuma-consulting)
# version: v1
echo ""
echo ""
echo "################# COCKPIT INSTALL ################"
sudo systemctl stop NetworkManager.service
sudo systemctl disable NetworkManager.service

myhs=`hostname`
source /etc/os-release
if [[ $ID -eq "ubuntu" ]];then
  sudo apt-get install -t ${VERSION_CODENAME}-backports cockpit cockpit-pcp -y
  sudo cp -rf kumalabs /usr/share/cockpit/branding/
  cd /usr/share/cockpit/branding/
  sudo rm -rf ${ID}
  sudo cp -rf kumalabs ${ID}
  sudo systemctl enable cockpit.service
  sudo echo "ID=kumalabs" >>  /lib/systemd/system/cockpit.service
  sudo systemctl daemon-reload
  sudo systemctl start cockpit.service
  sudo apt-get remove cockpit-networkmanager -y
  if [[ $myhs =~ [^form] ]]; then
    cd /root/cloud-init/cockpit
    sudo apt-get remove cockpit-networkmanager -y
    sudo cp 05-machines.json /etc/cockpit/machines.d/
    sudo ls -l /etc/cockpit/machines.d/
  fi
fi
if [[ $ID -eq "debian" ]];then
  sudo apt-get install -t ${VERSION_CODENAME}-backports cockpit cockpit-pcp -y
  sudo cp -rf kumalabs /usr/share/cockpit/branding/
  cd /usr/share/cockpit/branding/
  sudo rm -rf ${ID}
  sudo cp -rf kumalabs ${ID}
  sudo systemctl enable cockpit.service
  sudo echo "ID=kumalabs" >>  /lib/systemd/system/cockpit.service
  sudo systemctl daemon-reload
  sudo systemctl start cockpit.service
  sudo apt-get remove cockpit-networkmanager -y
  if [[ $myhs =~ [^form] ]]; then
    cd /root/cloud-init/cockpit
    sudo apt-get remove cockpit-networkmanager -y
    sudo cp 05-machines.json /etc/cockpit/machines.d/
    sudo ls -l /etc/cockpit/machines.d/
  fi
fi
echo "################# COCKPIT END ################"
echo ""
echo ""