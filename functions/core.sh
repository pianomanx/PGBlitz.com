#!/bin/bash
#
# Title:      PGBlitz (Reference Title File)
# Author(s):  Admin9705
# URL:        https://pgblitz.com - http://github.pgblitz.com
# GNU:        General Public License v3.0
################################################################################
pgstore () {
  maindir="/var/plexguide"
  if [[ ! -e "${maindir}/${1}" ]]; then touch "${maindir}/${1}"; fi
  echo "${2}" > "${maindir}/${1}"
}

pgrecall () {
  maindir="/var/plexguide"
  if [[ ! -e "${maindir}/${1}" ]]; then touch "${maindir}/${1}"; fi
  recallvar=$(cat "${maindir}/${1}")
}

variable () {
  file="$1"
  if [ ! -e "$file" ]; then echo "$2" > $1; fi
}
