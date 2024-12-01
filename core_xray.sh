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

emailcf=$(cat /etc/xray/email)
domain=$(cat /etc/xray/domain)

stop_process() {
#disable process
systemctl stop xray.service > /dev/null 2>&1
systemctl disable xray.service > /dev/null 2>&1
systemctl stop xray > /dev/null 2>&1
systemctl disable xray > /dev/null 2>&1
systemctl stop xray@none > /dev/null 2>&1
systemctl disable xray@none > /dev/null 2>&1
systemctl stop xray@vmess > /dev/null 2>&1
systemctl disable xray@vmess > /dev/null 2>&1
systemctl stop xray@trojan > /dev/null 2>&1
systemctl disable xray@trojan > /dev/null 2>&1
systemctl stop xray@shadowsocks > /dev/null 2>&1
systemctl disable xray@shadowsocks > /dev/null 2>&1
}

# // VERSION XRAY
custom_version() {
rm -rf /root/xrayversion.txt > /dev/null 2>&1
clear
echo -e "\033[0;34m------------------------------------\033[0m"
echo -e "\E[44;1;39m        CORE XRAY VPN LEGASI MENU   \E[0m"
echo -e "\033[0;34m------------------------------------\033[0m"
echo ""
echo -e " [\e[36m 01 \e[0m] Latest Version Xray "
echo -e " [\e[36m 02 \e[0m] Custom Version Number Xray"
echo ""
echo -e "\033[0;34m------------------------------------\033[0m"
echo ""
echo - e "Which Version Do You Wish To Install?"
read -p " Select menu : " ans
if [[ $ans = "1" ]]; then
stop_process
version="$(curl -s https://api.github.com/repos/XTLS/Xray-core/releases | grep tag_name | sed -E 's/.*"v(.*)".*/\1/' | head -n 1)"
bash -c "$(curl -L https://github.com/XTLS/Xray-install/raw/main/install-release.sh)" @ install -u www-data --version ${version} > /dev/null 2>&1
echo "You Have Select Latest Xray Version $version"
echo -e "Please Wait for 3 sec before we set for you"
sleep 3
elif [[ $ans = "2" ]]; then
stop_process
echo "$(curl -s https://api.github.com/repos/XTLS/Xray-core/releases | grep tag_name | sed -E 's/.*"v(.*)".*/\1/')" >> /root/xrayversion.txt
NUMBER_OF_VERSION=$(grep -c -E "^*" "/root/xrayversion.txt" | sort | uniq)
        echo "     No Version"
	grep -E "^*" "/root/xrayversion.txt" | nl -s ') '
	until [[ ${VERSION_NUMBER} -ge 1 && ${VERSION_NUMBER} -le ${NUMBER_OF_VERSION} ]]; do
		if [[ ${VERSION_NUMBER} == '1' ]]; then
			read -rp "Select Your Desire Version [1]: " VERSION_NUMBER
		else
			read -rp "Select Your Desire Version [1-${NUMBER_OF_VERSION}]: " VERSION_NUMBER
		fi
	done
version=$(grep -E "^*" "/root/xrayversion.txt" | sed -n "${VERSION_NUMBER}"p)
clear
echo "You Have Select Xray Version $version"
echo -e "Please Wait for 3 sec before we set for you"
sleep 3
bash -c "$(curl -L https://github.com/XTLS/Xray-install/raw/main/install-release.sh)" @ install -u www-data --version ${version} > /dev/null 2>&1
else
echo -e ""
echo "Sila Pilih Semula"
sleep 3
core_xray
fi
}

x-mini() {
stop_process
# // Downloading Core for x-mini
wget -O /usr/local/bin/xray "http://${gitlink}/${resources}/xray-mini" > /dev/null 2>&1
chmod +x /usr/local/bin/xray
clear
echo "You Have Select Xray Version Mini By VPN Legasi"
echo -e "Please Wait for 3 sec before we set for you"
sleep 3
}

service_xray() {
rm -rf /etc/systemd/system/xray*
cat> /etc/systemd/system/xray.service << END
[Unit]
Description=Custom Xray Multiport By VPN Legasi
Documentation=https://t.me/vpnlegasi $host
After=network.target nss-lookup.target

[Service]
User=www-data
CapabilityBoundingSet=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
AmbientCapabilities=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
NoNewPrivileges=true
ExecStart=/usr/local/bin/xray run -config /usr/local/etc/xray/config.json
Restart=on-failure
RestartPreventExitStatus=23
LimitNPROC=10000
LimitNOFILE=1000000

[Install]
WantedBy=multi-user.target

END

cat> /etc/systemd/system/xray@.service << END
[Unit]
Description=Custom Xray Multiport By VPN Legasi
Documentation=https://t.me/vpnlegasi $host
After=network.target nss-lookup.target

[Service]
User=www-data
CapabilityBoundingSet=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
AmbientCapabilities=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
NoNewPrivileges=true
ExecStart=/usr/local/bin/xray run -config /usr/local/etc/xray/%i.json
Restart=on-failure
RestartPreventExitStatus=42
LimitNPROC=10000
LimitNOFILE=1000000

[Install]
WantedBy=multi-user.target

END
}

