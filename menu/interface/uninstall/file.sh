#!/bin/bash
#
# Title:      PGBlitz (Reference Title File)
# Author(s):  Admin9705 - Deiteq - Sub7Seven
# URL:        https://pgblitz.com - http://github.pgblitz.com
# GNU:        General Public License v3.0
################################################################################
menu=$(cat /var/pgblitz/final.choice)

if [ "$menu" == "2" ]; then
#read -n 1 -s -r -p "Press [ANY KEY] to Continue "

echo ""
echo "-----------------------------------------------------------"
echo "SYSTEM MESSAGE: WARNING! PGBlitz Uninstall Interface!"
echo "-----------------------------------------------------------"
echo ""
sleep 3

while true; do
    read -p "Pay Attention! Do YOU WANT to Continue Uninstalling PG (y or n)!? " yn
    case $yn in
        [Yy]* ) echo ""
                echo "Ok... we are just double checking!"
                sleep 2; break;;
        [Nn]* ) echo "Ok! Exiting the Interface!" && echo "" && sleep 3 && exit;;
        * ) echo "Please answer y or n (for yes or no)";;
    esac
done

  echo ""
  echo "-----------------------------------------------------------"
  echo "SYSTEM MESSAGE: Uninstalling PG! May the Force Be With You!"
  echo "-----------------------------------------------------------"
  echo ""
  sleep 3

  echo "0" > /var/pgblitz/pg.preinstall.stored
  echo "0" > /var/pgblitz/pg.ansible.stored
  echo "0" > /var/pgblitz/pg.rclone.stored
  echo "0" > /var/pgblitz/pg.python.stored
  echo "0" > /var/pgblitz/pg.docker.stored
  echo "0" > /var/pgblitz/pg.docstart.stored
  echo "0" > /var/pgblitz/pg.watchtower.stored
  echo "0" > /var/pgblitz/pg.label.stored
  echo "0" > /var/pgblitz/pg.alias.stored
  echo "0" > /var/pgblitz/pg.dep
  rm -rf /var/pgblitz/dep* 1>/dev/null 2>&1

  echo ""
  echo "-----------------------------------------------------------"
  echo "SYSTEM MESSAGE: Removing All PGBlitz Dependent Services"
  echo "-----------------------------------------------------------"
  echo ""
  sleep 2
  ansible-playbook /opt/pgblitz/menu/interface/uninstall/remove-service.yml

  echo ""
  echo "-----------------------------------------------------------"
  echo "SYSTEM MESSAGE: Removing All PGBlitz File Directories"
  echo "-----------------------------------------------------------"
  echo ""
  sleep 2
  rm -rf /var/pgblitz

  echo ""
  echo "-----------------------------------------------------------"
  echo "SYSTEM MESSAGE: Uninstalling Docker & Generated Containers"
  echo "-----------------------------------------------------------"
  echo ""
  sleep 2
  rm -rf /etc/docker
  apt-get purge docker-ce -y --allow-change-held-packages
  rm -rf /var/lib/docker

  while true; do
      read -p "Pay Attention! Do you want to DELETE /opt/appdata (y or n)? " yn
      case $yn in
          [Yy]* ) echo ""
                  echo "Deleting Your Data Forever - Please Wait!"
                  rm -rf /opt/appdata
                  sleep 3
                  echo "I'm here, I'm there, wait...I'm your DATA! Poof! I'm gone!"
                  sleep 3; break;;
          [Nn]* ) echo "Data Will NOT be deleted!" && break;;
          * ) echo "Please answer y or n (for yes or no)";;
      esac
  done

  echo ""
  echo "---------------------------------------------------"
  echo "SYSTEM MESSAGE: Success! PG Uninstalled! Rebooting!"
  echo "---------------------------------------------------"
  echo ""
  sleep 3
  echo ""
  echo "----------------------------------------------------"
  echo "SYSTEM MESSAGE: PGBlitz Will Never Die! GoodBye!"
  echo "----------------------------------------------------"
  echo ""
  sleep 2
  reboot

fi
