#!/bin/bash

#This script is used to stop application
cd /usr/cddemo/app_code
pm2 stop www ||true