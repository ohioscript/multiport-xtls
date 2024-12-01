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
host="http://www.vpnlegasi.com"
gitlink="https://raw.githubusercontent.com/vpnlegasi"
resourses="resources/main/service"
rm -rf /home/.ver > /dev/null 2>&1
serverV=$( curl ${gitlink}/multiport-xtls/main/versi/main | awk '{print $1}')
echo $serverV > /home/.ver
Name=$(curl -sS ${gitlink}/client-$serverV/main/access | grep $MYIP | awk '{print $4}' )
sc=$(cat /home/.ver | awk '{print $1}')
scv=$(cat /home/.ver | awk '{print $2,$3}')
echo "Checking VPS"

PERMISSION () {
cek=$( curl -sS ${gitlink}/client-$serverV/main/access | awk '{print $2}' | grep $MYIP )
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
scexpireddate=$(curl -sS ${gitlink}/client-$serverV/main/access | grep $MYIP | awk '{print $3}' )
period=$(date -d "$scexpireddate" +%s)
today=`date -d "0 days" +"%Y-%m-%d"`
timestamptoday=$(date -d "$today" +%s)
sisa_hari=$(( ($period - $timestamptoday) / 86400 ))

if [ "${EUID}" -ne 0 ]; then
		echo "You need to run this script as root"
		exit 1
fi
if [ "$(systemd-detect-virt)" == "openvz" ]; then
		echo "OpenVZ is not supported"
		exit 1
fi

clear
PERMISSION
echo ""
echo -e "\033[0;34m---------------------------------------------\033[0m"
echo -e "\E[44;1;39m     Premium Server Script By VPN Legasi     \E[0m"
echo -e "\033[0;34m---------------------------------------------\033[0m"
# Make Folder
mkdir -p /var/log/xray
mkdir -p /etc/xray
mkdir /var/lib/premium-script;
sleep 3
clear
echo -e "\033[0;34m---------------------------------------------\033[0m"
echo -e "\E[44;1;39m  Telegram:@vpnlegasi | Script Version: 2.0  \E[0m"
echo -e "\033[0;34m---------------------------------------------\033[0m"
echo -e ""
echo "Proses akan mula dalam 5 Saat!"
sleep 5
clear
echo -e "\033[0;34m---------------------------------------------\033[0m"
echo -e "\E[44;1;39m Sila Masukkan DOMAIN, Jika TIADA KLIK Enter \E[0m"
echo -e "\033[0;34m---------------------------------------------\033[0m"
echo -e ""
read -p " Hostname / Domain: " domain
read -p " Gmail Email : " mail
echo "IP=$domain" >> /var/lib/premium-script/ipvps.conf
echo "$domain" >> /etc/xray/domain
echo "$mail" >> /etc/xray/email
echo "@vpnlegasi" >> /etc/xray/contact
echo "@vpnlegasi" >> /home/contact
clear
echo -e "\033[0;34m---------------------------------------------\033[0m"
echo -e "\E[44;1;39m                Sila Tunggu sebentar         \E[0m"
echo -e "\E[44;1;39m  Process Update & Upgrade Sedang Dijalankan \E[0m"
echo -e "\033[0;34m---------------------------------------------\033[0m"
echo -e ""
sleep 2
apt-get update
apt-get upgrade -y && update-grub -y
apt install netstat -y
apt install neofetch -y
clear
echo -e "\033[0;34m---------------------------------------------\033[0m"
echo -e "\E[44;1;39m        Process Update&Upgrade Selesai       \E[0m"
echo -e "\033[0;34m---------------------------------------------\033[0m"
sleep 2
clear
echo -e "\033[0;34m---------------------------------------------\033[0m"
echo -e "\E[44;1;39m       Installing AutoScript VPN Legasi      \E[0m"
echo -e "\033[0;34m---------------------------------------------\033[0m"
sleep 2
clear
echo -e ""
#install ssh ovpn
echo -e "\033[0;34m---------------------------------------------\033[0m"
echo -e "\E[44;1;39m                 Install SSH OVPN            \E[0m"
echo -e "\033[0;34m---------------------------------------------\033[0m"
sleep 2
wget ${host}/script/${sc}/ssh-vpn.sh && chmod +x ssh-vpn.sh && screen -S ssh-vpn ./ssh-vpn.sh
clear
echo -e ""
#install ssr
echo -e "\033[0;34m---------------------------------------------\033[0m"
echo -e "\E[44;1;39m                   Install SSR               \E[0m"
echo -e "\033[0;34m---------------------------------------------\033[0m"
sleep 2
wget ${host}/script/${sc}/ssr.sh && chmod +x ssr.sh && screen -S ssr ./ssr.sh
wget ${host}/script/${sc}/sodosok.sh && chmod +x sodosok.sh && screen -S ss ./sodosok.sh
clear
echo -e ""
#install wireguard
echo -e "\033[0;34m---------------------------------------------\033[0m"
echo -e "\E[44;1;39m                Install Wireguard            \E[0m"
echo -e "\033[0;34m---------------------------------------------\033[0m"
sleep 2
wget ${host}/script/${sc}/wg.sh && chmod +x wg.sh && screen -S wg ./wg.sh
clear
echo -e ""
#Instal Xray
echo -e "\033[0;34m---------------------------------------------\033[0m"
echo -e "\E[44;1;39m              Install Xray Multiport         \E[0m"
echo -e "\033[0;34m---------------------------------------------\033[0m"
sleep 2
wget ${host}/script/${sc}/xray.sh && chmod +x xray.sh && screen -S xray ./xray.sh
clear
echo -e ""
# install OHP
echo -e "\033[0;34m---------------------------------------------\033[0m"
echo -e "\E[44;1;39m                    Install OHP              \E[0m"
echo -e "\033[0;34m---------------------------------------------\033[0m"
sleep 2
wget ${host}/script/${sc}/ohp.sh && chmod +x ohp.sh && screen -S ohp ./ohp.sh
clear
echo -e ""
clear
# install SSH WEBSOCKET
echo -e "\033[0;34m---------------------------------------------\033[0m"
echo -e "\E[44;1;39m              Install SSH WEBSOCKET          \E[0m"
echo -e "\033[0;34m---------------------------------------------\033[0m"
sleep 2
wget ${host}/script/${sc}/sshws/websocket.sh && chmod +x websocket.sh && screen -S websocket.sh ./websocket.sh
clear
echo -e ""
clear

cat <<EOF> /etc/systemd/system/autosett.service
[Unit]
Description=autosetting
Documentation=https://vpnlegasi.xyz

[Service]
Type=oneshot
ExecStart=/bin/bash /etc/set.sh
RemainAfterExit=yes

[Install]
WantedBy=multi-user.target
EOF
systemctl daemon-reload
systemctl enable autosett
wget -O /etc/set.sh "${host}/script/${sc}/set.sh"
chmod +x /etc/set.sh
history -c
clear
running
sleep 5


setfile() {
rm -rf .profile
cat << EOF >> /root/.profile
# ~/.profile: executed Custom shells by VPN Legasi.

if [ "$BASH" ]; then
  if [ -f ~/.bashrc ]; then
    . ~/.bashrc
  fi
fi

mesg n || true
clear
running
sleep 3
clear
menu
EOF
}

setfile
echo " "
echo -e "\033[0;34m---------------------------------------------\033[0m"
echo -e "\E[44;1;39m      Installation has been completed!!      \E[0m"
echo -e "\033[0;34m---------------------------------------------\033[0m"
sleep 5
clear
echo " "
echo "==============================-{ Autoscript Premium }-==========================" | tee -a log-install.txt
echo "" | tee -a log-install.txt
echo "--------------------------------------------------------------------------------" | tee -a log-install.txt
echo ""  | tee -a log-install.txt
echo "   >>> Service & Port"  | tee -a log-install.txt
echo "   - OpenSSH                   : 22"  | tee -a log-install.txt
echo "   - OpenVPN                   : TCP 1194, UDP 2200"  | tee -a log-install.txt
echo "   - OHP                       : 8000"  | tee -a log-install.txt
echo "   - Stunnel4                  : 888, 777"  | tee -a log-install.txt
echo "   - Dropbear                  : 109, 143"  | tee -a log-install.txt
echo "   - Squid Proxy               : 3128, 8080 (limit to IP Server)"  | tee -a log-install.txt
echo "   - Badvpn                    : 7300"  | tee -a log-install.txt
echo "   - Nginx                     : 81"  | tee -a log-install.txt
echo "   - Wireguard                 : 7070"  | tee -a log-install.txt
echo "   - Shadowsocks-R             : 1443-1543"  | tee -a log-install.txt
echo "   - SS-OBFS TLS               : 2443-2543"  | tee -a log-install.txt
echo "   - SS-OBFS HTTP              : 3443-3543"  | tee -a log-install.txt
echo "   - SSH SSL Websocket         : 443"  | tee -a log-install.txt
echo "   - XRAY XTLS DIRECT          : 443"  | tee -a log-install.txt
echo "   - XRAY XTLS SPLICE          : 443"  | tee -a log-install.txt
echo "   - XRAY Vless TCP TLS        : 443"  | tee -a log-install.txt
echo "   - XRAY Vless WS TLS         : 443"  | tee -a log-install.txt
echo "   - XRAY Vmess WS TLS         : 443"  | tee -a log-install.txt
echo "   - XRAY Trojan TCP           : 443"  | tee -a log-install.txt
echo "   - XRAY Trojan WS TLS        : 443"  | tee -a log-install.txt
echo "   - XRAY Shadowsocks TLS      : 443"  | tee -a log-install.txt
echo "   - SSH Websocket             : 80 "  | tee -a log-install.txt
echo "   - XRAY Vless WS None TLS    : 80"   | tee -a log-install.txt
echo "   - XRAY Vmess WS None TLS    : 80"   | tee -a log-install.txt
echo "   - XRAY Trojan WS None TLS   : 80"   | tee -a log-install.txt
echo "   - XRAY Shadowsocks None TLS : 80"   | tee -a log-install.txt    
echo ""  | tee -a log-install.txt
echo "--------------------------------------------------------------------------------" | tee -a log-install.txt
echo ""  | tee -a log-install.txt
echo "   >>> Server Information & Other Features"  | tee -a log-install.txt
echo "   - Timezone                  : Asia/Kuala_Lumpur (GMT +8)"  | tee -a log-install.txt
echo "   - Fail2Ban                  : [ON]"  | tee -a log-install.txt
echo "   - Dflate                    : [ON]"  | tee -a log-install.txt
echo "   - IPtables                  : [ON]"  | tee -a log-install.txt
echo "   - Auto-Reboot               : [ON]"  | tee -a log-install.txt
echo "   - Auto Backup Status        : [OFF]"  | tee -a log-install.txt
echo "   - IPv6                      : [OFF]"  | tee -a log-install.txt
echo "   - Auto-Remove-Expired       : [ON]" | tee -a log-install.txt
echo "   - Installation Log --> /root/log-install.txt"  | tee -a log-install.txt
echo ""  | tee -a log-install.txt
echo "-----------------------------Script by VPN Legasi-------------------------------" | tee -a log-install.txt
echo ""
sleep 5
echo -e "\033[0;34m---------------------------------------------\033[0m"
echo -e "\E[44;1;39m       SISTEM AKAN REBOOT SEBENTAR LAGI      \E[0m"
echo -e "\033[0;34m---------------------------------------------\033[0m"
echo ""
rm -f /root/setup.sh
rm -f /root/.bash_history
rm -rf install.sh > /dev/null 2>&1
rm -rf *.sh > /dev/null 2>&1
rm -rf /root/versi.txt > /dev/null 2>&1
echo " Reboot in 15 Sec, Setelah ON type menu"
sleep 15
reboot
