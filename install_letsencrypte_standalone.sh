#!/bin/bash
# Free for All
# Made with love by Jeremie CUADRADO (kuma-consulting)
# version: v1
set -x

myhs=`hostname`

############################################################
# Help                                                     #
############################################################

Help()
{
   # Display Help
   echo "Install let s encrypte from snap."
   echo
   echo "Syntax: scriptTemplate [-d|h]"
   echo "options:"
   echo "d     Domain input."
   echo "d     Mail account for let s encrypte input."
   echo "h     Print this Help."
   echo
}



while getopts ":hd:m:" option; do
   case $option in
      d) # Enter a name
         domain=$OPTARG;;
      m) # Mail  account
         mail=$OPTARG;;
      h) # display Help
         Help
         exit;;
      \?) # Invalid option
         echo "Error: Invalid option"
         exit;;
   esac
done

############################################################
############################################################
# Main program                                             #
############################################################
############################################################


source /etc/os-release
if [[ $NAME -eq "Ubuntu" ]]; then
  sudo snap install core
  sudo snap refresh core
  sudo snap install --classic certbot
  sudo ln -s /snap/bin/certbot /usr/bin/certbot
  echo ${myhs}.${domain} ${mail}
  certbot certonly --standalone --noninteractive --server https://acme-staging-v02.api.letsencrypt.org/directory --agree-tos --email ${mail} -d ${myhs}.${domain}
  cp /etc/hosts /etc/hosts.ori
  echo "127.0.0.1 ${myhs}.${domain} ${myhs} localhost" > /etc/hosts
  cp /etc/letsencrypt/live/${myhs}.${domain}/fullchain.pem /etc/cockpit/ws-certs.d/${myhs}.${domain}.crt
  cp /etc/letsencrypt/live/${myhs}.${domain}/privkey.pem /etc/cockpit/ws-certs.d/${myhs}.${domain}.key
  chown cockpit-ws:cockpit-ws /etc/cockpit/ws-certs.d/${myhs}.${domain}.crt /etc/cockpit/ws-certs.d/${myhs}.${domain}.key
  systemctl restart cockpit
fi