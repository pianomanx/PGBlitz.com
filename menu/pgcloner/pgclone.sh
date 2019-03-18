#!/bin/bash
#
# Title:      PGBlitz (Reference Title File)
# Author(s):  Admin9705
# URL:        https://pgblitz.com - http://github.pgblitz.com
# GNU:        General Public License v3.0
################################################################################

### FILL OUT THIS AREA ###
echo 'pgclone' > /var/pgblitz/pgcloner.rolename
echo 'PG Clone' > /var/pgblitz/pgcloner.roleproper
echo 'PGClone' > /var/pgblitz/pgcloner.projectname
echo 'v8.6' > /var/pgblitz/pgcloner.projectversion
echo 'pgclone.sh' > /var/pgblitz/pgcloner.startlink

#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
echo "💬 PG Clone utilizes RClone's Mounts + MergerFS's Union" > /var/pgblitz/pgcloner.info
#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

### START PROCESS
bash /opt/pgblitz/menu/pgcloner/corev2/main.sh
