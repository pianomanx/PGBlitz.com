#!/bin/bash
#
# Title:      PGBlitz (Reference Title File)
# Author(s):  Admin9705
# URL:        https://pgblitz.com - http://github.pgblitz.com
# GNU:        General Public License v3.0
################################################################################

# FUNCTIONS START ##############################################################
source /opt/pgblitz/menu/functions/functions.sh

rolename=$(cat /var/pgblitz/pgcloner.rolename)
roleproper=$(cat /var/pgblitz/pgcloner.roleproper)
projectname=$(cat /var/pgblitz/pgcloner.projectname)
projectversion=$(cat /var/pgblitz/pgcloner.projectversion)

mkdir -p "/opt/$rolename"

initial () {
  ansible-playbook "/opt/pgblitz/menu/pgcloner/core/primary.yml"
  echo ""
  echo "💬  Pulling Update Files - Please Wait"
  file="/opt/$rolename/place.holder"
  waitvar=0
  while [ "$waitvar" == "0" ]; do
  	sleep .5
  	if [ -e "$file" ]; then waitvar=1; fi
  done
}

custom () {
  mkdir -p "/opt/$rolename"
  ansible-playbook "/opt/pgblitz/menu/pgcloner/core/personal.yml"

  echo ""
  echo "💬  Pulling Update Files - Please Wait"
  file="/opt/$rolename/place.holder"
  waitvar=0
  while [ "$waitvar" == "0" ]; do
  	sleep .5
  	if [ -e "$file" ]; then waitvar=1; fi
  done
}

mainbanner () {
clonerinfo=$(cat /var/pgblitz/pgcloner.info)
tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 $roleproper | 📓 Reference: $rolename.pgblitz.com
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

$clonerinfo

[1] Utilize $roleproper - PGBlitz's
[2] Utilize $roleproper - Personal (Forked)
[Z] Exit

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF

read -p 'Type a Selection | Press [ENTER]: ' typed < /dev/tty

case $typed in
    1 )
        initial ;;
    2 )
        variable /var/pgblitz/$rolename.user "NOT-SET"
        variable /var/pgblitz/$rolename.branch "NOT-SET"
        pinterface ;;
    z )
        exit ;;
    Z )
        exit ;;
    * )
        mainbanner ;;
esac
}

pinterface () {

user=$(cat /var/pgblitz/$rolename.user)
branch=$(cat /var/pgblitz/$rolename.branch)

tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 $roleproper | 📓 Reference: $rolename.pgblitz.com
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

💬 User: $user | Branch: $branch

[1] Change User Name & Branch
[2] Deploy $roleproper - Personal (Forked)
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
Username & Branch are both case sensitive! Make sure to check for the
default or selected branch!
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF
        read -p 'Username | Press [ENTER]: ' user < /dev/tty
        read -p 'Branch   | Press [ENTER]: ' branch < /dev/tty
        echo "$user" > /var/pgblitz/$rolename.user
        echo "$branch" > /var/pgblitz/$rolename.branch
        pinterface ;;
    2 )
        existcheck=$(git ls-remote --exit-code -h "https://github.com/$user/$projectname" | grep "$branch")
        if [ "$existcheck" == "" ]; then echo;
        read -p '💬 Exiting! Forked Version Does Not Exist! | Press [ENTER]: ' typed < /dev/tty
        mainbanner; fi
        custom ;;
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
