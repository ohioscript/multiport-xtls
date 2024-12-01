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

# VPS Information
Checkstart1=$(ip route | grep default | cut -d ' ' -f 3 | head -n 1);
if [[ $Checkstart1 == "venet0" ]]; then 
    clear
	  lan_net="venet0"
    typevps="OpenVZ"
    sleep 1
else
    clear
		lan_net="eth0"
    typevps="KVM"
    sleep 1
fi

# clearing
clear && clear && clear
clear

trial_wg() {
    clear
    echo -e "\033[0;34m------------------------------------\033[0m"
    echo -e "\E[44;1;39m         TRIAL WIREGUARD USER       \E[0m"
    echo -e "\033[0;34m------------------------------------\033[0m"
    clear
    source /etc/wireguard/params
    source /var/lib/premium-script/ipvps.conf
    CLIENT_NAME="TrialWG-$( </dev/urandom tr -dc 0-9A-Z | head -c4 )"
    if [[ "$IP" = "" ]]; then
    SERVER_PUB_IP=$(wget -qO- ipinfo.io/ip);
    else
    SERVER_PUB_IP=$IP
    fi
    # // Validate Input
    if [[ ${CLIENT_NAME} =~ ^[a-zA-Z0-9_]+$ && ${CLIENT_EXISTS} == '0' ]]; then 
    CLIENT_EXISTS=$(grep -w $CLIENT_NAME /etc/wireguard/wg0.conf | wc -l)
    fi
    if [[ ${CLIENT_EXISTS} == '1' ]]; then
    echo ""
    echo "A client with the specified name was already created, please choose another name."
    exit 1
    fi
    echo "IPv4 Detected"
    ENDPOINT="$SERVER_PUB_IP:$SERVER_PORT"
    WG_CONFIG="/etc/wireguard/wg0.conf"
    LASTIP=$( grep "/32" $WG_CONFIG | tail -n1 | awk '{print $3}' | cut -d "/" -f 1 | cut -d "." -f 4 )
    if [[ "$LASTIP" = "" ]]; then
    CLIENT_ADDRESS="10.66.66.2"
    else
    CLIENT_ADDRESS="10.66.66.$((LASTIP+1))"
    fi

    # Adguard DNS by default
    CLIENT_DNS_1="176.103.130.130"

    CLIENT_DNS_2="176.103.130.131"
    MYIP=$(wget -qO- ipinfo.io/ip);
    Jumlah_Hari=1
    exp=`date -d "$Jumlah_Hari days" +"%Y-%m-%d"`
    hariini=`date -d "0 days" +"%Y-%m-%d"`
    read -p "Wildcard BUG Domain? ( Y/N ) " ans
    if [[ "$ans" = [yY] ]]; then
    read -p "Input Wildcard BUG  : " BUG
    BUG=${BUG}.
    fi
    domain=$(cat /etc/xray/domain)

    # Generate key pair for the client
    CLIENT_PRIV_KEY=$(wg genkey)
    CLIENT_PUB_KEY=$(echo "$CLIENT_PRIV_KEY" | wg pubkey)
    CLIENT_PRE_SHARED_KEY=$(wg genpsk)

    # Create client file and add the server as a peer
    echo "[Interface]
    PrivateKey = $CLIENT_PRIV_KEY
    Address = $CLIENT_ADDRESS/24
    DNS = $CLIENT_DNS_1,$CLIENT_DNS_2
    [Peer]
    PublicKey = $SERVER_PUB_KEY
    PresharedKey = $CLIENT_PRE_SHARED_KEY
    Endpoint = ${BUG}$ENDPOINT
    AllowedIPs = 0.0.0.0/0,::/0" >>"$HOME/$SERVER_WG_NIC-client-$CLIENT_NAME.conf"

	# Add the client as a peer to the server
    echo -e "### Client $CLIENT_NAME $exp
    [Peer]
    PublicKey = $CLIENT_PUB_KEY
    PresharedKey = $CLIENT_PRE_SHARED_KEY
    AllowedIPs = $CLIENT_ADDRESS/32" >>"/etc/wireguard/$SERVER_WG_NIC.conf"
    systemctl restart "wg-quick@$SERVER_WG_NIC"
    cp $HOME/$SERVER_WG_NIC-client-$CLIENT_NAME.conf /home/vps/public_html/$CLIENT_NAME.conf
    clear
    sleep 0.5
    echo Generate PrivateKey
    sleep 0.5
    echo Generate PublicKey
    sleep 0.5
    echo Generate PresharedKey
    sleep 1
    clear
    echo -e "\033[0;34m------------------------------------\033[0m"
    echo -e "\E[44;1;39m  TRIAL WIREGUARD USER INFORMATION  \E[0m"
    echo -e "\033[0;34m------------------------------------\033[0m"
    echo -e " Username           : $CLIENT_NAME"
    echo -e "\033[0;34m------------------------------------\033[0m"
    echo -e "Wireguard Config Link  : "
    echo ""
    echo ""http://$MYIP:81/$CLIENT_NAME.conf""
    echo "" 
    echo -e "\033[0;34m------------------------------------\033[0m"
    echo -e " Created date       : ${hariini}"
    echo -e " Expired date       : $exp"
    echo -e "\033[0;34m------------------------------------\033[0m"
    rm -f /root/wg0-client-$CLIENT_NAME.conf
    read -n 1 -s -r -p "Press any key to back on menu"
    menu
}

