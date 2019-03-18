#!/bin/bash
#
# Title:      PGBlitz (Reference Title File)
# Author(s):  Admin9705
# URL:        https://pgblitz.com - http://github.pgblitz.com
# GNU:        General Public License v3.0
################################################################################

# FUNCTIONS START ##############################################################
source /opt/pgblitz/menu/functions/functions.sh

queued () {
echo
read -p '⛔️ ERROR - APP Already Queued! | Press [ENTER] ' typed < /dev/tty
question1
}

exists () {
echo ""
echo "⛔️ ERROR - APP Already Installed!"
read -p '⚠️  Do You Want To ReInstall ~ y or n | Press [ENTER] ' foo < /dev/tty

if [ "$foo" == "y" ]; then part1;
elif [ "$foo" == "n" ]; then question1;
else exists; fi
}

cronexe () {
croncheck=$(cat /opt/coreapps/apps/_cron.list | grep -c "\<$p\>")
if [ "$croncheck" == "0" ]; then bash /opt/pgblitz/menu/cron/cron.sh; fi
}

cronmass () {
croncheck=$(cat /opt/coreapps/apps/_cron.list | grep -c "\<$p\>")
if [ "$croncheck" == "0" ]; then bash /opt/pgblitz/menu/cron/cron.sh; fi
}

initial () {
  rm -rf /var/pgblitz/pgbox.output 1>/dev/null 2>&1
  rm -rf /var/pgblitz/pgbox.buildup 1>/dev/null 2>&1
  rm -rf /var/pgblitz/program.temp 1>/dev/null 2>&1
  rm -rf /var/pgblitz/app.list 1>/dev/null 2>&1
  touch /var/pgblitz/pgbox.output
  touch /var/pgblitz/program.temp
  touch /var/pgblitz/app.list
  touch /var/pgblitz/pgbox.buildup

  bash /opt/coreapps/apps/_appsgen.sh
  docker ps | awk '{print $NF}' | tail -n +2 > /var/pgblitz/pgbox.running
}
# FIRST QUESTION

question1 () {

### Remove Running Apps
while read p; do
  sed -i "/^$p\b/Id" /var/pgblitz/app.list
done </var/pgblitz/pgbox.running

### Blank Out Temp List
rm -rf /var/pgblitz/program.temp && touch /var/pgblitz/program.temp

### List Out Apps In Readable Order (One's Not Installed)
sed -i -e "/templates/d" /var/pgblitz/app.list
touch /tmp/test.99
num=0
while read p; do
  echo -n $p >> /var/pgblitz/program.temp
  echo -n " " >> /var/pgblitz/program.temp
  num=$[num+1]
  if [ "$num" == 7 ]; then
    num=0
    echo " " >> /var/pgblitz/program.temp
  fi
done </var/pgblitz/app.list

notrun=$(cat /var/pgblitz/program.temp)
buildup=$(cat /var/pgblitz/pgbox.output)

if [ "$buildup" == "" ]; then buildup="NONE"; fi
tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 PGBox ~ Multi-App Installer           📓 Reference: pgbox.pgblitz.com
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📂 Potential Apps to Install

$notrun

💾 Apps Queued for Installation

$buildup

💬 Quitting? TYPE > exit | 💪 Ready to install? TYPE > deploy
EOF
read -p '🌍 Type APP for QUEUE | Press [ENTER]: ' typed < /dev/tty

if [ "$typed" == "deploy" ]; then question2; fi

if [ "$typed" == "exit" ]; then exit; fi

current=$(cat /var/pgblitz/pgbox.buildup | grep "\<$typed\>")
if [ "$current" != "" ]; then queued && question1; fi

current=$(cat /var/pgblitz/pgbox.running | grep "\<$typed\>")
if [ "$current" != "" ]; then exists && question1; fi

current=$(cat /var/pgblitz/program.temp | grep "\<$typed\>")
if [ "$current" == "" ]; then badinput1 && question1; fi

part1
}

part1 () {
echo "$typed" >> /var/pgblitz/pgbox.buildup
num=0

touch /var/pgblitz/pgbox.output && rm -rf /var/pgblitz/pgbox.output

while read p; do
echo -n $p >> /var/pgblitz/pgbox.output
echo -n " " >> /var/pgblitz/pgbox.output
if [ "$num" == 7 ]; then
  num=0
  echo " " >> /var/pgblitz/pgbox.output
fi
done </var/pgblitz/pgbox.buildup

sed -i "/^$typed\b/Id" /var/pgblitz/app.list

question1
}

final () {
  read -p '✅ Process Complete! | PRESS [ENTER] ' typed < /dev/tty
  echo
  exit
}

question2 () {

# Image Selector
image=off
while read p; do

echo $p > /tmp/program_var

bash /opt/coreapps/apps/image/_image.sh
done </var/pgblitz/pgbox.buildup

# Cron Execution
edition=$( cat /var/pgblitz/pg.edition )
if [[ "$edition" == "PG Edition - HD Solo" ]]; then a=b
else
  croncount=$(sed -n '$=' /var/pgblitz/pgbox.buildup)
  echo "false" > /var/pgblitz/cron.count
  if [ "$croncount" -ge "2" ]; then bash /opt/pgblitz/menu/cron/mass.sh; fi
fi


while read p; do
tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
$p - Now Installing!
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF

sleep 2.5

if [ "$p" == "plex" ]; then bash /opt/pgblitz/menu/plex/plex.sh;
elif [ "$p" == "nzbthrottle" ]; then nzbt; fi

# Store Used Program
echo $p > /tmp/program_var
# Execute Main Program
ansible-playbook /opt/coreapps/apps/$p.yml

if [[ "$edition" == "PG Edition - HD Solo" ]]; then a=b
else if [ "$croncount" -eq "1" ]; then cronexe; fi; fi

# End Banner
bash /opt/pgblitz/menu/pgbox/endbanner.sh >> /tmp/output.info

sleep 2
done </var/pgblitz/pgbox.buildup
echo "" >> /tmp/output.info
cat /tmp/output.info
final
}

# FUNCTIONS END ##############################################################
echo "" > /tmp/output.info
initial
question1
