#!/bin/bash
#
# Title:      PGBlitz (Reference Title File)
# Author(s):  Admin9705 - Deiteq
# URL:        https://pgblitz.com - http://github.pgblitz.com
# GNU:        General Public License v3.0
################################################################################
source /opt/pgblitz/menu/functions/functions.sh
source /opt/pgblitz/menu/functions/install.sh

sudocheck() {
if [[ $EUID -ne 0 ]]; then
tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
⛔️  You Must Execute as a SUDO USER (with sudo) or as ROOT!
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF
exit 1
fi
}

downloadpg() {
  rm -rf /opt/pgblitz
  git clone https://github.com/PGBlitz/PGBlitz.com.git /opt/pgblitz && cp /opt/pgblitz/menu/interface/alias/templates/pgblitz /bin/
  cp /opt/pgblitz/menu/interface/alias/templates/pgblitz /bin/pgblitz
}

missingpull() {
file="/opt/pgblitz/menu/functions/install.sh"
if [ ! -e "$file" ]; then
tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
⛔️  /opt/pgblitz went missing!
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF
  sleep 2
tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 🍖  NOM NOM - Re-Downloading PGBlitz for BoneHead User!
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
sleep 2
  downloadpg
tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
✅️  Repair Complete! Standby!
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF
  sleep 2
  fi
}

exitcheck() {
bash /opt/pgblitz/menu/version/file.sh
file="/var/pgblitz/exited.upgrade"
if [ ! -e "$file" ]; then
	bash /opt/pgblitz/menu/interface/ending.sh
else
	rm -rf /var/pgblitz/exited.upgrade 1>/dev/null 2>&1
	echo ""
	bash /opt/pgblitz/menu/interface/ending.sh
fi
}