add_wg() {
    clear
    echo -e "\033[0;34m------------------------------------\033[0m"
    echo -e "\E[44;1;39m          ADD WIREGUARD USER        \E[0m"
    echo -e "\033[0;34m------------------------------------\033[0m"
    echo ""
source /etc/wireguard/params
source /var/lib/premium-script/ipvps.conf
if [[ "$IP" = "" ]]; then
SERVER_PUB_IP=$(wget -qO- ipinfo.io/ip);
else
SERVER_PUB_IP=$IP
fi
	echo ""
	echo "Tell me a name for the client."
	echo "Use one word only, no special characters."

	until [[ ${CLIENT_NAME} =~ ^[a-zA-Z0-9_]+$ && ${CLIENT_EXISTS} == '0' ]]; do
		read -rp "Client name: " -e CLIENT_NAME
		CLIENT_EXISTS=$(grep -w $CLIENT_NAME /etc/wireguard/wg0.conf | wc -l)

		if [[ ${CLIENT_EXISTS} == '1' ]]; then
			echo ""
			echo "A client with the specified name was already created, please choose another name."
			exit 1
		fi
	done

	echo "IPv4 Detected"
	ENDPOINT="$SERVER_PUB_IP:$SERVER_PORT"
	WG_CONFIG="/etc/wireguard/wg0.conf"
	LASTIP=$( grep "/32" $WG_CONFIG | tail -n1 | awk '{print $3}' | cut -d "/" -f 1 | cut -d "." -f 4 )
	if [[ "$LASTIP" = "" ]]; then
	CLIENT_ADDRESS="10.66.66.2"
	else
	CLIENT_ADDRESS="10.66.66.$((LASTIP+1))"
	fi

	# Adguard DNS by default
	CLIENT_DNS_1="176.103.130.130"

	CLIENT_DNS_2="176.103.130.131"
	MYIP=$(wget -qO- ipinfo.io/ip);
	read -p "Expired (days): " masaaktif
	exp=`date -d "$masaaktif days" +"%Y-%m-%d"`
	hariini=`date -d "0 days" +"%Y-%m-%d"`
    read -p "Wildcard BUG Domain? ( Y/N ) " ans
    if [[ "$ans" = [yY] ]]; then
    read -p "Input Wildcard BUG  : " BUG
    BUG=${BUG}.
    fi
    domain=$(cat /etc/xray/domain)

	# Generate key pair for the client
	CLIENT_PRIV_KEY=$(wg genkey)
	CLIENT_PUB_KEY=$(echo "$CLIENT_PRIV_KEY" | wg pubkey)
	CLIENT_PRE_SHARED_KEY=$(wg genpsk)

	# Create client file and add the server as a peer
	echo "[Interface]
PrivateKey = $CLIENT_PRIV_KEY
Address = $CLIENT_ADDRESS/24
DNS = $CLIENT_DNS_1,$CLIENT_DNS_2
[Peer]
PublicKey = $SERVER_PUB_KEY
PresharedKey = $CLIENT_PRE_SHARED_KEY
Endpoint = ${BUG}$ENDPOINT
AllowedIPs = 0.0.0.0/0,::/0" >>"$HOME/$SERVER_WG_NIC-client-$CLIENT_NAME.conf"

	# Add the client as a peer to the server
	echo -e "### Client $CLIENT_NAME $exp
[Peer]
PublicKey = $CLIENT_PUB_KEY
PresharedKey = $CLIENT_PRE_SHARED_KEY
AllowedIPs = $CLIENT_ADDRESS/32" >>"/etc/wireguard/$SERVER_WG_NIC.conf"
    systemctl restart "wg-quick@$SERVER_WG_NIC"
    cp $HOME/$SERVER_WG_NIC-client-$CLIENT_NAME.conf /home/vps/public_html/$CLIENT_NAME.conf
    clear
    sleep 0.5
    echo Generate PrivateKey
    sleep 0.5
    echo Generate PublicKey
    sleep 0.5
    echo Generate PresharedKey
    sleep 1
    clear
    echo -e "\033[0;34m------------------------------------\033[0m"
    echo -e "\E[44;1;39m     WIREGUARD USER INFORMATION     \E[0m"
    echo -e "\033[0;34m------------------------------------\033[0m"
    echo -e " Username           : $CLIENT_NAME"
    echo -e "\033[0;34m------------------------------------\033[0m"
    echo -e "Wireguard Config Link  : "
    echo ""
    echo ""http://$MYIP:81/$CLIENT_NAME.conf""
    echo "" 
    echo -e "\033[0;34m------------------------------------\033[0m"
    echo -e " Created date       : ${hariini}"
    echo -e " Expired date       : $exp"
    echo -e "\033[0;34m------------------------------------\033[0m"
    rm -f /root/wg0-client-$CLIENT_NAME.conf
    read -n 1 -s -r -p "Press any key to back on menu"
    menu
}

