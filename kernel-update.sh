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

source /etc/os-release
OS=$ID

# Memulai Update Kernel
echo "Start Updating Kernel"

# Ubuntu Version
if [[ $OS == 'ubuntu' ]]; then
wget https://raw.githubusercontent.com/pimlie/ubuntu-mainline-kernel.sh/master/ubuntu-mainline-kernel.sh
install ubuntu-mainline-kernel.sh /usr/local/bin/
rm -f ubuntu-mainline-kernel.sh
ubuntu-mainline-kernel.sh -c

# Checking Version
if [ $ver == $now ]; then
echo "Your Kernel Is The Latest Version"A
rm -f /usr/bin/ubuntu-mainline-kernel.sh
exit 0
else
printf "y" | ubuntu-mainline-kernel.sh -i
rm -f /usr/bin/ubuntu-mainline-kernel.sh
fi

# Debian Version
elif [[ $OS == "debian" ]]; then
ver=(`apt-cache search linux-image | grep "^linux-image" | cut -d'-' -f 3-4 |tail -n1`)
now=$(uname -r | cut -d "-" -f 1-2)

# Checking Kernel
if [ $ver == $now ]; then
echo "Your Kernel Is The Latest Version"
exit 0
else
apt install linux-image-$ver-amd64
fi

# Other OS Check
elif [[ $OS == "centos" ]]; then
    echo "Not Supported For Centos!"
    exit 1
elif [[ $OS == "fedora" ]]; then
    echo "Not Supported For Fedora"
    exit 1
else
    echo "Your OS Not Support"
    exit 1
fi

# Done
echo "Your VPS Will Be Reboot In 5s"
sleep 5
reboot
