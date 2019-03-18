#!/bin/bash
#
# Title:      PGBlitz (Reference Title File)
# Author(s):  Admin9705
# URL:        https://pgblitz.com - http://github.pgblitz.com
# GNU:        General Public License v3.0
################################################################################

### FILL OUT THIS AREA ###
echo 'pgvault' > /var/pgblitz/pgcloner.rolename
echo 'PG Vault' > /var/pgblitz/pgcloner.roleproper
echo 'PGVault' > /var/pgblitz/pgcloner.projectname
echo 'v8.6' > /var/pgblitz/pgcloner.projectversion
echo 'pgvault.sh' > /var/pgblitz/pgcloner.startlink

#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
echo "💬 PG Vault is a combined group of services that utilizes the backup
and restore processes, which enables the safe storage and transport through
the use of Google Drive in a hasty and efficient manner!" > /var/pgblitz/pgcloner.info
#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

### START PROCESS
bash /opt/pgblitz/menu/pgcloner/corev2/main.sh
