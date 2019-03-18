#!/bin/bash
#
# Title:      PGBlitz (Reference Title File)
# Author(s):  Admin9705
# URL:        https://pgblitz.com - http://github.pgblitz.com
# GNU:        General Public License v3.0
################################################################################

### FILL OUT THIS AREA ###
echo 'pgshield' > /var/pgblitz/pgcloner.rolename
echo 'PGShield' > /var/pgblitz/pgcloner.roleproper
echo 'PGShield' > /var/pgblitz/pgcloner.projectname
echo 'v8.5.6' > /var/pgblitz/pgcloner.projectversion
echo 'pgshield.sh' > /var/pgblitz/pgcloner.startlink

#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
echo "💬 PG Shield protects users by deploying adding Google
Authentication to all the containers for protection!" > /var/pgblitz/pgcloner.info
#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

### START PROCESS
bash /opt/pgblitz/menu/pgcloner/corev2/main.sh
