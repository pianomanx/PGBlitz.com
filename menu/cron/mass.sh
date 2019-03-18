#!/bin/bash
#
# Title:      PGBlitz (Reference Title File)
# Author(s):  Admin9705 - Deiteq
# URL:        https://pgblitz.com - http://github.pgblitz.com
# GNU:        General Public License v3.0
#################################################################################

# KEY VARIABLE RECALL & EXECUTION
mkdir -p /var/pgblitz/cron/
mkdir -p /opt/appdata/pgblitz/cron
# FUNCTIONS START ##############################################################
source /opt/pgblitz/menu/functions/functions.sh

weekrandom () {
  while read p; do
  echo "$p" > /tmp/program_var
  echo $(($RANDOM % 23)) > /var/pgblitz/cron/cron.hour
  echo $(($RANDOM % 59)) > /var/pgblitz/cron/cron.minute
  echo $(($RANDOM % 6))> /var/pgblitz/cron/cron.day
  ansible-playbook /opt/pgblitz/menu/cron/cron.yml
  done </var/pgblitz/pgbox.buildup
  exit
}

dailyrandom () {
  while read p; do
  echo "$p" > /tmp/program_var
  echo $(($RANDOM % 23)) > /var/pgblitz/cron/cron.hour
  echo $(($RANDOM % 59)) > /var/pgblitz/cron/cron.minute
  echo "*/1" > /var/pgblitz/cron/cron.day
  ansible-playbook /opt/pgblitz/menu/cron/cron.yml
  done </var/pgblitz/pgbox.buildup
  exit
}

manualuser () {
  while read p; do
  echo "$p" > /tmp/program_var
  bash /opt/pgblitz/menu/cron/cron.sh
  done </var/pgblitz/pgbox.buildup
  exit
}


# FIRST QUESTION
question1 () {
tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
⌛ PG Cron - Schedule Cron Jobs (Backups) | Mass Program Interface
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
⚡ Reference: http://cron.pgblitz.com

1 - No  [Skip   - All Cron Jobs]
2 - Yes [Manual - Select for Each App]
3 - Yes [Daily  - Select Random Times]
4 - Yes [Weekly - Select Random Times & Days]

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF

  read -p '↘️  Type Number | Press [ENTER]: ' typed < /dev/tty
  if [ "$typed" == "1" ]; then exit;
elif [ "$typed" == "2" ]; then manualuser && ansible-playbook /opt/pgblitz/menu/cron/cron.yml;
elif [ "$typed" == "3" ]; then dailyrandom && ansible-playbook /opt/pgblitz/menu/cron/cron.yml;
elif [ "$typed" == "4" ]; then weekrandom && ansible-playbook /opt/pgblitz/menu/cron/cron.yml;
else badinput1; fi
}

question1
