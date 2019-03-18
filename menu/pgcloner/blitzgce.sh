#!/bin/bash
#
# Title:      PGBlitz (Reference Title File)
# Author(s):  Admin9705
# URL:        https://pgblitz.com - http://github.pgblitz.com
# GNU:        General Public License v3.0
################################################################################

### FILL OUT THIS AREA ###
echo 'blitzgce' > /var/pgblitz/pgcloner.rolename
echo 'BlitzGCE' > /var/pgblitz/pgcloner.roleproper
echo 'BlitzGCE' > /var/pgblitz/pgcloner.projectname
echo 'v8.5' > /var/pgblitz/pgcloner.projectversion
echo 'blitzgce.sh' > /var/pgblitz/pgcloner.startlink

#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
echo "💬 Blitz GCE scripts are setup so that users can deploy any
Google Cloud Edition container to act as as feeder between two to
three months!" > /var/pgblitz/pgcloner.info
#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

### START PROCESS
bash /opt/pgblitz/menu/pgcloner/corev2/main.sh
