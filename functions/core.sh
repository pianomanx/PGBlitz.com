#!/bin/bash
#
# Title:      PGBlitz (Reference Title File)
# Author(s):  Admin9705
# URL:        https://pgblitz.com - http://github.pgblitz.com
# GNU:        General Public License v3.0
################################################################################
pgstore () {

maindir="/home/$blitzuser/var"
if [[ ! -e "${maindir}/${1}" ]]; then touch "${maindir}/${1}"; fi
echo "${2}" > "${maindir}/${1}"
}

maindir="/var/plexguide/"
if [[ ! -e "${maindir}${1}" ]]; then touch "${maindir}${1}"; fi
echo "${2}" > "${maindir}${1}"
}

pgrecall () {

}
