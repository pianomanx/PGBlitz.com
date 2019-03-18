#!/bin/bash
#
# Title:      PGBlitz (Reference Title File)
# Author(s):  Admin9705
# URL:        https://pgblitz.com - http://github.pgblitz.com
# GNU:        General Public License v3.0
################################################################################

### FILL OUT THIS AREA ###
echo 'pgui' > /var/pgblitz/pgcloner.rolename
echo 'UI' > /var/pgblitz/pgcloner.roleproper
echo 'BlitzUI' > /var/pgblitz/pgcloner.projectname
echo 'v8.6' > /var/pgblitz/pgcloner.projectversion

### START PROCESS
ansible-playbook /opt/pgblitz/menu/pgcloner/core/primary.yml
