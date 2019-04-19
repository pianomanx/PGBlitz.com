#!/bin/bash
#
# Title:      PGBlitz (Reference Title File)
# Author(s):  Admin9705
# URL:        https://pgblitz.com - http://github.pgblitz.com
# GNU:        General Public License v3.0
################################################################################
source /opt/plexguide/functions/core.sh
source /opt/plexguide/fucntions/install.sh

updateprime() {
  abc="/var/plexguide"
  mkdir -p ${abc}
  chmod 0775 ${abc}
  chown 1000:1000 ${abc}

  mkdir -p /opt/appdata/plexguide
  chmod 0775 /opt/appdata/plexguide
  chown 1000:1000 /opt/appdata/plexguide

  variable /var/plexguide/pgfork.project "UPDATE ME"
  variable /var/plexguide/pgfork.version "changeme"
  variable /var/plexguide/tld.program "portainer"
  variable /opt/appdata/plexguide/plextoken ""
  variable /var/plexguide/server.ht ""
  variable /var/plexguide/server.email "NOT-SET"
  variable /var/plexguide/server.domain "NOT-SET"
  variable /var/plexguide/pg.number "New-Install"
  variable /var/plexguide/emergency.log ""
  variable /var/plexguide/pgbox.running ""
  pgnumber=$(cat /var/plexguide/pg.number)

  hostname -I | awk '{print $1}' > /var/plexguide/server.ip
  file="${abc}/server.hd.path"
  if [ ! -e "$file" ]; then echo "/mnt" > ${abc}/server.hd.path; fi

  file="${abc}/new.install"
  if [ ! -e "$file" ]; then newinstall; fi

  ospgversion=$(cat /etc/*-release | grep Debian | grep 9)
  if [ "$ospgversion" != "" ]; then echo "debian"> ${abc}/os.version;
  else echo "ubuntu" > ${abc}/os.version; fi

  # this will be removed soon
  echo "2" > ${abc}/pg.mergerinstall
  echo "52" > ${abc}/pg.pythonstart
  echo "11" > ${abc}/pg.aptupdate
  echo "150" > ${abc}/pg.preinstall
  echo "24" > ${abc}/pg.folders
  echo "15" > ${abc}/pg.dockerinstall
  echo "15" > ${abc}/pg.server
  echo "1" > ${abc}/pg.serverid
  echo "32" > ${abc}/pg.dependency
  echo "11" > ${abc}/pg.docstart
  echo "2" > ${abc}/pg.motd
  echo "115" > ${abc}/pg.alias
  echo "3" > ${abc}/pg.dep
  echo "2" > ${abc}/pg.cleaner
  echo "3" > ${abc}/pg.gcloud
  echo "12" > ${abc}/pg.hetzner
  echo "1" > ${abc}/pg.amazonaws
  echo "8.4" > ${abc}/pg.verionid
  echo "11" > ${abc}/pg.watchtower
  echo "1" > ${abc}/pg.installer
  echo "7" > ${abc}/pg.prune
  echo "20" > ${abc}/pg.mountcheck

}

pginstall () {
  updateprime
  bash /opt/plexguide/menu/pggce/gcechecker.sh
  core pythonstart
  core aptupdate
  core alias_install &>/dev/null &
  core folders
  core dependency
  core mergerinstall
  core dockerinstall
  core docstart


touch /var/plexguide/install.roles
rolenumber=3
  # Roles Ensure that PG Replicates and has once if missing; important for startup, cron and etc
if [[ $(cat /var/plexguide/install.roles) != "$rolenumber" ]]; then
  rm -rf /opt/communityapps
  rm -rf /opt/coreapps
  rm -rf /opt/pgshield

  pgcore
  pgcommunity
  pgshield
  echo "$rolenumber" > /var/plexguide/install.roles
fi

  portainer
  pgui
  core motd &>/dev/null &
  core hetzner &>/dev/null &
  core gcloud
  core cleaner &>/dev/null &
  core serverid
  core watchtower
  core prune
  customcontainers &>/dev/null &
  pgedition
  core mountcheck
  emergency
  pgdeploy
}

core () {
    touch /var/plexguide/pg."${1}".stored
    start=$(cat /var/plexguide/pg."${1}")
    stored=$(cat /var/plexguide/pg."${1}".stored)
    if [ "$start" != "$stored" ]; then
      $1
      cat /var/plexguide/pg."${1}" > /var/plexguide/pg."${1}".stored;
    fi
}

############################################################ INSTALLER FUNCTIONS
mergerinstall () {

  ub16check=$(cat /etc/*-release | grep xenial)
  ub18check=$(cat /etc/*-release | grep bionic)
  deb9check=$(cat /etc/*-release | grep stretch)
  activated=false

    apt --fix-broken install -y
    apt-get remove mergerfs -y
    mkdir -p /var/plexguide

    if [ "$ub16check" != "" ]; then
    activated=true
    echo "ub16" > /var/plexguide/mergerfs.version
    wget "https://github.com/trapexit/mergerfs/releases/download/2.25.1/mergerfs_2.25.1.ubuntu-xenial_amd64.deb"

    elif [ "$ub18check" != "" ]; then
      activated=true
      echo "ub18" > /var/plexguide/mergerfs.version
      wget "https://github.com/trapexit/mergerfs/releases/download/2.25.1/mergerfs_2.25.1.ubuntu-bionic_amd64.deb"

    elif [ "$deb9check" != "" ]; then
      activated=true
      echo "deb9" > /var/plexguide/mergerfs.version
      wget "https://github.com/trapexit/mergerfs/releases/download/2.25.1/mergerfs_2.25.1.debian-stretch_amd64.deb"

    elif [ "$activated" != "true" ]; then
      activated=true && echo "ub18 - but didn't detect correctly" > /var/plexguide/mergerfs.version
      wget "https://github.com/trapexit/mergerfs/releases/download/2.25.1/mergerfs_2.25.1.ubuntu-bionic_amd64.deb"
    else
      apt-get install g++ pkg-config git git-buildpackage pandoc debhelper libfuse-dev libattr1-dev -y
      git clone https://github.com/trapexit/mergerfs.git
      cd mergerfs
      make clean
      make deb
      cd ..
    fi

    apt install -y ./mergerfs*_amd64.deb
    rm mergerfs*_amd64.deb
}

motd () {
  ansible-playbook /opt/plexguide/menu/motd/motd.yml
}

mountcheck () {
  bash /opt/plexguide/menu/pgcloner/solo/pgui.sh
  ansible-playbook /opt/pgui/pgui.yml
  ansible-playbook /opt/plexguide/menu/pgui/mcdeploy.yml

tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
↘️  PG User Interface (PGUI) Installed / Updated
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

INFORMATION:  PGUI is a simple interface that provides information,
warnings, and stats that will assist both yourself and tech support!
To turn this off, goto settings and turn off/on the PG User Interface!

VISIT:
https://pgui.yourdomain.com | http://pgui.domain.com:8555 | ipv4:8555

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
read -p 'Acknowledge Info | Press [ENTER] ' typed < /dev/tty

}

newinstall () {
  rm -rf /var/plexguide/pg.exit 1>/dev/null 2>&1
  file="${abc}/new.install"
  if [ ! -e "$file" ]; then
    touch ${abc}/pg.number && echo off > /tmp/program_source
    bash /opt/plexguide/menu/version/file.sh
    file="${abc}/new.install"
    if [ ! -e "$file" ]; then exit; fi
 fi
}

pgdeploy () {
  touch /var/plexguide/pg.edition
  bash /opt/plexguide/menu/start/start.sh
}

pgedition () {
  file="${abc}/path.check"
  if [ ! -e "$file" ]; then touch ${abc}/path.check && bash /opt/plexguide/menu/dlpath/dlpath.sh; fi
  # FOR PG-BLITZ
  file="${abc}/project.deployed"
    if [ ! -e "$file" ]; then echo "no" > ${abc}/project.deployed; fi
  file="${abc}/project.keycount"
    if [ ! -e "$file" ]; then echo "0" > ${abc}/project.keycount; fi
  file="${abc}/server.id"
    if [ ! -e "$file" ]; then echo "[NOT-SET]" > ${abc}/rm -rf; fi
}

portainer () {
  dstatus=$(docker ps --format '{{.Names}}' | grep "portainer")
  if [ "$dstatus" != "portainer" ]; then
  ansible-playbook /opt/coreapps/apps/portainer.yml &>/dev/null &
  fi
}

# Roles Ensure that PG Replicates and has once if missing; important for startup, cron and etc
pgcore() { if [ ! -e "/opt/coreapps/place.holder" ]; then ansible-playbook /opt/plexguide/menu/pgbox/pgboxcore.yml; fi }
pgcommunity() { if [ ! -e "/opt/communityapps/place.holder" ]; then ansible-playbook /opt/plexguide/menu/pgbox/pgboxcommunity.yml; fi }
pgshield() { if [ ! -e "/opt/pgshield/place.holder" ]; then
echo 'pgshield' > /var/plexguide/pgcloner.rolename
echo 'PGShield' > /var/plexguide/pgcloner.roleproper
echo 'PGShield' > /var/plexguide/pgcloner.projectname
echo 'v8.6' > /var/plexguide/pgcloner.projectversion
echo 'pgshield.sh' > /var/plexguide/pgcloner.startlink
ansible-playbook "/opt/plexguide/menu/pgcloner/corev2/primary.yml"; fi }

pgui ()
{
  file="/var/plexguide/pgui.switch"
    if [ ! -e "$file" ]; then echo "On" > /var/plexguide/pgui.switch; fi

    pguicheck=$(cat /var/plexguide/pgui.switch)
  if [[ "$pguicheck" == "On" ]]; then

    dstatus=$(docker ps --format '{{.Names}}' | grep "pgui")
    if [ "$dstatus" != "pgui" ]; then
    bash /opt/plexguide/menu/pgcloner/solo/pgui.sh
    ansible-playbook /opt/pgui/pgui.yml
    fi
fi
}

pythonstart () {

  ansible="2.7.8"
  pip="19.0.2"

  apt-get install -y --reinstall \
      nano \
      git \
      build-essential \
      libssl-dev \
      libffi-dev \
      python3-dev \
      python3-pip \
      python-dev \
      python-pip
  python3 -m pip install --disable-pip-version-check --upgrade --force-reinstall pip==${pip}
  python3 -m pip install --disable-pip-version-check --upgrade --force-reinstall setuptools
  python3 -m pip install --disable-pip-version-check --upgrade --force-reinstall \
      pyOpenSSL \
      requests \
      netaddr
  python -m pip install --disable-pip-version-check --upgrade --force-reinstall pip==${pip}
  python -m pip install --disable-pip-version-check --upgrade --force-reinstall setuptools
  python -m pip install --disable-pip-version-check --upgrade --force-reinstall ansible==${1-$ansible}

  ## Copy pip to /usr/bin
  cp /usr/local/bin/pip /usr/bin/pip
  cp /usr/local/bin/pip3 /usr/bin/pip3

  mkdir -p /etc/ansible/inventories/ 1>/dev/null 2>&1
  echo "[local]" > /etc/ansible/inventories/local
  echo "127.0.0.1 ansible_connection=local" >> /etc/ansible/inventories/local

  ### Reference: https://docs.ansible.com/ansible/2.4/intro_configuration.html
  echo "[defaults]" > /etc/ansible/ansible.cfg
  echo "command_warnings = False" >> /etc/ansible/ansible.cfg
  echo "callback_whitelist = profile_tasks" >> /etc/ansible/ansible.cfg
  echo "inventory = /etc/ansible/inventories/local" >> /etc/ansible/ansible.cfg

  # Variables Need to Line Up with pg.sh (start)
  touch /var/plexguide/background.1
}

serverid () {
tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
↘️   Establishing Server ID               💬  Use One Word & Keep it Simple
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
read -p '🌏  TYPE Server ID | Press [ENTER]: ' typed < /dev/tty

    if [ "$typed" == "" ]; then
tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
⛔️  WARNING! - The Server ID Cannot Be Blank!
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
  sleep 1
  serverid
else
tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
✅️  PASS: Server ID $typed Established
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
  echo "$typed" > /var/plexguide/server.id
  sleep 1
  fi
}
