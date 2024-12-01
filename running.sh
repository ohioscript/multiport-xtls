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

# // Exporting IP Address
export IP=$( curl -s https://ipinfo.io/ip/ )
# // OpenSSH
openssh=$( systemctl status ssh | grep Active | awk '{print $3}' | sed 's/(//g' | sed 's/)//g' )
if [[ $openssh == "running" ]]; then
    status_openssh="${GREEN}Running${NC}"
else
    status_openssh="${RED}Error${NC}"
fi
# // Stunnel5
stunnel5=$( systemctl status stunnel4 | grep Active | awk '{print $3}' | sed 's/(//g' | sed 's/)//g' )
if [[ $stunnel5 == "running" ]]; then
    status_stunnel5="${GREEN}Running${NC}"
else
    status_stunnel5="${RED}Error${NC}"
fi
# // Dropbear
dropbear=$( systemctl status dropbear | grep Active | awk '{print $3}' | sed 's/(//g' | sed 's/)//g' )
if [[ $dropbear == "running" ]]; then
    status_dropbear="${GREEN}Running${NC}"
else
    status_dropbear="${RED}Error${NC}"
fi
# // Squid
squid=$( systemctl status squid | grep Active | awk '{print $3}' | sed 's/(//g' | sed 's/)//g' )
if [[ $squid == "running" ]]; then
    status_squid="${GREEN}Running${NC}"
else
    status_squid="${RED}Error${NC}"
fi

# // Vless XTLS Proxy
xt="$(systemctl show xray --no-page)"
xtls=$(echo "${xt}" | grep 'ActiveState=' | cut -f2 -d=)
if [[ $xtls == "active" ]]; then
    status_vlessxtls="${GREEN}Running${NC}"
else
    status_vlessxtls="${RED}Error${NC}"
fi

# // Vless Websocket Proxy
vl="$(systemctl show xray --no-page)"
vless=$(echo "${vl}" | grep 'ActiveState=' | cut -f2 -d=)
if [[ $vless == "active" ]]; then
    status_vlessws="${GREEN}Running${NC}"
else
    status_vlessws="${RED}Error${NC}"
fi

# // Vmess Websocket Proxy
vm="$(systemctl show xray@vmess --no-page)"
vmess=$(echo "${vm}" | grep 'ActiveState=' | cut -f2 -d=)
if [[ $vmess == "active" ]]; then
    status_vmessws="${GREEN}Running${NC}"
else
    status_vmessws="${RED}Error${NC}"
fi

# // Trojan TCPProxy
tc="$(systemctl show xray@trojan --no-page)"
tcp=$(echo "${tc}" | grep 'ActiveState=' | cut -f2 -d=)
if [[ $tcp == "active" ]]; then
    status_trojantcp="${GREEN}Running${NC}"
else
    status_trojantcp="${RED}Error${NC}"
fi

# // Trojan Proxy
tro="$(systemctl show xray@trojan --no-page)"
trojan=$(echo "${tro}" | grep 'ActiveState=' | cut -f2 -d=)
if [[ $trojan == "active" ]]; then
    status_trojanws="${GREEN}Running${NC}"
else
    status_trojanws="${RED}Error${NC}"
fi

#sshws https
sshwshttps="$(systemctl show ws-https --no-page)"
sshwstls=$(echo "${sshwshttps}" | grep 'ActiveState=' | cut -f2 -d=)
if [[ $sshwstls == "active" ]]; then
    status_sshwstls="${GREEN}Running${NC}"
else
    status_sshwstls="${RED}Error${NC}"
fi

#sshws http
sshwshttp="$(systemctl show ws-http --no-page)"
sshwsntls=$(echo "${sshwshttp}" | grep 'ActiveState=' | cut -f2 -d=)
if [[ $sshwsntls == "active" ]]; then
    status_sshwsntls="${GREEN}Running${NC}"
else
    status_sshwsntls="${RED}Error${NC}"
fi

# // NGINX
ngi="$(systemctl show nginx --no-page)"
nginx1=$(echo "${ngi}" | grep 'ActiveState=' | cut -f2 -d=)
if [[ $nginx1 == "active" ]]; then
    status_nginx="${GREEN}Running${NC}"
else
    status_nginx="${RED}Error${NC}"
fi


# // Wireguard
swg="$(systemctl show wg-quick@wg0.service --no-page)"
wg=$(echo "${swg}" | grep 'ActiveState=' | cut -f2 -d=)
if [[ $wg == "active" ]]; then
    status_wg="${GREEN}Running${NC}"
else
    status_wg="${RED}Error${NC}"
fi

# // Xray Shadowsocks
shadowsock="$(systemctl show xray@shadowsocks --no-page)"
shadowsocks=$(echo "${shadowsock}" | grep 'ActiveState=' | cut -f2 -d=)
if [[ $shadowsocks == "active" ]]; then
    status_shadowsocks="${GREEN}Running${NC}"
else
    status_shadowsocks="${RED}Error${NC}"
fi

# // Adguards Status
if [[ ! -z $(which dnsmasq) ]] && [[ -e /etc/dnsmasq ]]; then
 ads="$(systemctl show dnsmasq --no-page)"
 adsguard=$(echo "${ads}" | grep 'ActiveState=' | cut -f2 -d=)
 if [[ $adsguard == "active" ]]; then
     status_adsguard="${GREEN}Running${NC}"
 else
     status_adsguard="${RED}Error${NC}"
 fi
else
    status_adsguard="${RED}Not Install${NC}"
fi

# // Clear
clear
echo -e "\033[0;34m-------------------------------\033[0m"
echo -e "\E[44;1;39m   STATUS SERVICE INFORMATION  \E[0m"
echo -e "\033[0;34m-------------------------------\033[0m"
echo -e "Sever Uptime          : $( uptime -p  | cut -d " " -f 2-10000 ) "
echo -e "Current Time          : $( date -d "0 days" +"%d-%m-%Y %X" )"
echo -e "\033[0;34m-------------------------------\033[0m"
echo -e "\E[44;1;39m      SERVICE INFORMATION      \E[0m"
echo -e "\033[0;34m-------------------------------\033[0m"
echo -e "Wireguard             : $status_wg"
echo -e "OpenSSH               : $status_openssh"
echo -e "Dropbear              : $status_dropbear"
echo -e "Stunnel5              : $status_stunnel5"
echo -e "Squid                 : $status_squid"
echo -e "NGINX                 : $status_nginx"
echo -e "SSH NonTLS            : $status_sshwsntls"
echo -e "SSH TLS               : $status_sshwstls"
echo -e "VLESS XTLS DIRECT     : $status_vlessxtls"
echo -e "VLESS XTLS SPLICE     : $status_vlessxtls"
echo -e "VLESS WEBSOCKET       : $status_vlessws"
echo -e "VMESS WEBSOCKET       : $status_vmessws"
echo -e "TROJAN TCP            : $status_trojantcp"
echo -e "TROJAN WEBSOCKET      : $status_trojanws"
echo -e "SHADOWSOCKS WEBSOCKET : $status_shadowsocks"
echo -e "ADS GUARD/ADS BLOCKER : $status_adsguard"
echo -e "\033[0;34m-------------------------------\033[0m"