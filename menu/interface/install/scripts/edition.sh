#!/bin/bash
#
# Title:      PGBlitz (Reference Title File)
# Author(s):  Admin9705 - Deiteq
# URL:        https://pgblitz.com - http://github.pgblitz.com
# GNU:        General Public License v3.0
################################################################################

######################################################## Declare Variables
sname="PG Installer: Set PG Edition"
pg_edition=$( cat /var/pgblitz/pg.edition )
pg_edition_stored=$( cat /var/pgblitz/pg.edition.stored )
######################################################## START: PG Log
sudo echo "INFO - Start of Script: $sname" > /var/pgblitz/logs/pg.log
sudo bash /opt/pgblitz/menu/log/log.sh
######################################################## START: Main Script
if [ "$pg_edition" == "$pg_edition_stored" ]; then
  echo "" 1>/dev/null 2>&1
else
  bash /opt/pgblitz/menu/editions/editions.sh
fi
######################################################## END: Main Script
#
#
######################################################## END: PG Log
sudo echo "INFO - END of Script: $sname" > /var/pgblitz/logs/pg.log
sudo bash /opt/pgblitz/menu/log/log.sh