renew_wg() {
    clear
    echo -e "\033[0;34m------------------------------------\033[0m"
    echo -e "\E[44;1;39m         RENEW WIREGUARD USER       \E[0m"
    echo -e "\033[0;34m------------------------------------\033[0m"
    clear
    source /etc/wireguard/params
	NUMBER_OF_CLIENTS=$(grep -c -E "^### Client" "/etc/wireguard/$SERVER_WG_NIC.conf")
	if [[ ${NUMBER_OF_CLIENTS} == '0' ]]; then
		clear
    		echo -e "\033[0;34m------------------------------------\033[0m"
   		echo -e "\E[44;1;39m         RENEW WIREGUARD USER       \E[0m"
    		echo -e "\033[0;34m------------------------------------\033[0m"
		echo "You have no existing clients!"
    		echo -e "\033[0;34m------------------------------------\033[0m"
		exit 1
	fi
	clear
    	echo -e "\033[0;34m------------------------------------\033[0m"
    	echo -e "\E[44;1;39m         RENEW WIREGUARD USER       \E[0m"
    	echo -e "\033[0;34m------------------------------------\033[0m"
	echo "Select an existing client that you want to renew"
	echo " Press CTRL+C to return"
    	echo -e "\033[0;34m------------------------------------\033[0m"
	echo "     No  Expired   User"
	grep -E "^### Client" "/etc/wireguard/$SERVER_WG_NIC.conf" | cut -d ' ' -f 3-4 | nl -s ') '
	until [[ ${CLIENT_NUMBER} -ge 1 && ${CLIENT_NUMBER} -le ${NUMBER_OF_CLIENTS} ]]; do
		if [[ ${CLIENT_NUMBER} == '1' ]]; then
    			echo -e "\033[0;34m------------------------------------\033[0m"
			read -rp "Select one client [1]: " CLIENT_NUMBER
		else
    			echo -e "\033[0;34m------------------------------------\033[0m"
			read -rp "Select one client [1-${NUMBER_OF_CLIENTS}]: " CLIENT_NUMBER
		fi
	done
        read -p "Expired (days): " masaaktif
        user=$(grep -E "^### Client" "/etc/wireguard/wg0.conf" | cut -d ' ' -f 3 | sed -n "${CLIENT_NUMBER}"p)
        exp=$(grep -E "^### Client" "/etc/wireguard/wg0.conf" | cut -d ' ' -f 4 | sed -n "${CLIENT_NUMBER}"p)
    	hariini=`date -d "0 days" +"%Y-%m-%d"`
        now=$(date +%Y-%m-%d)
        d1=$(date -d "$exp" +%s)
        d2=$(date -d "$now" +%s)
        exp2=$(( (d1 - d2) / 86400 ))
        exp3=$(($exp2 + $masaaktif))
        exp4=`date -d "$exp3 days" +"%Y-%m-%d"`
        sed -i "s/### Client $user $exp/### Client $user $exp4/g" /etc/wireguard/wg0.conf
        echo ""
        clear
        echo -e "\033[0;34m------------------------------------\033[0m"
        echo -e "\E[44;1;39m   Account Was Successfully Renew   \E[0m"
        echo -e "\033[0;34m------------------------------------\033[0m"
        echo " Client Name  : $user"
 	echo " Renew date   : ${hariini}"
        echo " Expired On   : $exp4"
        echo -e "\033[0;34m------------------------------------\033[0m"
        echo ""
        read -n 1 -s -r -p "Press any key to back on menu"
        menu
}

