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
   echo "t     CloudFlare TOKEN."
   echo "s     https://acme-v02.api.letsencrypt.org/directory or https://acme-staging-v02.api.letsencrypt.org/directory."
   echo "h     Print this Help."
   echo
}



while getopts ":hd:m:t:s:" option; do
   case $option in
      d) # Enter a name
         domain=$OPTARG;;
      m) # Mail  account
         mail=$OPTARG;;
      s) # Enter Letsencrypte server
         server_acme=$OPTARG;;
      t) # Enter Letsencrypte server
         mytoken=$OPTARG;;
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


DOCKER_CMD=`docker version`

if [[ $? -eq 0 ]]; then
  sed -i "s/MYEMAIL/${mail}/g" .env
  sed -i "s/MYACME/${server_acme}/g" .env
  sed -i "s/MYFQDN/${domain}/g" .env
  sed -i "s/MYTOKEN/${mytoken}/g" cloudflare/credentials
  docker compose up

  cp /etc/hosts /etc/hosts.ori
  echo "127.0.0.1 ${domain} localhost" > /etc/hosts
else
  echo "###### NO BIN DOCKER ############"
fi


echo ""
echo ""