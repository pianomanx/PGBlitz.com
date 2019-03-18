#!/bin/bash
#
# Title:      PGBlitz (Reference Title File)
# Author(s):  Admin9705 - Deiteq - Sub7Seven
# URL:        https://pgblitz.com - http://github.pgblitz.com
# GNU:        General Public License v3.0
################################################################################
echo "dummy" > /var/pgblitz/final.choice

#### Note How to Make It Select a Type - echo "removal" > /var/pgblitz/type.choice
program=$(cat /var/pgblitz/type.choice)

menu=$(echo "on")

while [ "$menu" != "break" ]; do
menu=$(cat /var/pgblitz/final.choice)

### Loads Key Variables
bash /opt/pgblitz/menu/interface/$program/var.sh
### Loads Key Execution
ansible-playbook /opt/pgblitz/menu/core/selection.yml
### Executes Actions
bash /opt/pgblitz/menu/interface/$program/file.sh

### Calls Variable Again - Incase of Break
menu=$(cat /var/pgblitz/final.choice)

if [ "$menu" == "break" ];then
echo ""
echo "---------------------------------------------------"
echo "SYSTEM MESSAGE: User Selected to Exit the Interface"
echo "---------------------------------------------------"
echo ""
sleep .5
fi

done