del_wg() {
    clear
    echo -e "\033[0;34m------------------------------------\033[0m"
    echo -e "\E[44;1;39m        DELETE WIREGUARD USER       \E[0m"
    echo -e "\033[0;34m------------------------------------\033[0m"
    clear
    source /etc/wireguard/params
    NUMBER_OF_CLIENTS=$(grep -c -E "^### Client" "/etc/wireguard/$SERVER_WG_NIC.conf")
    if [[ ${NUMBER_OF_CLIENTS} == '0' ]]; then
    clear
    echo -e "\033[0;34m------------------------------------\033[0m"
    echo -e "\E[44;1;39m        DELETE WIREGUARD USER       \E[0m"
    echo -e "\033[0;34m------------------------------------\033[0m"
    echo "You have no existing clients!"
    echo -e "\033[0;34m------------------------------------\033[0m"
    exit 1
    fi
    clear
    echo -e "\033[0;34m------------------------------------\033[0m"
    echo -e "\E[44;1;39m        DELETE WIREGUARD USER       \E[0m"
    echo -e "\033[0;34m------------------------------------\033[0m"
    echo " Select the existing client you want to remove"
    echo " Press CTRL+C to return"
    echo -e "\033[0;34m------------------------------------\033[0m"
    echo "     No  Expired   User"
    grep -E "^### Client" "/etc/wireguard/$SERVER_WG_NIC.conf" | cut -d ' ' -f 3-4 | nl -s ') '
    until [[ ${CLIENT_NUMBER} -ge 1 && ${CLIENT_NUMBER} -le ${NUMBER_OF_CLIENTS} ]]; do
    if [[ ${CLIENT_NUMBER} == '1' ]]; then
    echo -e "\033[0;34m------------------------------------\033[0m"
    read -rp "Select one client [1]: " CLIENT_NUMBER
    else
    echo -e "\033[0;34m------------------------------------\033[0m"
    read -rp "Select one client [1-${NUMBER_OF_CLIENTS}]: " CLIENT_NUMBER
    fi
    done

    # match the selected number to a client name
    CLIENT_NAME=$(grep -E "^### Client" "/etc/wireguard/$SERVER_WG_NIC.conf" | cut -d ' ' -f 3-4 | sed -n "${CLIENT_NUMBER}"p)
    user=$(grep -E "^### Client" "/etc/wireguard/$SERVER_WG_NIC.conf" | cut -d ' ' -f 3 | sed -n "${CLIENT_NUMBER}"p)
    exp=$(grep -E "^### Client" "/etc/wireguard/$SERVER_WG_NIC.conf" | cut -d ' ' -f 4 | sed -n "${CLIENT_NUMBER}"p)
    hariini=`date -d "0 days" +"%Y-%m-%d"`
    # remove [Peer] block matching $CLIENT_NAME
    sed -i "/^### Client $user $exp/,/^AllowedIPs/d" /etc/wireguard/wg0.conf
    # remove generated client file
    rm -f "/home/vps/public_html/$user.conf"

    # restart wireguard to apply changes
    systemctl restart "wg-quick@$SERVER_WG_NIC"
    service cron restart
    echo ""
    clear
    echo -e "\033[0;34m------------------------------------\033[0m"
    echo -e "\E[44;1;39m  Account Was Successfully Delete   \E[0m"
    echo -e "\033[0;34m------------------------------------\033[0m"
    echo " Client Name  : $user"
    echo -e "\033[0;34m------------------------------------\033[0m"
    echo " Delete date  : ${hariini}"
    echo " Expired On   : $exp"
    echo -e "\033[0;34m------------------------------------\033[0m"
    echo ""
    read -n 1 -s -r -p "Press any key to back on menu"
    menu
}

