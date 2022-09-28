#!/bin/bash
# Free for All
# Made with love by Jeremie CUADRADO (kuma-consulting)
# version: v1
echo ""
echo ""
echo "################# SOLR 9.0 INSTALL ################"
git clone https://github.com/FC-Consulting/formation-solr-tp.git /opt/formation-solr-tp
useradd -m -d /opt/formation-solr-tp -s /bin/bash solr
chown -R solr:root /opt/formation-solr-tp
echo "################# SOLR 9.0 END ################"
echo ""
echo ""