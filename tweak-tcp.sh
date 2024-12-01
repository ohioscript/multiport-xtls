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
echo "Pastikan Kernel Update Terlebih Dahulu 5.0 Above"
# status tweak
tcp_status(){
	if [[ `grep -c "^#PH56" /etc/sysctl.conf` -eq 1 ]]; then
		echo -e "TCP Tweak Current status : ${green}Installed${NC}"
	    else
		echo -e "TCP Tweak Current status : ${red}Not Installed${NC}"
	fi
}

# status tweak
tcp_2_status(){
	if [[ `grep -c "^##VpsPack" /etc/sysctl.conf` -eq 1 ]]; then
		echo -e "TCP Tweak 2 Current status : ${green}Installed${NC}"
	    else
		echo -e "TCP Tweak 2 Current status : ${red}Not Installed${NC}"
	fi
}

# status bbr
bbr_status() {
    local param=$(sysctl net.ipv4.tcp_congestion_control | awk '{print $3}')
    if [[ x"${param}" == x"bbr" ]]; then
        echo -e "BBR Current status : ${green}Installed${NC}"
    else
        echo -e "BBR Current status : ${red}Not Installed${NC}"
    fi
}

delete_bbr() {
   clear
	 echo -e "$CYAN━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
	 echo -e "         $white BBR & TCP Tweaker     "
	 echo -e "$CYAN━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
   echo
   read -p "Do you want to remove BBR settings? [y/n]: " -e answer0
   if [[ "$answer0" = 'y' ]]; then
      grep -v "^#BBR
net.core.default_qdisc = fq
net.ipv4.tcp_congestion_control = bbr" /etc/sysctl.conf > /tmp/syscl && mv /tmp/syscl /etc/sysctl.conf
      sysctl -p /etc/sysctl.conf > /dev/null
      echo "cubic" >  /proc/sys/net/ipv4/tcp_congestion_control
      echo ""
      echo "BBR settings were successfully removed."
      echo ""
      read -n 1 -s -r -p "Press any key to back"
      tweak
      else
      echo ""
      tweak
    fi
}

sysctl_config() {
    sed -i '/net.core.default_qdisc/d' /etc/sysctl.conf
    sed -i '/net.ipv4.tcp_congestion_control/d' /etc/sysctl.conf
    echo "" >> /etc/sysctl.conf
    echo "#BBR" >> /etc/sysctl.conf
    echo "net.core.default_qdisc = fq" >> /etc/sysctl.conf
    echo "net.ipv4.tcp_congestion_control = bbr" >> /etc/sysctl.conf
    sysctl -p >/dev/null 2>&1
}

check_bbr_status() {
    local param=$(sysctl net.ipv4.tcp_congestion_control | awk '{print $3}')
    if [[ x"${param}" == x"bbr" ]]; then
        return 0
    else
        return 1
    fi
}

version_ge(){
    test "$(echo "$@" | tr " " "\n" | sort -rV | head -n 1)" == "$1"
}

check_kernel_version() {
    local kernel_version=$(uname -r | cut -d- -f1)
    if version_ge ${kernel_version} 4.9; then
        return 0
    else
        return 1
    fi
}

install_bbr2() {
    check_bbr_status
    if [ $? -eq 0 ]; then
        echo
        echo -e "[ Information ]  TCP BBR has already been installed. nothing to do..."
        echo
        read -n 1 -s -r -p "Press any key to back"
        tweak
    fi
    check_kernel_version
    if [ $? -eq 0 ]; then
        echo
        echo -e "[ Information ]  Your kernel version is greater than 4.9, directly setting TCP BBR..."
        sysctl_config
        echo -e "[ Information ]  Setting TCP BBR completed..."
        echo
        read -n 1 -s -r -p "Press any key to back"
        tweak
    fi

    if [[ x"${release}" == x"centos" ]]; then
       echo ""
       echo -e "[ Invalid ] Centos not support"
       echo ""
       read -n 1 -s -r -p "Press any key to back"
       tweak
    fi
}