cek_wg() {
    clear
    echo -e "\033[0;34m------------------------------------\033[0m"
    echo -e "\E[44;1;39m        Wireguard User Login        \E[0m"
    echo -e "\033[0;34m------------------------------------\033[0m"
    clear
    echo > /etc/wireguard/clients.txt
data=( `cat /etc/wireguard/wg0.conf | grep "### Client" | awk '{ print $3 }'`);
hr(){
    numfmt --to=iec-i --suffix=B "$1"
}
x=1
echo -e "\033[0;34m------------------------------------\033[0m"
echo -e "\E[44;1;39m         Wireguard User Login       \E[0m"
echo -e "\033[0;34m------------------------------------\033[0m"
echo "Name  Remote IP Virtual IP Bytes Received Bytes Sent Last Seen "
for akun in "${data[@]}"
do
pub=$(cat /etc/wireguard/wg0.conf | grep PublicKey | awk '{ print $3 }' | tr '\n' ' ' | awk '{print $'"$x"'}')
echo "$akun $pub" >> /etc/wireguard/clients.txt
x=$(( "$x" + 1 ))
done
CLIENTS_FILE="/etc/wireguard/clients.txt"
if [ ! -s "$CLIENTS_FILE" ]; then
    echo "::: There are no clients to list"
    exit 0
fi
listClients(){
    if DUMP="$(wg show wg0 dump)"; then
        DUMP="$(tail -n +2 <<< "$DUMP")"
    else
        exit 1
    fi

    printf "\e[1m::: Connected Clients List :::\e[0m\n"

    {
    printf "\e[4mName\e[0m  \t  \e[4mRemote IP\e[0m  \t  \e[4mVirtual IP\e[0m  \t  \e[4mBytes Received\e[0m  \t  \e[4mBytes Sent\e[0m  \t  \e[4mLast Seen\e[0m\n"

    while IFS= read -r LINE; do
        if [ -n "${LINE}" ]; then
            PUBLIC_KEY="$(awk '{ print $1 }' <<< "$LINE")"
            REMOTE_IP="$(awk '{ print $3 }' <<< "$LINE")"
            VIRTUAL_IP="$(awk '{ print $4 }' <<< "$LINE")"
            BYTES_RECEIVED="$(awk '{ print $6 }' <<< "$LINE")"
            BYTES_SENT="$(awk '{ print $7 }' <<< "$LINE")"
            LAST_SEEN="$(awk '{ print $5 }' <<< "$LINE")"
            CLIENT_NAME="$(grep "$PUBLIC_KEY" "$CLIENTS_FILE" | awk '{ print $1 }')"
            if [ "$HR" = 1 ]; then
                if [ "$LAST_SEEN" -ne 0 ]; then
                    printf "%s  \t  %s  \t  %s  \t  %s  \t  %s  \t  %s\n" "$CLIENT_NAME" "$REMOTE_IP" "${VIRTUAL_IP/\/32/}" "$(hr "$BYTES_RECEIVED")" "$(hr "$BYTES_SENT")" "$(date -d @"$LAST_SEEN" '+%b %d %Y - %T')"
                else
                    printf "%s  \t  %s  \t  %s  \t  %s  \t  %s  \t  %s\n" "$CLIENT_NAME" "$REMOTE_IP" "${VIRTUAL_IP/\/32/}" "$(hr "$BYTES_RECEIVED")" "$(hr "$BYTES_SENT")" "(not yet)"
                fi
            else
                if [ "$LAST_SEEN" -ne 0 ]; then
                    printf "%s  \t  %s  \t  %s  \t  %'d  \t  %'d  \t  %s\n" "$CLIENT_NAME" "$REMOTE_IP" "${VIRTUAL_IP/\/32/}" "$BYTES_RECEIVED" "$BYTES_SENT" "$(date -d @"$LAST_SEEN" '+%b %d %Y - %T')"
                else
                    printf "%s  \t  %s  \t  %s  \t  %'d  \t  %'d  \t  %s\n" "$CLIENT_NAME" "$REMOTE_IP" "${VIRTUAL_IP/\/32/}" "$BYTES_RECEIVED" "$BYTES_SENT" "(not yet)"
                fi
            fi
        fi
    done <<< "$DUMP"

    printf "\n"
    } | column -t -s $'\t'
 }
listClients
echo -e "\033[0;34m------------------------------------\033[0m"
echo -e "Script By VPN Legasi"
    read -n 1 -s -r -p "Press any key to back on menu"
    menu_wg
}

