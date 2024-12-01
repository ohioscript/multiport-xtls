#!/bin/bash
# Color Validation
DF='\e[39m'
Bold='\e[1m'
Blink='\e[5m'
yell='\e[33m'
red='\e[31m'
green='\e[32m'
blue='\e[34m'
PURPLE='\e[35m'
CYAN='\e[36m'
Lred='\e[91m'
Lgreen='\e[92m'
Lyellow='\e[93m'
NC='\e[0m'
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
CYAN='\e[36m'
LIGHT='\033[0;37m'
ISP=$(curl -s ipinfo.io/org | cut -d " " -f 2-10)
MYIP=$(wget -qO- ipinfo.io/ip);
sc=$(cat /home/.ver | awk '{print $1}')
scv=$(cat /home/.ver | awk '{print $2,$3}')
host="http://www.vpnlegasi.com"
resourses="resources/main/service"
gitlink="https://raw.githubusercontent.com/vpnlegasi"
Name=$(curl -sS ${gitlink}/client-$sc/main/access | grep $MYIP | awk '{print $4}' )
echo "Checking VPS"

PERMISSION () {
cek=$( curl -sS ${gitlink}/client-$sc/main/access | awk '{print $2}' | grep $MYIP )
if [ $cek = $MYIP ]; then
echo -e "${green}Permission Accepted...${NC}"
else
echo -e "${red}Permission Denied!${NC}";
rm -rf *.sh > /dev/null 2>&1
rm -rf *.sh* > /dev/null 2>&1
clear
echo "Your IP NOT REGISTER / EXPIRED | Contact me at Telegram @vpnlegasi to Unlock"
exit 0
fi
clear
}


#SCRIPT EXPIRED DATE
scexpireddate=$(curl -sS ${gitlink}/client-$sc/main/access | grep $MYIP | awk '{print $3}' )
period=$(date -d "$scexpireddate" +%s)
today=`date -d "0 days" +"%Y-%m-%d"`
timestamptoday=$(date -d "$today" +%s)
sisa_hari=$(( ($period - $timestamptoday) / 86400 ))

clear
PERMISSION

clear
echo -e "\033[0;34m------------------------------------\033[0m"
echo -e "\E[44;1;39m            UPDATING SCRIPT         \E[0m"
echo -e "\033[0;34m------------------------------------\033[0m"
 sleep 5
 cd /usr/bin
 wget -O menu "${host}/script/${sc}/menu.sh"
 wget -O autoupdate-sc "${host}/script/${sc}/autoupdate-sc.sh"
 # menu ssh-ovpn
 wget -O menu_ssh "${host}/script/${sc}/menu_ssh.sh"
 # menu ssr
 wget -O m-ssr "${host}/script/${sc}/m-ssr.sh"
 # menu xray
 wget -O menu_xray "${host}/script/${sc}/menu_xray.sh"
 # menu system
 wget -O m-system "${host}/script/${sc}/m-system.sh"
 wget -O clear-log "${host}/script/${sc}/clear-log.sh"
 wget -O running "${host}/script/${sc}/running.sh"
 #xp
 wget -O xp "${host}/script/${sc}/xp.sh"
 #xray custom
 wget -O core_xray "${host}/script/${sc}/core_xray.sh"

 chmod +x menu
 chmod +x autoupdate-sc
 chmod +x menu_ssh
 chmod +x m-ssr
 chmod +x menu_xray
 chmod +x m-system
 chmod +x clear-log
 chmod +x running
 chmod +x xp
 chmod +x core_xray

 cd
rm -rf /home/.ver
serverV=$(curl -sS ${gitlink}/${sc}/main/versi/main | awk '{print $3}')
echo "multiport-xtls version $serverV" > /home/.ver
 clear
 echo " Fix minor Bugs"
 echo " Now You Can Change Port Of Some Services"
sleep 3