install_bbr() {
	clear
	echo -e "$CYAN━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
	echo -e "         $white BBR & TCP Tweaker     "
	echo -e "$CYAN━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    echo
	echo "Ini adalah skrip percubaan. Gunakan atas risiko anda sendiri!"
	echo "Skrip ini akan menukar beberapa network settings"
	echo "untuk mengurangkan latency dan meningkatkan kelajuan."
	echo ""
	read -p "Proceed with installation? [y/n]: " -e answer
	if [[ "$answer" = 'y' ]]; then
	install_bbr2
    else
    echo
    read -n 1 -s -r -p "Press any key to back"
    tweak
    fi
}

delete_Tweaker() {
	clear
	echo -e "$CYAN━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
	echo -e "         $white BBR & TCP Tweaker     "
	echo -e "$CYAN━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    echo
	read -p "Do you want to remove TCP Tweaker settings? [y/n]: " -e answer0
	if [[ "$answer0" = 'y' ]]; then
		grep -v "^#PH56
net.ipv4.tcp_window_scaling = 1
net.core.rmem_max = 16777216
net.core.wmem_max = 16777216
net.ipv4.tcp_rmem = 4096 87380 16777216
net.ipv4.tcp_wmem = 4096 16384 16777216
net.ipv4.tcp_low_latency = 1
net.ipv4.tcp_slow_start_after_idle = 0" /etc/sysctl.conf > /tmp/syscl && mv /tmp/syscl /etc/sysctl.conf
sysctl -p /etc/sysctl.conf > /dev/null
		echo ""
		echo "TCP Tweaker network settings were successfully removed."
		echo ""
        read -n 1 -s -r -p "Press any key to back"
        tweak
	else
		echo ""
		tweak
	fi
}


install_Tweaker() {
	clear
	echo -e "$CYAN━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
	echo -e "         $white BBR & TCP Tweaker     "
	echo -e "$CYAN━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    echo
	echo "Ini adalah skrip percubaan. Gunakan atas risiko anda sendiri!"
	echo "Skrip ini akan menukar beberapa network settings"
	echo "untuk mengurangkan latency dan meningkatkan kelajuan."
	echo ""
	read -p "Proceed with installation? [y/n]: " -e answer
	if [[ "$answer" = 'y' ]]; then
	echo ""
	echo "Modifying the following settings:"
	echo " " >> /etc/sysctl.conf
	echo "#PH56" >> /etc/sysctl.conf
echo "net.ipv4.tcp_window_scaling = 1
net.core.rmem_max = 16777216
net.core.wmem_max = 16777216
net.ipv4.tcp_rmem = 4096 87380 16777216
net.ipv4.tcp_wmem = 4096 16384 16777216
net.ipv4.tcp_low_latency = 1
net.ipv4.tcp_slow_start_after_idle = 0" >> /etc/sysctl.conf
echo ""
sysctl -p /etc/sysctl.conf > /dev/null
		echo "TCP Tweaker network settings have been added successfully."
		echo ""
        read -n 1 -s -r -p "Press any key to back"
        tweak
	else
		echo ""
		echo "Installation was canceled by the user!"
		echo ""
	fi
}

