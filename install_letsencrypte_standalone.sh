#!/bin/bash
# Free for All
# Made with love by Jeremie CUADRADO (kuma-consulting)
# version: v1

echo ""
echo ""
echo "################# CERTBOT INSTALL ################"

#domain=`hostname`

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
   echo "m     Mail account for let s encrypte input."
   echo "s     https://acme-v02.api.letsencrypt.org/directory or https://acme-staging-v02.api.letsencrypt.org/directory."
   echo "h     Print this Help."
   echo
}



while getopts ":hd:m:s:" option; do
   case $option in
      d) # Enter a name
         domain=$OPTARG;;
      m) # Mail  account
         mail=$OPTARG;;
      s) # Enter Letsencrypte server
         server_acme=$OPTARG;;
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
if [[ $ID -eq "debian" ]]; then
  sudo apt install -y snapd
  sudo snap install core
  sudo snap refresh core
  sudo snap install --classic certbot
  sudo ln -s /snap/bin/certbot /usr/bin/certbot
  echo ${domain} ${mail}
  certbot certonly --standalone --noninteractive --server ${server_acme} --agree-tos --email ${mail} -d ${domain}
  cp /etc/hosts /etc/hosts.ori
  echo "127.0.0.1 ${domain} localhost" > /etc/hosts
  cp /etc/letsencrypt/live/${domain}/fullchain.pem /etc/cockpit/ws-certs.d/${domain}.crt
  cp /etc/letsencrypt/live/${domain}/privkey.pem /etc/cockpit/ws-certs.d/${domain}.key
  chown cockpit-ws:cockpit-ws /etc/cockpit/ws-certs.d/${domain}.crt /etc/cockpit/ws-certs.d/${domain}.key
  systemctl restart cockpit
fi

if [[ $ID -eq "ubuntu" ]]; then
  sudo snap install core
  sudo snap refresh core
  sudo snap install --classic certbot
  sudo ln -s /snap/bin/certbot /usr/bin/certbot
  echo ${domain} ${mail}
  certbot certonly --standalone --noninteractive --server ${server_acme} --agree-tos --email ${mail} -d ${domain}
  cp /etc/hosts /etc/hosts.ori
  echo "127.0.0.1 ${domain} localhost" > /etc/hosts
  cp /etc/letsencrypt/live/${domain}/fullchain.pem /etc/cockpit/ws-certs.d/${domain}.crt
  cp /etc/letsencrypt/live/${domain}/privkey.pem /etc/cockpit/ws-certs.d/${domain}.key
  chown cockpit-ws:cockpit-ws /etc/cockpit/ws-certs.d/${domain}.crt /etc/cockpit/ws-certs.d/${domain}.key
  systemctl restart cockpit
fi

echo "################# CERTBOT END ################"
echo ""
echo ""