#!/bin/bash
#
# Title:      PGBlitz (Reference Title File)
# Author(s):  Admin9705 - Deiteq
# URL:        https://pgblitz.com - http://github.pgblitz.com
# GNU:        General Public License v3.0
################################################################################
mkdir -p /opt/appdata/pgblitz/emergency
mkdir -p /opt/appdata/pgblitz
rm -rf /opt/appdata/pgblitz/emergency/*
sleep 15
diskspace27=0

while true
do

# GDrive
if [[ $(rclone lsd --config /opt/appdata/pgblitz/rclone.conf gdrive: | grep "\<pgblitz\>") == "" ]]; then
  echo "🔴 Not Operational "> /var/pgblitz/pg.gdrive; else echo "✅ Operational " > /var/pgblitz/pg.gdrive; fi

if [[ $(ls -la /mnt/gdrive | grep "pgblitz") == "" ]]; then
  echo "🔴 Not Operational"> /var/pgblitz/pg.gmount; else echo "✅ Operational" > /var/pgblitz/pg.gmount; fi

# TDrive
if [[ $(rclone lsd --config /opt/appdata/pgblitz/rclone.conf tdrive: | grep "\<pgblitz\>") == "" ]]; then
  echo "🔴 Not Operational"> /var/pgblitz/pg.tdrive; else echo "✅ Operational" > /var/pgblitz/pg.tdrive; fi

if [[ $(ls -la /mnt/tdrive | grep "pgblitz") == "" ]]; then
  echo "🔴 Not Operational "> /var/pgblitz/pg.tmount; else echo "✅ Operational" > /var/pgblitz/pg.tmount; fi

# Union
if [[ $(rclone lsd --config /opt/appdata/pgblitz/rclone.conf pgunion: | grep "\<pgblitz\>") == "" ]]; then
  echo "🔴 Not Operational "> /var/pgblitz/pg.union; else echo "✅ Operational" > /var/pgblitz/pg.union; fi

if [[ $(ls -la /mnt/unionfs | grep "pgblitz") == "" ]]; then
  echo "🔴 Not Operational "> /var/pgblitz/pg.umount; else echo "✅ Operational " > /var/pgblitz/pg.umount; fi

# Disk Calculations - 4000000 = 4GB

leftover=$(df /opt/appdata/pgblitz | tail -n +2 | awk '{print $4}')


if [[ "$leftover" -lt "3000000" ]]; then
  diskspace27=1
  echo "Emergency: Primary DiskSpace Under 3GB - Stopped Media Programs & Downloading Programs (i.e. Plex, NZBGET, RuTorrent)" > /opt/appdata/pgblitz/emergency/message.1
  docker stop plex 1>/dev/null 2>&1
  docker stop emby 1>/dev/null 2>&1
  docker stop jellyfin 1>/dev/null 2>&1
  docker stop nzbget 1>/dev/null 2>&1
  docker stop sabnzbd 1>/dev/null 2>&1
  docker stop rutorrent 1>/dev/null 2>&1
  docker stop deluge 1>/dev/null 2>&1
  docker stop qbitorrent 1>/dev/null 2>&1
elif [[ "$leftover" -gt "3000000" && "$diskspace27" == "1" ]]; then
  docker start plex 1>/dev/null 2>&1
  docker start emby 1>/dev/null 2>&1
  docker start jellyfin 1>/dev/null 2>&1
  docker start nzbget 1>/dev/null 2>&1
  docker start sabnzbd 1>/dev/null 2>&1
  docker start rutorrent 1>/dev/null 2>&1
  docker start deluge 1>/dev/null 2>&1
  docker start qbitorrent 1>/dev/null 2>&1
  rm -rf /opt/appdata/pgblitz/emergency/message.1
  diskspace27=0
fi

##### Warning for Ports Open with Traefik Deployed
if [[ $(cat /var/pgblitz/pg.ports) != "Closed" && $(docker ps --format '{{.Names}}' | grep "traefik") == "traefik" ]]; then
  echo "Warning: Traefik deployed with ports open! Server at risk for explotation!" > /opt/appdata/pgblitz/emergency/message.a
elif [ -e "/opt/appdata/pgblitz/emergency/message.a" ]; then rm -rf /opt/appdata/pgblitz/emergency/message.a; fi

if [[ $(cat /var/pgblitz/pg.ports) == "Closed" && $(docker ps --format '{{.Names}}' | grep "traefik") == "" ]]; then
  echo "Warning: Apps Cannot Be Accessed! Ports are Closed & Traefik is not enabled! Either deploy traefik or open your ports (which is worst for security)" > /opt/appdata/pgblitz/emergency/message.b
elif [ -e "/opt/appdata/pgblitz/emergency/message.b" ]; then rm -rf /opt/appdata/pgblitz/emergency/message.b; fi
##### Warning for Bad Traefik Deployment - message.c is tied to traefik showing a status! Do not change unless you know what your doing
touch /opt/appdata/pgblitz/traefik.check
domain=$(cat /var/pgblitz/server.domain)
wget -q "https://portainer.${domain}" -O "/opt/appdata/pgblitz/traefik.check"
if [[ $(cat /opt/appdata/pgblitz/traefik.check) == "" && $(docker ps --format '{{.Names}}' | grep traefik) == "traefik" ]]; then
  echo "Traefik is Not Deployed Properly! Cannot Reach the Portainer SubDomain!" > /opt/appdata/pgblitz/emergency/message.c
else
  if [ -e "/opt/appdata/pgblitz/emergency/message.c" ]; then
  rm -rf /opt/appdata/pgblitz/emergency/message.c; fi
fi
##### Warning for Traefik Rate Limit Exceeded
if [[ $(cat /opt/appdata/pgblitz/traefik.check) == "" && $(docker logs traefik | grep "rateLimited") != "" ]]; then
  echo "$domain's rated limited exceed | Traefik (LetsEncrypt)! Takes upto one week to clear up (or use a new domain)" > /opt/appdata/pgblitz/emergency/message.d
else
  if [ -e "/opt/appdata/pgblitz/emergency/message.d" ]; then
  rm -rf /opt/appdata/pgblitz/emergency/message.d; fi
fi

################# Generate Output
echo "" > /var/pgblitz/emergency.log

if [[ $(ls /opt/appdata/pgblitz/emergency) != "" ]]; then
countmessage=0
while read p; do
  let countmessage++
  echo -n "${countmessage}. " >> /var/pgblitz/emergency.log
  echo "$(cat /opt/appdata/pgblitz/emergency/$p)" >> /var/pgblitz/emergency.log
done <<< "$(ls /opt/appdata/pgblitz/emergency)"
else
  echo "NONE" > /var/pgblitz/emergency.log
fi

sleep 5
done
