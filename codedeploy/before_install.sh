#!/bin/bash

#This script is executed before copying the source

sudo yum -y update

#curl --silent --location https://rpm.nodesource.com/setup_4.x | bash -
#yum -y install nodejs

sudo touch ~/.bash_profile

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.34.0/install.sh | bash
export NVM_DIR="/root/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

. ~/.nvm/nvm.sh

nvm install node

node -e "console.log('Running Node.js ' + process.version)"

npm install -g pm2
pm2 update

export app_root=/usr/cddemo
if [ -d "app_root" ]; then
  rm -rf /usr/cddemo
  mkdir -p /usr/cddemo
else
  mkdir -p /usr/cddemo
fi