service_xray_mini() {
rm -rf /etc/systemd/system/xray*
cat> /etc/systemd/system/xray.service << END
[Unit]
Description=Custom Xray-mini Multiport By VPN Legasi
Documentation=https://t.me/vpnlegasi $host
After=network.target nss-lookup.target

[Service]
User=www-data
CapabilityBoundingSet=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
AmbientCapabilities=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
NoNewPrivileges=true
ExecStart=/usr/local/bin/xray run -config /usr/local/etc/xray/config.json
Restart=on-failure
RestartPreventExitStatus=23
LimitNPROC=10000
LimitNOFILE=1000000

[Install]
WantedBy=multi-user.target

END

cat> /etc/systemd/system/xray@.service << END
[Unit]
Description=Custom Xray-mini Multiport By VPN Legasi
Documentation=https://t.me/vpnlegasi $host
After=network.target nss-lookup.target

[Service]
User=www-data
CapabilityBoundingSet=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
AmbientCapabilities=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
NoNewPrivileges=true
ExecStart=/usr/local/bin/xray run -config /usr/local/etc/xray/%i.json
Restart=on-failure
RestartPreventExitStatus=42
LimitNPROC=10000
LimitNOFILE=1000000

[Install]
WantedBy=multi-user.target

END
}

x-multipath() {
stop_process
# // Downloading Core for xray-multipath
wget -O /usr/local/bin/xray "http://${gitlink}/${resources}/xray.linux.64bit" > /dev/null 2>&1
chmod +x /usr/local/bin/xray
clear
echo "You Have Select Xray Version Vless Multi-Path By VPN Legasi"
echo -e "Please Wait for 3 sec before we set for you"
sleep 3
}

service_xray() {
rm -rf /etc/systemd/system/xray*
cat> /etc/systemd/system/xray.service << END
[Unit]
Description=Custom Xray Multiport By VPN Legasi
Documentation=https://t.me/vpnlegasi $host
After=network.target nss-lookup.target

[Service]
User=www-data
CapabilityBoundingSet=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
AmbientCapabilities=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
NoNewPrivileges=true
ExecStart=/usr/local/bin/xray run -config /usr/local/etc/xray/config.json
Restart=on-failure
RestartPreventExitStatus=23
LimitNPROC=10000
LimitNOFILE=1000000

[Install]
WantedBy=multi-user.target

END

cat> /etc/systemd/system/xray@.service << END
[Unit]
Description=Custom Xray Multiport By VPN Legasi
Documentation=https://t.me/vpnlegasi $host
After=network.target nss-lookup.target

[Service]
User=www-data
CapabilityBoundingSet=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
AmbientCapabilities=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
NoNewPrivileges=true
ExecStart=/usr/local/bin/xray run -config /usr/local/etc/xray/%i.json
Restart=on-failure
RestartPreventExitStatus=42
LimitNPROC=10000
LimitNOFILE=1000000

[Install]
WantedBy=multi-user.target

END
}

service_xray_multipath() {
rm -rf /etc/systemd/system/xray*
cat> /etc/systemd/system/xray.service << END
[Unit]
Description=Custom Xray-Vless_Multipath By VPN Legasi
Documentation=https://t.me/vpnlegasi $host
After=network.target nss-lookup.target

[Service]
User=www-data
CapabilityBoundingSet=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
AmbientCapabilities=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
NoNewPrivileges=true
ExecStart=/usr/local/bin/xray run -config /usr/local/etc/xray/config.json
Restart=on-failure
RestartPreventExitStatus=23
LimitNPROC=10000
LimitNOFILE=1000000

[Install]
WantedBy=multi-user.target

END

cat> /etc/systemd/system/xray@.service << END
[Unit]
Description=Custom Xray-Vless_Multipath By VPN Legasi
Documentation=https://t.me/vpnlegasi $host
After=network.target nss-lookup.target

[Service]
User=www-data
CapabilityBoundingSet=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
AmbientCapabilities=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
NoNewPrivileges=true
ExecStart=/usr/local/bin/xray run -config /usr/local/etc/xray/%i.json
Restart=on-failure
RestartPreventExitStatus=42
LimitNPROC=10000
LimitNOFILE=1000000

[Install]
WantedBy=multi-user.target

END
}