fix_wg() {
systemctl stop wg-quick@wg0
apt install sudo lsb-release -y
echo "deb http://deb.debian.org/debian $(lsb_release -sc)-backports main" | sudo tee /etc/apt/sources.list.d/backports.list
sudo apt update -y
sudo apt -y --no-install-recommends install net-tools iproute2 openresolv dnsutils linux-headers-$(uname -r)
sudo apt --no-install-recommends install wireguard-tools wireguard-dkms
systemctl start wg-quick@wg0
systemctl enable wg-quick@wg0
reboot
}

menu_wg() {
clear
echo -e "\033[0;34m------------------------------------\033[0m"
echo -e "\E[44;1;39m            WIREGUARD MENU          \E[0m"
echo -e "\033[0;34m------------------------------------\033[0m"
echo ""
echo -e " [\e[36m 01 \e[0m] Trial Wireguard"
echo -e " [\e[36m 02 \e[0m] Add Wireguard"
echo -e " [\e[36m 03 \e[0m] Delete Wireguard"
echo -e " [\e[36m 04 \e[0m] Extend Wireguard"
echo -e " [\e[36m 05 \e[0m] Check User Login"
echo -e " [\e[36m 06 \e[0m] Fix Wireguard Service"
echo ""
echo -e "Press x or [ Ctrl+C ]   To-Exit"
echo -e ""
echo -e "\033[0;34m----------------------------------------\033[0m"
echo -e "Client Name    : $Name"
echo -e "Expiry script  : $scexpireddate"
echo -e "Remaining Days : $sisa_hari Days Left"
echo -e "Script Type    : $sc (Single Port)"
echo -e "\033[0;34m----------------------------------------\033[0m"
echo ""
read -p " Select menu : " opt
echo -e ""
case $opt in
1)
    clear
    trial_wg
    ;;
2)
    clear
    add_wg
    ;;
3)
    clear
    del_wg
    ;;
4)
    clear
    renew_wg
    ;;   
5)
    clear
    cek_wg
    ;;
6)
    clear
    fix_wg
    ;;   
x)  clear
    menu
    ;;
*)
    echo -e ""
    echo "Sila Pilih Semula"
    sleep 1
    menu_wg
    ;;
esac
}

info () {
echo -e "\033[0;34m--------------------------------------------------------------------------------\033[0m"
echo -e "\E[44;1;39m                                  INFO SCRIPTS INSTALL                          \E[0m"
echo -e "\033[0;34m--------------------------------------------------------------------------------\033[0m"
cat /root/log-install.txt
echo -e "\033[0;34m--------------------------------------------------------------------------------\033[0m"
read -n 1 -s -r -p "Press any key to back on menu"
menu
}

ads-guard() {
if [[ ! -z $(which dnsmasq) ]] && [[ -e /etc/dnsmasq ]]; then
	clear
	adguard
else
	clear
	wget -O /usr/bin/adguard "http://${link}/${directory}/ads-guard.sh" && chmod +x /usr/bin/adguard && adguard
	
fi
}







# DNS Patch
tipeos2=$(uname -m)
# OS Uptime
uptime="$(uptime -p | cut -d " " -f 2-10)"
# Download
download=`grep -e "lo:" -e "wlan0:" -e "eth0" /proc/net/dev  | awk '{print $2}' | paste -sd+ - | bc`
downloadsize=$(($download/1073741824))
# Upload
upload=`grep -e "lo:" -e "wlan0:" -e "eth0" /proc/net/dev | awk '{print $10}' | paste -sd+ - | bc`
uploadsize=$(($upload/1073741824))
#Download/Upload today

