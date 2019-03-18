#!/bin/bash
#
# Title:      PGBlitz (Reference Title File)
# Author(s):  Admin9705
# URL:        https://pgblitz.com - http://github.pgblitz.com
# GNU:        General Public License v3.0
################################################################################
file="/var/pgblitz/pg.number"
if [ -e "$file" ]; then
  check="$(cat /var/pgblitz/pg.number | head -c 1)"
  if [[ "$check" == "5" || "$check" == "6" || "$check" == "7" ]]; then

tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🌎  INSTALLER BLOCK: Notice
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
We detected PG Version $check is running! Per the instructions, PG 8
must be installed on a FRESH BOX! Exiting!
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF
    exit; fi; fi

# Create Variables (If New) & Recall
pcloadletter () {
  touch /var/pgblitz/pgclone.transport
  temp=$(cat /var/pgblitz/pgclone.transport)
    if [ "$temp" == "umove" ]; then transport="PG Move /w No Encryption"
  elif [ "$temp" == "emove" ]; then transport="PG Move /w Encryption"
  elif [ "$temp" == "ublitz" ]; then transport="PG Blitz /w No Encryption"
  elif [ "$temp" == "eblitz" ]; then transport="PG Blitz /w Encryption"
  elif [ "$temp" == "solohd" ]; then transport="PG Local"
  else transport="NOT-SET"; fi
  echo "$transport" > /var/pgblitz/pg.transport
}

variable () {
  file="$1"
  if [ ! -e "$file" ]; then echo "$2" > $1; fi
}

# What Loads the Order of Execution
primestart(){
  pcloadletter
  varstart
  menuprime
}

# When Called, A Quoate is Randomly Selected
quoteselect () {
  bash /opt/pgblitz/menu/start/quotes.sh
  quote=$(cat /var/pgblitz/startup.quote)
  source=$(cat /var/pgblitz/startup.source)
}

varstart() {
  ###################### FOR VARIABLS ROLE SO DOESNT CREATE RED - START
  file="/var/pgblitz"
  if [ ! -e "$file" ]; then
     mkdir -p /var/pgblitz/logs 1>/dev/null 2>&1
     chown -R 0755 /var/pgblitz 1>/dev/null 2>&1
     chmod -R 1000:1000 /var/pgblitz 1>/dev/null 2>&1
  fi

  file="/opt/appdata/pgblitz"
  if [ ! -e "$file" ]; then
     mkdir -p /opt/appdata/pgblitz 1>/dev/null 2>&1
     chown 0755 /opt/appdata/pgblitz 1>/dev/null 2>&1
     chmod 1000:1000 /opt/appdata/pgblitz 1>/dev/null 2>&1
  fi

  ###################### FOR VARIABLS ROLE SO DOESNT CREATE RED - START
  variable /var/pgblitz/pgfork.project "NOT-SET"
  variable /var/pgblitz/pgfork.version "NOT-SET"
  variable /var/pgblitz/tld.program "NOT-SET"
  variable /opt/appdata/pgblitz/plextoken "NOT-SET"
  variable /var/pgblitz/server.ht ""
  variable /var/pgblitz/server.ports "127.0.0.1:"
  variable /var/pgblitz/server.email "NOT-SET"
  variable /var/pgblitz/server.domain "NOT-SET"
  variable /var/pgblitz/tld.type "standard"
  variable /var/pgblitz/transcode.path "standard"
  variable /var/pgblitz/pgclone.transport "NOT-SET"
  variable /var/pgblitz/plex.claim ""

  #### Temp Fix - Fixes Bugged AppGuard
  serverht=$(cat /var/pgblitz/server.ht)
  if [ "$serverht" == "NOT-SET" ]; then
  rm /var/pgblitz/server.ht
  touch /var/pgblitz/server.ht
  fi

  hostname -I | awk '{print $1}' > /var/pgblitz/server.ip
  ###################### FOR VARIABLS ROLE SO DOESNT CREATE RED - END
  echo "export NCURSES_NO_UTF8_ACS=1" >> /etc/bash.bashrc.local

  # run pg main
  file="/var/pgblitz/update.failed"
  if [ -e "$file" ]; then rm -rf /var/pgblitz/update.failed
    exit; fi
  #################################################################################

  # Touch Variables Incase They Do Not Exist
  touch /var/pgblitz/pg.edition
  touch /var/pgblitz/server.id
  touch /var/pgblitz/pg.number
  touch /var/pgblitz/traefik.deployed
  touch /var/pgblitz/server.ht
  touch /var/pgblitz/server.ports
  touch /var/pgblitz/pg.server.deploy

  # For PG UI - Force Variable to Set
  ports=$(cat /var/pgblitz/server.ports)
  if [ "$ports" == "" ]; then echo "Open" > /var/pgblitz/pg.ports
  else echo "Closed" > /var/pgblitz/pg.ports; fi

  ansible --version | head -n +1 | awk '{print $2'} > /var/pgblitz/pg.ansible
  docker --version | head -n +1 | awk '{print $3'} | sed 's/,$//' > /var/pgblitz/pg.docker
  cat /etc/os-release | head -n +5 | tail -n +5 | cut -d'"' -f2 > /var/pgblitz/pg.os

  file="/var/pgblitz/gce.false"
  if [ -e "$file" ]; then echo "No" > /var/pgblitz/pg.gce; else echo "Yes" > /var/pgblitz/pg.gce; fi

  # Call Variables
  edition=$(cat /var/pgblitz/pg.edition)
  serverid=$(cat /var/pgblitz/server.id)
  pgnumber=$(cat /var/pgblitz/pg.number)

  # Declare Traefik Deployed Docker State
  if [[ $(docker ps | grep "traefik") == "" ]]; then
    traefik="NOT DEPLOYED"
    echo "Not Deployed" > /var/pgblitz/pg.traefik
  else
    traefik="DEPLOYED"
    echo "Deployed" > /var/pgblitz/pg.traefik
  fi

  if [[ $(docker ps | grep "oauth") == "" ]]; then
    traefik="NOT DEPLOYED"
    echo "Not Deployed" > /var/pgblitz/pg.auth
  else
    traefik="DEPLOYED"
    echo "Deployed" > /var/pgblitz/pg.oauth
  fi

  # For ZipLocations
  file="/var/pgblitz/data.location"
  if [ ! -e "$file" ]; then echo "/opt/appdata/pgblitz" > /var/pgblitz/data.location; fi

  space=$(cat /var/pgblitz/data.location)
  used=$(df -h /opt/appdata/pgblitz | tail -n +2 | awk '{print $3}')
  capacity=$(df -h /opt/appdata/pgblitz | tail -n +2 | awk '{print $2}')
  percentage=$(df -h /opt/appdata/pgblitz | tail -n +2 | awk '{print $5}')

  # For the PGBlitz UI
  echo "$used" > /var/pgblitz/pg.used
  echo "$capacity" > /var/pgblitz/pg.capacity
}

