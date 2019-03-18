#!/bin/bash
#
# Title:      PGBlitz (Reference Title File)
# Author(s):  Admin9705 - Deiteq
# URL:        https://pgblitz.com - http://github.pgblitz.com
# GNU:        General Public License v3.0
################################################################################
echo 9 > /var/pgblitz/menu.number

gcloud info | grep Account: | cut -c 10- > /var/pgblitz/project.account

file="/var/pgblitz/project.final"
  if [ ! -e "$file" ]; then
    echo "[NOT SET]" > /var/pgblitz/project.final
  fi

file="/var/pgblitz/project.processor"
  if [ ! -e "$file" ]; then
    echo "NOT-SET" > /var/pgblitz/project.processor
  fi

file="/var/pgblitz/project.location"
  if [ ! -e "$file" ]; then
    echo "NOT-SET" > /var/pgblitz/project.location
  fi

file="/var/pgblitz/project.ipregion"
  if [ ! -e "$file" ]; then
    echo "NOT-SET" > /var/pgblitz/project.ipregion
  fi

file="/var/pgblitz/project.ipaddress"
  if [ ! -e "$file" ]; then
    echo "IP NOT-SET" > /var/pgblitz/project.ipaddress
  fi

file="/var/pgblitz/gce.deployed"
  if [ -e "$file" ]; then
    echo "Server Deployed" > /var/pgblitz/gce.deployed.status
  else
    echo "Not Deployed" > /var/pgblitz/gce.deployed.status
  fi