data=$(ifconfig | grep -w "eth0" | awk '{print $1}')
if [[ "$data" = eth0: ]]; then
data=eth0
else
data=ens3
fi

ddtoday="$(vnstat -i $data | grep "today" | awk '{print $2" "substr ($3, 1, 1)}')"
uutoday="$(vnstat -i $data | grep "today" | awk '{print $5" "substr ($6, 1, 1)}')"
tttoday="$(vnstat -i $data | grep "today" | awk '{print $8" "substr ($9, 1, 1)}')"
fr="\033[0;34m"
bck="\033[0m"
dtoday=$fr$ddtoday$bck
utoday=$fr$uutoday$bck
ttoday=$fr$tttoday$bck
# Getting CPU Information
cpu_usage1="$(ps aux | awk 'BEGIN {sum=0} {sum+=$3}; END {print sum}')"
cpu_usage="$((${cpu_usage1/\.*} / ${corediilik:-1}))"
cpu_usage+=" %"
# Shell Version
shellversion=""
shellversion=Bash
shellversion+=" Version" 
shellversion+=" ${BASH_VERSION/-*}" 
versibash=$shellversion
# Getting OS Information
source /etc/os-release
Versi_OS=$VERSION
ver=$VERSION_ID
Tipe=$NAME
URL_SUPPORT=$HOME_URL
basedong=$ID
ISP=$(curl -s ipinfo.io/org | cut -d " " -f 2-10 )
CITY=$(curl -s ipinfo.io/city )
WKT=$(curl -s ipinfo.io/timezone )
msa="$( date -d "0 days" +"%X" )"
domain=$(cat /etc/xray/domain)
OS=`hostnamectl | grep "Operating System" | cut -d ' ' -f5-`
tele="@vpnlegasi"
DAY=$(date +%A)
DATE=$(date +%Y-%m-%d)
IPVPS=$(curl -s ipinfo.io/ip )
cname=$( awk -F: '/model name/ {name=$2} END {print name}' /proc/cpuinfo )
cores=$( awk -F: '/model name/ {core++} END {print core}' /proc/cpuinfo )
freq=$( awk -F: ' /cpu MHz/ {freq=$2} END {print freq}' /proc/cpuinfo )
tram=$( free -m | awk 'NR==2 {print $2}' )
uram=$( free -m | awk 'NR==2 {print $3}' )
fram=$( free -m | awk 'NR==2 {print $4}' )
swap=$( free -m | awk 'NR==4 {print $2}' )

#Total User
SSHUSER="$(awk -F: '$3 >= 1000 && $1 != "nobody" {print $1}' /etc/passwd | wc -l)"
VLESSUSER="$(grep -E "^### " "/usr/local/etc/xray/config.json" | sort | uniq | wc -l)"
VMESSUSER="$(grep -E "^### " "/usr/local/etc/xray/vmess.json" | sort | uniq | wc -l)"
TROJANUSER="$(grep -E "^### " "/usr/local/etc/xray/trojan.json" | sort | uniq | wc -l)"

