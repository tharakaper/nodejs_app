#!/bin/bash

#This script is executed before copying the source

sudo yum -y update

#curl --silent --location https://rpm.nodesource.com/setup_4.x | bash -
#yum -y install nodejs

sudo touch ~/.bash_profile

sudo curl --silent --location https://raw.githubusercontent.com/creationix/nvm/v0.32.1/install.sh | bash
sudo yum -y install nodejs

sudo npm install -g pm2
sudo pm2 update

export app_root=/usr/cddemo
if [ -d "app_root" ]; then
  rm -rf /usr/cddemo
  mkdir -p /usr/cddemo
else
  mkdir -p /usr/cddemo
fi
