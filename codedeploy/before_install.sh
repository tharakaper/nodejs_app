#!/bin/bash

#This script is executed before copying the source

yum -y update

#curl --silent --location https://rpm.nodesource.com/setup_4.x | bash -
#yum -y install nodejs

curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.32.1/install.sh | bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
nvm install node

npm install -g pm2
pm2 update

export app_root=/usr/cddemo
if [ -d "app_root" ]; then
  rm -rf /usr/cddemo
  mkdir -p /usr/cddemo
else
  mkdir -p /usr/cddemo
fi