inf_o () {
clear -x
echo -e "\033[0;34m----------------------------------------\033[0m"
echo -e "\E[44;1;39m          INFO VPS BY VPN LEGASI        \E[0m"
echo -e "\033[0;34m----------------------------------------\033[0m"
echo -e " VPS Type             :  \033[0;34m$typevps\033[0m"
echo -e " CPU Model            : \033[0;34m$cname\033[0m"
echo -e " CPU Frequency        : \033[0;34m$freq MHz\033[0m"
echo -e " Number Of Cores      :  \033[0;34m$cores\033[0m"
echo -e " CPU Usage            :  \033[0;34m$cpu_usage\033[0m"
echo -e " Operating System     :  \033[0;34m$OS\033[0m"
echo -e " OS Family            :  \033[0;34m`uname -s`\033[0m"	
echo -e " Kernel               :  \033[0;34m`uname -r`\033[0m"
echo -e " Bash Ver             :  \033[0;34m$versibash\033[0m"
echo -e " Total Amount Of RAM  :  \033[0;34m$tram MB\033[0m"
echo -e " Used RAM             :  \033[0;34m$uram MB\033[0m"
echo -e " Free RAM             :  \033[0;34m$fram MB\033[0m"
echo -e " System Uptime        :  \033[0;34m$uptime (From VPS Booting)\033[0m"
echo -e " Download             :  \033[0;34m$downloadsize GB (From VPS Booting)\033[0m"
echo -e " Upload               :  \033[0;34m$uploadsize GB (From VPS Booting)\033[0m"
echo -e " Domain VPS           :  \033[0;34m$domain\033[0m"	
echo -e " Ip VPS               :  \033[0;34m$IPVPS\033[0m"	
echo -e " Day,Date & Time      :  \033[0;34m$DAY $DATE $msa\033[0m"
echo -e " Telegram             :  \033[0;34m$tele\033[0m"
echo -e "\033[0;34m----------------------------------------\033[0m"
echo -e  "Traffic    Download     Upload     Total"
echo -e  "Today      $dtoday      $utoday    $ttoday " 
echo -e "\033[0;34m----------------------------------------\033[0m"
echo -e  "Proto  SSH    XTLS/Vless  Vmess\tTrojan"
echo -e  "User\t$SSHUSER\t  $VLESSUSER\t    $VMESSUSER\t  $TROJANUSER"
}

admin-cek () {
cek=$( curl -sS ${gitlink}/ip-admin/main/access | awk '{print $2}' | grep $MYIP )
if [ $cek = $MYIP ]; then
echo -e "${green}Permission Accepted...${NC}"
menu-admin	
else
echo -e "${red}Permission Denied!${NC}";
clear
echo "Your IP Are Not Allowed to View This Feature"
sleep 5
menu
fi
clear
}

setup-admin () {
cek=$( curl -sS ${gitlink}/ip-admin/main/access | awk '{print $2}' | grep $MYIP )
if [ $cek = $MYIP ]; then
echo -e "${green}Permission Accepted...${NC}"

else
echo -e "${red}Permission Denied!${NC}";
clear
echo "Your IP Are Not Allowed to Use This Feature"
sleep 5
menu
fi
clear
}

clear
PERMISSION
inf_o
echo -e "\033[0;34m----------------------------------------\033[0m"
echo -e "\E[44;1;39m           MENU SCRIPT VPN LEGASI       \E[0m"
echo -e "\033[0;34m----------------------------------------\033[0m"
echo ""
echo -e " [\e[36m 01 \e[0m] MENU SSH & OPENVPN"
echo -e " [\e[36m 02 \e[0m] MENU WIREGUARD"
echo -e " [\e[36m 03 \e[0m] MENU SSR & SHADOWSOCKS"
echo -e " [\e[36m 04 \e[0m] MENU XRAY"
echo -e " [\e[36m 05 \e[0m] MENU VPS & SYSTEM SETTING"
echo -e " [\e[36m 06 \e[0m] MENU ADGUARDS / ADS-BLOCKER"
echo -e " [\e[36m 07 \e[0m] ADMIN SETUP (Owner Only) "
echo -e " [\e[36m 08 \e[0m] MENU ADMIN (Owner Only) "
echo ""
echo -e "Press x or [ Ctrl+C ]   To-Exit"
echo -e ""
echo -e "\033[0;34m----------------------------------------\033[0m"
echo -e "Client Name    : $Name"
echo -e "Expiry On      : $scexpireddate"
echo -e "Countdown Days : $sisa_hari Days Left"
echo -e "Script Type    : $sc $scv"
echo -e "\033[0;34m----------------------------------------\033[0m"
echo -e   ""
read -p "Select from menu options :  " opt
echo -e   ""
case $opt in

1) 
    clear 
    menu_ssh 
    ;;
2) 
    clear
    menu_wg 
    ;;
3) 
    clear 
    m-ssr 
    ;;
4) 
    clear 
    menu_xray 
    ;;
5) 
    clear
    m-system 
    ;;

6) 
    clear 
    ads-guard 
    ;;

7) 
    clear 
    setup-admin
    ;;
8) 
    clear 
    admin-cek
    ;;

x)  
    clear
    exit
    ;;
*)
    echo -e ""
    echo "Sila Pilih Semula"
    sleep 1
    menu
    ;;
esac