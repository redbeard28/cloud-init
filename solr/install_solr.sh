#!/bin/bash
# Free for All
# Made with love by Jeremie CUADRADO (kuma-consulting)
# version: v1
echo ""
echo ""
echo "################# SOLR 9.0 INSTALL ################"
myhost=`hostname`
git clone https://github.com/FC-Consulting/formation-solr-tp.git /opt/formation-solr-tp
useradd -m -d /opt/formation-solr-tp -s /bin/bash solr
chown -R solr:root /opt/formation-solr-tp
sudo apt install -y openjdk-17-jdk lsof nginx
sudo unlink /etc/nginx/sites-enabled/default
sudo rm -rf /etc/nginx/conf.d/* /etc/nginx/sites-enable/* /etc/nginx/sites-available/*
sudo cp default /etc/nginx/sites-available/
sudo ln -s /etc/nginx/sites-available/default  /etc/nginx/sites-enabled/default
sudo cp solr.conf /etc/nginx/conf.d/
sudo sed -i "s/TOTO/${myhost}/g" /etc/nginx/conf.d/solr.conf
sudo systemctl restart nginx
echo "################# SOLR 9.0 END ################"
echo ""
echo ""