#!/bin/bash
#
# Title:      PGBlitz (Reference Title File)
# Author(s):  Admin9705
# URL:        https://pgblitz.com - http://github.pgblitz.com
# GNU:        General Public License v3.0
################################################################################

### FILL OUT THIS AREA ###
echo 'pgpatrol' > /var/pgblitz/pgcloner.rolename
echo 'PGPatrol' > /var/pgblitz/pgcloner.roleproper
echo 'PGPatrol' > /var/pgblitz/pgcloner.projectname
echo 'v8.5' > /var/pgblitz/pgcloner.projectversion
echo 'v8.5' > /var/pgblitz/pgcloner.projectversion

#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
echo "💬 PG Patrol can boot idle plex users, users utilizing multiple
ips (sharing the server), and much more!" > /var/pgblitz/pgcloner.info
#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

### START PROCESS
bash /opt/pgblitz/menu/pgcloner/corev2/main.sh
