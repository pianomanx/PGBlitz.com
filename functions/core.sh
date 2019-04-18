#!/bin/bash
#
# Title:      PGBlitz (Reference Title File)
# Author(s):  Admin9705
# URL:        https://pgblitz.com - http://github.pgblitz.com
# GNU:        General Public License v3.0
################################################################################
pgstore() {

mainfile="/opt/appdata/pgblitz/blitz.json"

if [[ ! -e "${mainfile}" || $(cat $mainfile) == "" ]]; then
  echo "{" > "$mainfile"
  echo "" >> "$mainfile"
  echo "}" >> "$mainfile"
fi

valuecheck=$(cat ${mainfile} | jq ' ."$1"')
if [[ "$valuecheck" == "null" ]]; then
  jq " ."$(echo $1)" = "$2" " ${mainfile}|sponge ${mainfile}; fi

}
