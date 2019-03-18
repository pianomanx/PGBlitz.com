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

  mkdir -p /opt/coreapps

  if [ "$boxversion" == "official" ]; then ansible-playbook /opt/pgblitz/menu/pgbox/pgboxcore.yml
  else ansible-playbook /opt/pgblitz/menu/pgbox/pgbox_corepersonal.yml; fi

  echo ""
  echo "💬  Pulling Update Files - Please Wait"
  file="/opt/coreapps/place.holder"
  waitvar=0
  while [ "$waitvar" == "0" ]; do
  	sleep .5
  	if [ -e "$file" ]; then waitvar=1; fi
  done

}

question1 () {

  ### Remove Running Apps
  while read p; do
    sed -i "/^$p\b/Id" /var/pgblitz/app.list
  done </var/pgblitz/pgbox.running

  cp /var/pgblitz/app.list /var/pgblitz/app.list2

  file="/var/pgblitz/core.app"
  #if [ ! -e "$file" ]; then
    ls -la /opt/coreapps/apps | sed -e 's/.yml//g' \
    | awk '{print $9}' | tail -n +4  > /var/pgblitz/app.list
  while read p; do
    echo "" >> /opt/coreapps/apps/$p.yml
    echo "##PG-Core" >> /opt/coreapps/apps/$p.yml

    mkdir -p /opt/mycontainers
    touch /opt/appdata/pgblitz/rclone.conf
  done </var/pgblitz/app.list
    touch /var/pgblitz/core.app
  #fi

#bash /opt/coreapps/apps/_appsgen.sh
docker ps | awk '{print $NF}' | tail -n +2 > /var/pgblitz/pgbox.running

### Remove Official Apps
while read p; do
  # reminder, need one for custom apps
  baseline=$(cat /opt/coreapps/apps/$p.yml | grep "##PG-Core")
  if [ "$baseline" == "" ]; then sed -i -e "/$p/d" /var/pgblitz/app.list; fi
done </var/pgblitz/app.list

### Blank Out Temp List
rm -rf /var/pgblitz/program.temp && touch /var/pgblitz/program.temp

### List Out Apps In Readable Order (One's Not Installed)
num=0
sed -i -e "/templates/d" /var/pgblitz/app.list
sed -i -e "/image/d" /var/pgblitz/app.list
sed -i -e "/_/d" /var/pgblitz/app.list
while read p; do
  echo -n $p >> /var/pgblitz/program.temp
  echo -n " " >> /var/pgblitz/program.temp
  num=$[num+1]
  if [[ "$num" == "7" ]]; then
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

💬 Quitting? TYPE > exit | 💪 Ready to Install? TYPE > deploy
EOF
read -p '🌍 Type APP for QUEUE | Press [ENTER]: ' typed < /dev/tty

if [[ "$typed" == "deploy" ]]; then question2; fi

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
if [[ "$num" == 7 ]]; then
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

pinterface () {

boxuser=$(cat /var/pgblitz/boxcore.user)
boxbranch=$(cat /var/pgblitz/boxcore.branch)

tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 PG Core Box Edition!                   📓 Reference: core.pgblitz.com
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

💬 User: $boxuser | Branch: $boxbranch

[1] Change User Name & Branch
[2] Deploy Core Box - Personal (Forked)
[Z] Exit

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF

read -p 'Type a Selection | Press [ENTER]: ' typed < /dev/tty

case $typed in
    1 )
tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
💬 IMPORTANT MESSAGE
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Username & Branch are both case sensitive! Normal default branch is v8,
but check the branch under your fork that is being pulled!
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF
        read -p 'Username | Press [ENTER]: ' boxuser < /dev/tty
        read -p 'Branch   | Press [ENTER]: ' boxbranch < /dev/tty
        echo "$boxuser" > /var/pgblitz/boxcore.user
        echo "$boxbranch" > /var/pgblitz/boxcore.branch
        pinterface ;;
    2 )
        existcheck=$(git ls-remote --exit-code -h "https://github.com/$boxuser/PGBlitz-Core" | grep "$boxbranch")
        if [ "$existcheck" == "" ]; then echo;
        read -p '💬 Exiting! Forked Version Does Not Exist! | Press [ENTER]: ' typed < /dev/tty
        mainbanner; fi

        boxversion="personal"
        initial
        question1 ;;
    z )
        exit ;;
    Z )
        exit ;;
    * )
        mainbanner ;;
esac
}

mainbanner () {
tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 PG Core Box Edition!                   📓 Reference: core.pgblitz.com
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

💬 Core Box apps simplify their usage within PGBlitz! PG provides more
focused support and development based on core usage.

💬 The Personal Forked option will install your version of Core Box. Good
for testing or for personal mods! Ensure that it exist prior to use!

[1] Utilize Core Box - PGBlitz's
[2] Utilize Core Box - Personal (Forked)
[Z] Exit

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF

read -p 'Type a Selection | Press [ENTER]: ' typed < /dev/tty

case $typed in
    1 )
        boxversion="official"
        initial
        question1 ;;
    2 )
        variable /var/pgblitz/boxcore.user "NOT-SET"
        variable /var/pgblitz/boxcore.branch "NOT-SET"
        pinterface ;;
    z )
        exit ;;
    Z )
        exit ;;
    * )
        mainbanner ;;
esac
}

# FUNCTIONS END ##############################################################
echo "" > /tmp/output.info
mainbanner