menuprime() {
# Menu Interface
tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🌎 $transport | Version: $pgnumber | ID: $serverid
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🌵 PG Disk Used Space: $used of $capacity | $percentage Used Capacity
EOF

  # Displays Second Drive If GCE
  edition=$(cat /var/pgblitz/pg.server.deploy)
  if [ "$edition" == "feeder" ]; then
    used_gce=$(df -h /mnt | tail -n +2 | awk '{print $3}')
    capacity_gce=$(df -h /mnt | tail -n +2 | awk '{print $2}')
    percentage_gce=$(df -h /mnt | tail -n +2 | awk '{print $5}')
    echo "   GCE Disk Used Space: $used_gce of $capacity_gce | $percentage_gce Used Capacity"
  fi

  disktwo=$(cat "/var/pgblitz/server.hd.path")
  if [ "$edition" != "feeder" ]; then
    used_gce2=$(df -h "$disktwo" | tail -n +2 | awk '{print $3}')
    capacity_gce2=$(df -h "$disktwo" | tail -n +2 | awk '{print $2}')
    percentage_gce2=$(df -h "$disktwo" | tail -n +2 | awk '{print $5}')

    if [[ "$disktwo" != "/mnt" ]]; then
    echo "   2nd Disk Used Space: $used_gce2 of $capacity_gce2 | $percentage_gce2 Used Capacity"; fi
  fi

  # Declare Ports State
  ports=$(cat /var/pgblitz/server.ports)

  if [ "$ports" == "" ]; then ports="OPEN"
  else ports="CLOSED"; fi

quoteselect

tee <<-EOF

[1]  Traefik   : Reverse Proxy
[2]  Port Guard: [$ports] Protects the Server Ports
[3]  PG Shield : Enable Google's OAuthentication Protection
[4]  PG Clone  : Mount Transport
[5]  PG Box    : Apps ~ Core, Community & Removal
[6]  PG Press  : Deploy WordPress Instances
[7]  PG Vault  : Backup & Restore
[8]  PG Cloud  : GCE & Virtual Instances
[9]  PG Tools
[10] PG Settings
[Z]  Exit

"$quote"

$source
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
  # Standby
read -p '↘️  Type Number | Press [ENTER]: ' typed < /dev/tty

case $typed in
    1 )
      bash /opt/pgblitz/menu/pgcloner/traefik.sh
      primestart ;;
    2 )
      bash /opt/pgblitz/menu/portguard/portguard.sh
      primestart ;;
    3 )
      bash /opt/pgblitz/menu/pgcloner/pgshield.sh
      primestart ;;
    4 )
      bash /opt/pgblitz/menu/pgcloner/pgclone.sh
      primestart ;;
    5 )
      bash /opt/pgblitz/menu/pgbox/pgboxselect.sh
      primestart ;;
    6 )
      bash /opt/pgblitz/menu/pgcloner/pgpress.sh
      primestart ;;
    7 )
      bash /opt/pgblitz/menu/pgcloner/pgvault.sh
      primestart ;;
    8 )
      bash /opt/pgblitz/menu/interface/cloudselect.sh
      primestart ;;
    9 )
      bash /opt/pgblitz/menu/tools/tools.sh
      primestart ;;
    10 )
      bash /opt/pgblitz/menu/interface/settings.sh
      primestart ;;
    z )
      bash /opt/pgblitz/menu/interface/ending.sh
      exit ;;
    Z )
      bash /opt/pgblitz/menu/interface/ending.sh
      exit ;;
    * )
      primestart ;;
esac
}

primestart
