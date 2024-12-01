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


data=(`find /var/log/ -name *.log`);
for log in "${data[@]}"
do
echo "$log clear"
echo > $log
done
data=(`find /var/log/ -name *.err`);
for log in "${data[@]}"
do
echo "$log clear"
echo > $log
done
data=(`find /var/log/ -name mail.*`);
for log in "${data[@]}"
do
echo "$log clear"
echo > $log
done

data=(`find /var/log/ -name *.log`);
for log in "${data[@]}"
do
echo "$log clear"
echo > $log
done

data=(`find /var/log/xray/ -name *.log`);
for log in "${data[@]}"
do
echo "$log clear"
echo > $log
done

data=(`find /var/log/nginx/ -name *.log`);
for log in "${data[@]}"
do
echo "$log clear"
echo > $log
done

data=(`find /var/log/xray/*.log`);
for log in "${data[@]}"
do
echo "$log clear"
echo > $log
done

echo > /var/log/syslog  > /dev/null 2>&1
echo > /var/log/btmp  > /dev/null 2>&1
echo > /var/log/messages  > /dev/null 2>&1
echo > /var/log/debug  > /dev/null 2>&1
echo > /var/log/auth.log  > /dev/null 2>&1
echo > /var/log/alternatives.log  > /dev/null 2>&1
echo > /var/log/cloud-init.log  > /dev/null 2>&1
echo > /var/log/cloud-init-output.log  > /dev/null 2>&1
echo > /var/log/daemon.log  > /dev/null 2>&1
echo > /var/log/dpkg.log  > /dev/null 2>&1
echo > /var/log/droplet-agent.update.log  > /dev/null 2>&1
echo > /var/log/fail2ban.log  > /dev/null 2>&1
echo > /var/log/kern.log  > /dev/null 2>&1
echo > /var/log/user.log  > /dev/null 2>&1
echo > /var/log/stunnel4/stunnel.log  > /dev/null 2>&1
rm /var/log/btmp.*  > /dev/null 2>&1
rm /var/log/debug.*  > /dev/null 2>&1
rm /var/log/messages.*  > /dev/null 2>&1
rm /var/log/syslog.*  > /dev/null 2>&1
rm /var/log/*.log.*  > /dev/null 2>&1
rm /var/log/stunnel4/*.log.*  > /dev/null 2>&1
rm /var/log/nginx/*.log.*  > /dev/null 2>&1
pkill -e bash  > /dev/null 2>&1
