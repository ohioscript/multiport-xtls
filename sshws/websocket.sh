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
echo -e " Installing Websocket-SSH Python"
sleep 1
echo -e "Sila Tunggu Sebentar..."
sleep 0.5
cd

rm -rf /etc/systemd/system/ws-*

# // SYSTEM WEBSOCKET HTTPS 443
cat <<EOF> /etc/systemd/system/ws-https.service
[Unit]
Description=Custom Python Proxy By VPN Legasi
Documentation=https://t.me/vpnlegasi $host
After=network.target nss-lookup.target

[Service]
Type=simple
User=root
CapabilityBoundingSet=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
AmbientCapabilities=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
NoNewPrivileges=true
Restart=on-failure
ExecStart=/usr/bin/python -O /usr/local/bin/ws-https

[Install]
WantedBy=multi-user.target
EOF

# // SYSTEM WEBSOCKET HTTP 80
cat <<EOF> /etc/systemd/system/ws-http.service
[Unit]
Description=Custom Python Proxy By VPN Legasi
Documentation=https://t.me/vpnlegasi $host
After=network.target nss-lookup.target

[Service]
Type=simple
User=root
CapabilityBoundingSet=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
AmbientCapabilities=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
NoNewPrivileges=true
ExecStart=/usr/bin/python -O /usr/local/bin/ws-http
Restart=on-failure
[Install]
WantedBy=multi-user.target
EOF

# // SYSTEM WEBSOCKET OVPN
cat <<EOF> /etc/systemd/system/ws-ovpn.service
[Unit]
Description=Custom Python Proxy By VPN Legasi
Documentation=https://t.me/vpnlegasi $host
After=network.target nss-lookup.target

[Service]
Type=simple
User=root
CapabilityBoundingSet=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
AmbientCapabilities=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
NoNewPrivileges=true
ExecStart=/usr/bin/python -O /usr/local/bin/ws-ovpn 2097
Restart=on-failure

[Install]
WantedBy=multi-user.target
EOF

# // PYTHON WEBSOCKET TLS && NONE
wget -O /usr/local/bin/ws-https "${host}/script/${sc}/sshws/ws-https" && chmod +x /usr/local/bin/ws-https

# // PYTHON WEBSOCKET DROPBEAR
wget -O /usr/local/bin/ws-http "${host}/script/${sc}/sshws/ws-http" && chmod +x /usr/local/bin/ws-http

# // PYTHON WEBSOCKET OVPN
wget -O /usr/local/bin/ws-ovpn "${host}/script/${sc}/sshws/ws-ovpn" && chmod +x /usr/local/bin/ws-ovpn

# // RESTART && ENABLE SSHVPN WEBSOCKET TLS 
systemctl daemon-reload
systemctl enable ws-https
systemctl restart ws-https
systemctl enable ws-http
systemctl restart ws-http
systemctl enable ws-ovpn
systemctl restart ws-ovpn

rm -rf websocket.sh