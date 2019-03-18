#!/bin/bash
#
# Title:      PGBlitz (Reference Title File)
# Author(s):  Admin9705 - Deiteq
# URL:        https://pgblitz.com - http://github.pgblitz.com
# GNU:        General Public License v3.0
################################################################################

# Menu Interface
tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚥 PG TroubleShoot Interface
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

1 - Pre-Installer: Force the Entire Process Again
2 - UnInstaller  : Docker & Running Containers | Force Pre-Install
3 - UnInstaller  : PGBlitz
Z - Exit

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF

# Standby
read -p 'Type a Number | Press [ENTER]: ' typed < /dev/tty

  if [ "$typed" == "1" ]; then
tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🍖  NOM NOM - Resetting the Starting Variables!
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
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
    echo "0" > /var/pgblitz/pg.dep.stored

tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
✅️ WOOT WOOT - Process Complete! Exit & Restart PGBlitz Now!
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
sleep 5

elif [ "$typed" == "2" ]; then
tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🍖  NOM NOM - Uninstalling Docker & Resetting the Variables!
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
sleep 3

  rm -rf /etc/docker
  apt-get purge docker-ce
  rm -rf /var/lib/docker
  rm -rf /var/pgblitz/dep*
  echo "0" > /var/pgblitz/pg.preinstall.stored
  echo "0" > /var/pgblitz/pg.ansible.stored
  echo "0" > /var/pgblitz/pg.rclone.stored
  echo "0" > /var/pgblitz/pg.python.stored
  echo "0" > /var/pgblitz/pg.docstart.stored
  echo "0" > /var/pgblitz/pg.watchtower.stored
  echo "0" > /var/pgblitz/pg.label.stored
  echo "0" > /var/pgblitz/pg.alias.stored
  echo "0" > /var/pgblitz/pg.dep

tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
✅️ WOOT WOOT - Process Complete! Exit & Restart PGBlitz Now!
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
sleep 5
elif [ "$typed" == "3" ]; then
tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🍖  NOM NOM - Starting the PG UnInstaller
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
sleep 3

  echo "uninstall" > /var/pgblitz/type.choice && bash /opt/pgblitz/menu/core/scripts/main.sh
elif [[ "$typed" == "Z" || "$typed" == "z" ]]; then
  exit
else
  bash /opt/pgblitz/menu/tshoot/tshoot.sh
  exit
fi

bash /opt/pgblitz/menu/tshoot/tshoot.sh
exit