delete_Tweaker_2() {
	clear
	echo -e "$CYAN━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
	echo -e "         $white BBR & TCP Tweaker     "
	echo -e "$CYAN━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    echo
	read -p "Do you want to remove TCP Tweaker settings? [y/n]: " -e answer0
	if [[ "$answer0" = 'y' ]]; then
		grep -v "^##VpsPack
net.ipv4.tcp_fin_timeout = 2
net.ipv4.tcp_tw_reuse = 1
net.ipv4.tcp_syncookies = 1
net.ipv4.tcp_keepalive_time = 600
net.ipv4.ip_local_port_range = 2000 65000
net.ipv4.tcp_max_syn_backlog = 16384
net.ipv4.tcp_max_tw_buckets = 36000
net.ipv4.route.gc_timeout = 100
net.ipv4.tcp_syn_retries = 1
net.ipv4.tcp_synack_retries = 1
net.ipv4.tcp_max_orphans = 16384
net.core.somaxconn = 16384
net.core.netdev_max_backlog = 16384" /etc/sysctl.conf > /tmp/syscl && mv /tmp/syscl /etc/sysctl.conf
sysctl -p /etc/sysctl.conf > /dev/null
		echo ""
		echo "TCP Tweaker network settings were successfully removed."
		echo ""
        read -n 1 -s -r -p "Press any key to back"
        tweak
	else
		echo ""
		tweak
	fi
}


install_Tweaker_2() {
	clear
	echo -e "$CYAN━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
	echo -e "         $white BBR & TCP Tweaker     "
	echo -e "$CYAN━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    echo
	echo "Ini adalah skrip percubaan. Gunakan atas risiko anda sendiri!"
	echo "Skrip ini akan menukar beberapa network settings"
	echo "untuk mengurangkan latency dan meningkatkan kelajuan."
	echo ""
	read -p "Proceed with installation? [y/n]: " -e answer
	if [[ "$answer" = 'y' ]]; then
	echo ""
	echo "Modifying the following settings:"
	echo " " >> /etc/sysctl.conf
	echo "##VpsPack" >> /etc/sysctl.conf
    echo "net.ipv4.tcp_fin_timeout = 2
net.ipv4.tcp_tw_reuse = 1
net.ipv4.tcp_syncookies = 1
net.ipv4.tcp_keepalive_time = 600
net.ipv4.ip_local_port_range = 2000 65000
net.ipv4.tcp_max_syn_backlog = 16384
net.ipv4.tcp_max_tw_buckets = 36000
net.ipv4.route.gc_timeout = 100
net.ipv4.tcp_syn_retries = 1
net.ipv4.tcp_synack_retries = 1
net.ipv4.tcp_max_orphans = 16384
net.core.somaxconn = 16384
net.core.netdev_max_backlog = 16384" >> /etc/sysctl.conf
    echo ""
sysctl -p /etc/sysctl.conf > /dev/null
		echo "TCP Tweaker network settings have been added successfully."
		echo ""
        read -n 1 -s -r -p "Press any key to back"
        tweak
	else
		echo ""
		echo "Installation was canceled by the user!"
		echo ""
	fi
}

# menu tweaker
echo -e "$CYAN━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo -e "         $white BBR & TCP Tweaker     "
echo -e "$CYAN━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
tcp_status
tcp_2_status
bbr_status
echo
echo -e " [\e[36m•1\e[0m] Install BBR "
echo -e " [\e[36m•2\e[0m] Install TCP Tweaker "
echo -e " [\e[36m•3\e[0m] Install TCP Tweaker 2"
echo -e " [\e[36m•4\e[0m] Delete BBR "
echo -e " [\e[36m•5\e[0m] Delete TCP Tweaker"
echo -e " [\e[36m•6\e[0m] Delete TCP Tweaker 2"
echo -e ""
echo -e " [\e[31m•0\e[0m] \e[31mBACK TO MENU\033[0m"
echo -e   ""
echo -e "$CYAN━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "Type x atau [ Ctrl+C ] •Keluar-dari-Script"
echo -e ""
read -p "► Select menu :  "  opt
echo -e "$DF"
case $opt in
	1) install_bbr 2>&1 ;;
	2) install_Tweaker 2>&1 ;;
	3) install_Tweaker_2 2>&1 ;;
	4) delete_bbr ;;
	5) delete_Tweaker ;;
	6) delete_Tweaker_2 ;;
0) menu ;;
x) exit ;;
*) echo -e "" ; echo "Nombor Yang Anda Masukkan Salah!" ; sleep 2 ; menu ;;
esac
