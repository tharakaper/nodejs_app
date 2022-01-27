#!/bin/bash

#This script is used to start the application
cd /user/cddemo
pm2 start /usr/cddemo/bin/www -n www -f
