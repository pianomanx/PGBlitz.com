#!/bin/bash
#
# Title:      PGBlitz (Reference Title File)
# Author(s):  Admin9705
# URL:        https://pgblitz.com - http://github.pgblitz.com
# GNU:        General Public License v3.0
################################################################################

### FILL OUT THIS AREA ###
echo 'hetzner' > /var/pgblitz/pgcloner.rolename
echo 'HCloud (Hetzner)' > /var/pgblitz/pgcloner.roleproper
echo 'Hetzner' > /var/pgblitz/pgcloner.projectname
echo 'v8.5' > /var/pgblitz/pgcloner.projectversion
echo 'hcloud.sh' > /var/pgblitz/pgcloner.startlink

#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
echo "💬 HCloud in conjuction with PGBlitz enables users to
deploy Hetzner Cloud Instance (VMs) within seconds" > /var/pgblitz/pgcloner.info
#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

### START PROCESS
bash /opt/pgblitz/menu/pgcloner/corev2/main.sh
