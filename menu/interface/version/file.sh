#!/bin/bash
#
# Title:      PGBlitz (Reference Title File)
# Author(s):  Admin9705 - Deiteq
# URL:        https://pgblitz.com - http://github.pgblitz.com
# GNU:        General Public License v3.0
################################################################################
rm -rf /var/pgblitz/ver.temp 1>/dev/null 2>&1
touch /var/pgblitz/ver.temp

sleep 4
## Builds Version List for Display
while read p; do
  echo $p >> /var/pgblitz/ver.temp
done </opt/pgblitz/menu/interface/version/version.sh

tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📂  PG Update Interface Menu
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF

cat /var/pgblitz/ver.temp
echo ""
echo "To QUIT, type >>> exit"
break=no
while [ "$break" == "no" ]; do
read -p '↘️  Type [PG Version] | PRESS ENTER: ' typed
storage=$(grep $typed /var/pgblitz/ver.temp)

if [ "$typed" == "exit" ]; then
  echo ""
  touch /var/pgblitz/exited.upgrade
  exit
fi

if [ "$storage" != "" ]; then
  break=yes
  echo $storage > /var/pgblitz/pg.number
  ansible-playbook /opt/pgblitz/menu/interface/version/choice.yml

tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
✅️  SYSTEM MESSAGE: Installed Verison - $storage - Standby!
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
sleep 4
else
tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
⛔️  SYSTEM MESSAGE: Version $storage does not exist! - Standby!
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
  sleep 4
  cat /var/pgblitz/ver.temp
  echo ""
fi

done
