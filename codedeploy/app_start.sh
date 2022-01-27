#!/bin/bash

#This script is used to start the application
pm2 start /usr/cddemo/app_code/index.js -n www -f