restarting() {
# // IPTABLE TCP 
iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport 443 -j ACCEPT > /dev/null 2>&1
iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport 80 -j ACCEPT > /dev/null 2>&1
iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport 10085 -j ACCEPT > /dev/null 2>&1
iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport 10086 -j ACCEPT > /dev/null 2>&1
iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport 10087 -j ACCEPT > /dev/null 2>&1
iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport 10088 -j ACCEPT > /dev/null 2>&1
iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport 10089 -j ACCEPT > /dev/null 2>&1

# // IPTABLE UDP
iptables -I INPUT -m state --state NEW -m udp -p udp --dport 443 -j ACCEPT > /dev/null 2>&1
iptables -I INPUT -m state --state NEW -m udp -p udp --dport 80 -j ACCEPT > /dev/null 2>&1
iptables -I INPUT -m state --state NEW -m udp -p udp --dport 10085 -j ACCEPT > /dev/null 2>&1
iptables -I INPUT -m state --state NEW -m udp -p udp --dport 10086 -j ACCEPT > /dev/null 2>&1
iptables -I INPUT -m state --state NEW -m udp -p udp --dport 10087 -j ACCEPT > /dev/null 2>&1
iptables -I INPUT -m state --state NEW -m udp -p udp --dport 10088 -j ACCEPT > /dev/null 2>&1
iptables -I INPUT -m state --state NEW -m udp -p udp --dport 10089 -j ACCEPT > /dev/null 2>&1
iptables-save > /etc/iptables.up.rules > /dev/null 2>&1
iptables-restore -t < /etc/iptables.up.rules > /dev/null 2>&1
netfilter-persistent save > /dev/null 2>&1
netfilter-persistent reload > /dev/null 2>&1

restarting() {
systemctl daemon-reload > /dev/null 2>&1
systemctl enable xray > /dev/null 2>&1
systemctl restart xray > /dev/null 2>&1
systemctl enable xray@none > /dev/null 2>&1
systemctl restart xray@none > /dev/null 2>&1
systemctl enable xray@trojan > /dev/null 2>&1
systemctl restart xray@trojan > /dev/null 2>&1
systemctl enable xray@vmess > /dev/null 2>&1
systemctl restart xray@vmess > /dev/null 2>&1
systemctl enable xray@shadowsocks > /dev/null 2>&1
systemctl restart xray@shadowsocks > /dev/null 2>&1
}

clear
echo -e "\033[0;34m------------------------------------\033[0m"
echo -e "\E[44;1;39m            RESTART SERVICE         \E[0m"
echo -e "\033[0;34m------------------------------------\033[0m"
sleep 1
echo -e "$yell[SERVICE]$NC Restart All service"
systemctl daemon-reload
sleep 1
echo -e "[ ${green}ok${NC} ] Enable & restart Xray "
restarting
sleep 1
echo -e "[ ${green}ok${NC} ] Enable & restart Nginx "
systemctl restart nginx
sleep 1
rm -rf /etc/log-create-user.log
sleep 2
rm -rf /root/xrayversion.txt > /dev/null 2>&1
}

echo -e "\033[0;34m------------------------------------\033[0m"
echo -e "\E[44;1;39m        CORE XRAY VPN LEGASI MENU   \E[0m"
echo -e "\033[0;34m------------------------------------\033[0m"
echo ""
echo -e " [\e[36m 01 \e[0m] Custom Version Xray "
echo -e " [\e[36m 02 \e[0m] Custom Xray Mini"
echo -e " [\e[36m 03 \e[0m] Custom Xray Multipath (VLESS ONLY)"
echo ""
echo -e "Press x or [ Ctrl+C ]   To-Exit"
echo -e ""
echo -e "\033[0;34m----------------------------------------\033[0m"
echo -e "Client Name    : $Name"
echo -e "Expiry On      : $scexpireddate"
echo -e "Countdown Days : $sisa_hari Days Left"
echo -e "Script Type    : $sc $scv"
echo -e "\033[0;34m----------------------------------------\033[0m"
echo ""
read -p " Select menu : " opt
echo -e ""
case $opt in
1)
    clear
    custom_version
    service_xray
    restarting
    clear
    running
    echo -e "\E[44;1;39m XRAY DEFAULT COMPLETE INSTALL \E[0m"
    echo -e "\033[0;34m-------------------------------\033[0m"
    read -n 1 -s -r -p "Press any key to back on menu"
    menu_xray
    ;;
2)
    clear
    x-mini
    service_xray_mini
    restarting
    clear
    running
    echo -e "\E[44;1;39m XRAY DEFAULT COMPLETE INSTALL \E[0m"
    echo -e "\033[0;34m-------------------------------\033[0m"
    read -n 1 -s -r -p "Press any key to back on menu"
    menu_xray
    ;;
3)
    clear
    x-multipath
    service_xray_multipath
    restarting
    clear
    running
    echo -e "\E[44;1;39m XRAY DEFAULT COMPLETE INSTALL \E[0m"
    echo -e "\033[0;34m-------------------------------\033[0m"
    read -n 1 -s -r -p "Press any key to back on menu"
    menu_xray
    ;;
x)  
    clear
    menu_xray
    ;;
*)
    clear
    echo -e ""
    echo "Sila Pilih Semula"
    sleep 1
    core_xray
    ;;
esac

