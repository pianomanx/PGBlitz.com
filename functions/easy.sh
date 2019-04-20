#!/bin/bash
#
# Title:      PGBlitz (Reference Title File)
# Author(s):  Admin9705
# URL:        https://pgblitz.com - http://github.pgblitz.com
# GNU:        General Public License v3.0
################################################################################
source /opt/pgblitz/functions/core.sh
source /opt/pgblitz/functions/easy.sh

easyinstall () {

# menu interface for our special users :D
tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📂 Blitz Fast Install ~ Welcome to PGBlitz!
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

💬 NOTE: Visiting Settings to Make Future Changes!

1 - YES: Fast Install
2 - NO : Standard Process
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF

read -p 'Type a Number | Press [ENTER]: ' typed < /dev/tty

if [[ "$typed" == "1" ]]; then
  # presetting a variable to hasten the install process
  easy="on"
elif [[ "$typed" == "2" ]]; then
  # nothing happens because easy by default is off
else easyinstall; fi
  # user will naturally exit this interface once a change is made
}
