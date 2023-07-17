#!/bin/bash


echo "Downloading install_docker.sh script from my repository..."
wget https://raw.githubusercontent.com/kumalabsconsulting/install-docker/main/install_docker.sh
chmod 755 install_docker.sh
## Check if Debian OS
if test -r /etc/os-release
  then
	ID=`awk -F= '$1=="ID" { print $2 ;}' /etc/os-release`
	VERSION=`awk -F= '$1=="VERSION" { print $2 ;}' /etc/os-release`
else
  echo "Don't know what os-type it is !"
  exit 1
fi

if [[ "$ID" == 'debian' ]];then
    apt-get install -y php8.1
    ./install_docker.sh $1
elif [[ "$ID" == 'ubuntu' ]];then
    apt-get install -y php8.1
    ./install_docker.sh $1
else
  echo "This script is usefull for debian/ubuntu os"
  exit 1
fi


