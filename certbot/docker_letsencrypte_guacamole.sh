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
   echo "Install let s encrypt from snap."
   echo
   echo "Syntax: scriptTemplate [-d|h]"
   echo "options:"
   echo "d     Domain input."
   echo "m     Mail account for let s encrypt input."
   echo "t     CloudFlare TOKEN."
   echo "s     ACme staging or prod. Don t put the URL"
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
         acme_env=$OPTARG;;
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


if [[ $acme_env -eq "staging" ]]; then # Enter Letsencrypte server
  acme_url="https\:\/\/acme-staging-v02.api.letsencrypt.org\/directory"
elif [[ $acme_env -eq "prod" ]]; then
  acme_url="https\:\/\/acme-v02.api.letsencrypt.org\/directory"
else
  echo "### acme_env doit etre staging ou prod"
  exit 1
fi

DOCKER_CMD=`docker version`

if [[ $? -eq 0 ]]; then
  sed -i "s/MYEMAIL/${mail}/g" .env
  sed -i "s/MYACME/${acme_url}/g" .env
  sed -i "s/MYFQDN/${domain}/g" .env
  sed -i "s/MYTOKEN/${mytoken}/g" cloudflare/credentials
  docker compose up

  sudo cp /etc/hosts /etc/hosts.ori
  #sudo echo "127.0.0.1 ${domain} localhost" > /etc/hosts
else
  echo "###### NO BIN DOCKER ############"
fi

DIR="letsencrypt/live/{domain}"
if [ -d "$DIR" ]; then
  ### Take action if $DIR exists ###
  echo "############ ${DIR} => OK"
  sudo cp -rf letsencrypt /etc/
else
  ###  Control will jump here if $DIR does NOT exists ###
  echo "Error: ${DIR} not found. Can not continue."
  exit 1
fi

echo ""
echo ""