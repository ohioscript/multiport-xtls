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

IP=$MYIP
date=$(date +"%Y-%m-%d")
token=$(cat /etc/token_bott | awk '{print $2}')
admin=$(cat /etc/admin_id | awk '{print $2}')
InputPass=123
rm -rf /root/backup
mkdir -p /root/backup
cp /etc/passwd backup/
cp /etc/group backup/
cp /etc/shadow backup/
cp /etc/gshadow backup/
cp -r /etc/wireguard backup/wireguard
cp /etc/shadowsocks-libev/akun.conf backup/ss.conf
cp -r /var/lib/premium-script/ backup/premium-script
cp -r /usr/local/etc/xray backup/xray
cp -r /usr/local/shadowsocksr/ backup/shadowsocksr
cp -r /home/vps/public_html backup/public_html
cd /root
zip -rP $InputPass $IP-$Name-$date.zip backup >/dev/null 2>&1
curl --request POST \
  --url https://api.telegram.org/bot$token/sendDocument?chat_id=$admin \
  --header 'content-type: multipart/form-data' \
  --form document=@/root/$IP-$Name-$date.zip \
  --form 'caption=Here Is Your Backup Files'
clear
rm -rf backup
rm -f /root/$IP-$Name-$date.zip

