#!/bin/bash
#
# Title:      PGBlitz (Reference Title File)
# Author(s):  Admin9705
# URL:        https://pgblitz.com - http://github.pgblitz.com
# GNU:        General Public License v3.0
################################################################################
mainfile="/opt/appdata/pgblitz/blitz.json"

if [[ ! -e "${mainfile}" || $(cat $mainfile) == "" ]]; then
  echo "{" > "$mainfile"
  echo "" >> "$mainfile"
  echo "}" >> "$mainfile"
fi

varstore="filler"
varvar="5"

valuecheck=$(cat ${mainfile} | jq ' ."${varstore}"')
if [[ "$valuecheck" == "null" ]]; then
  jq ' .$varstore = varvar ' ${mainfile}|sponge ${mainfile}
fi
