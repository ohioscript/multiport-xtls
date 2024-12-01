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

#Optimasi Speed
Add_To_New_Line(){
	if [ "$(tail -n1 $1 | wc -l)" == "0"  ];then
		echo "" >> "$1"
	fi
	echo "$2" >> "$1"
}

Check_And_Add_Line(){
	if [ -z "$(cat "$1" | grep "$2")" ];then
		Add_To_New_Line "$1" "$2"
	fi
}

Install_BBR(){
echo "#############################################"
echo "Install TCP_BBR..."
if [ -n "$(lsmod | grep bbr)" ];then
echo "TCP_BBR sudah diinstall."
echo "#############################################"
return 1
fi
echo "Installing TCP_BBR..."
modprobe tcp_bbr
Add_To_New_Line "/etc/modules-load.d/modules.conf" "tcp_bbr"
Add_To_New_Line "/etc/sysctl.conf" "net.core.default_qdisc = fq"
Add_To_New_Line "/etc/sysctl.conf" "net.ipv4.tcp_congestion_control = bbr"
sysctl -p
if [ -n "$(sysctl net.ipv4.tcp_available_congestion_control | grep bbr)" ] && [ -n "$(sysctl net.ipv4.tcp_congestion_control | grep bbr)" ] && [ -n "$(lsmod | grep "tcp_bbr")" ];then
	echo "BBR berjaya di masukkan."
	sleep 2
else
	echo "TIDAK BERJAYA memasukkan BBR."
	sleep 2
fi
echo "#############################################"
}

Optimize_Parameters(){
echo "#############################################"
echo "Sedang Optimumkan Parameter..."
Check_And_Add_Line "/etc/security/limits.conf" "* soft nofile 65535"
Check_And_Add_Line "/etc/security/limits.conf" "* hard nofile 65535"
Check_And_Add_Line "/etc/security/limits.conf" "root soft nofile 51200"
Check_And_Add_Line "/etc/security/limits.conf" "root hard nofile 51200"
################################
##############################
Check_And_Add_Line "/etc/sysctl.conf" "net.ipv4.conf.all.route_localnet=1"
Check_And_Add_Line "/etc/sysctl.conf" "net.ipv4.ip_forward = 1"
Check_And_Add_Line "/etc/sysctl.conf" "net.ipv4.conf.all.forwarding = 1"
Check_And_Add_Line "/etc/sysctl.conf" "net.ipv4.conf.default.forwarding = 1"
################################
Check_And_Add_Line "/etc/sysctl.conf" "net.ipv6.conf.all.forwarding = 1"
Check_And_Add_Line "/etc/sysctl.conf" "net.ipv6.conf.default.forwarding = 1"
Check_And_Add_Line "/etc/sysctl.conf" "net.ipv6.conf.lo.forwarding = 1"
################################
Check_And_Add_Line "/etc/sysctl.conf" "net.ipv6.conf.all.disable_ipv6 = 0"
Check_And_Add_Line "/etc/sysctl.conf" "net.ipv6.conf.default.disable_ipv6 = 0"
Check_And_Add_Line "/etc/sysctl.conf" "net.ipv6.conf.lo.disable_ipv6 = 0"
################################
Check_And_Add_Line "/etc/sysctl.conf" "net.ipv6.conf.all.accept_ra = 2"
Check_And_Add_Line "/etc/sysctl.conf" "net.ipv6.conf.default.accept_ra = 2"
################################
Check_And_Add_Line "/etc/sysctl.conf" "net.core.netdev_budget = 50000"
Check_And_Add_Line "/etc/sysctl.conf" "net.core.netdev_budget_usecs = 5000"
Check_And_Add_Line "/etc/sysctl.conf" "#fs.file-max = 51200"
Check_And_Add_Line "/etc/sysctl.conf" "net.core.rmem_max = 67108864"
Check_And_Add_Line "/etc/sysctl.conf" "net.core.wmem_max = 67108864"
Check_And_Add_Line "/etc/sysctl.conf" "net.core.rmem_default = 67108864"
Check_And_Add_Line "/etc/sysctl.conf" "net.core.wmem_default = 67108864"
Check_And_Add_Line "/etc/sysctl.conf" "net.core.optmem_max = 65536"
Check_And_Add_Line "/etc/sysctl.conf" "net.core.somaxconn = 10000"
################################
Check_And_Add_Line "/etc/sysctl.conf" "net.ipv4.icmp_echo_ignore_all = 0"
Check_And_Add_Line "/etc/sysctl.conf" "net.ipv4.icmp_echo_ignore_broadcasts = 1"
Check_And_Add_Line "/etc/sysctl.conf" "net.ipv4.icmp_ignore_bogus_error_responses = 1"
Check_And_Add_Line "/etc/sysctl.conf" "net.ipv4.conf.all.accept_redirects = 0"
Check_And_Add_Line "/etc/sysctl.conf" "net.ipv4.conf.default.accept_redirects = 0"
Check_And_Add_Line "/etc/sysctl.conf" "net.ipv4.conf.all.secure_redirects = 0"
Check_And_Add_Line "/etc/sysctl.conf" "net.ipv4.conf.default.secure_redirects = 0"
Check_And_Add_Line "/etc/sysctl.conf" "net.ipv4.conf.all.send_redirects = 0"
Check_And_Add_Line "/etc/sysctl.conf" "net.ipv4.conf.default.send_redirects = 0"
Check_And_Add_Line "/etc/sysctl.conf" "net.ipv4.conf.default.rp_filter = 0"
Check_And_Add_Line "/etc/sysctl.conf" "net.ipv4.conf.all.rp_filter = 0"
Check_And_Add_Line "/etc/sysctl.conf" "net.ipv4.tcp_keepalive_time = 1200"
Check_And_Add_Line "/etc/sysctl.conf" "net.ipv4.tcp_keepalive_intvl = 15"
Check_And_Add_Line "/etc/sysctl.conf" "net.ipv4.tcp_keepalive_probes = 5"
Check_And_Add_Line "/etc/sysctl.conf" "net.ipv4.tcp_synack_retries = 2"
Check_And_Add_Line "/etc/sysctl.conf" "net.ipv4.tcp_syncookies = 0"
Check_And_Add_Line "/etc/sysctl.conf" "net.ipv4.tcp_rfc1337 = 0"
Check_And_Add_Line "/etc/sysctl.conf" "net.ipv4.tcp_timestamps = 1"
Check_And_Add_Line "/etc/sysctl.conf" "net.ipv4.tcp_tw_reuse = 1"
Check_And_Add_Line "/etc/sysctl.conf" "net.ipv4.tcp_fin_timeout = 15"
Check_And_Add_Line "/etc/sysctl.conf" "net.ipv4.ip_local_port_range = 1024 65535"
Check_And_Add_Line "/etc/sysctl.conf" "net.ipv4.tcp_max_tw_buckets = 2000000"
Check_And_Add_Line "/etc/sysctl.conf" "net.ipv4.tcp_fastopen = 3"
Check_And_Add_Line "/etc/sysctl.conf" "net.ipv4.tcp_rmem = 4096 87380 67108864"
Check_And_Add_Line "/etc/sysctl.conf" "net.ipv4.tcp_wmem = 4096 65536 67108864"
Check_And_Add_Line "/etc/sysctl.conf" "net.ipv4.udp_rmem_min = 8192"
Check_And_Add_Line "/etc/sysctl.conf" "net.ipv4.udp_wmem_min = 8192"
Check_And_Add_Line "/etc/sysctl.conf" "net.ipv4.tcp_mtu_probing = 0"
##############################
Check_And_Add_Line "/etc/sysctl.conf" "net.ipv4.conf.all.arp_ignore = 2"
Check_And_Add_Line "/etc/sysctl.conf" "net.ipv4.conf.default.arp_ignore = 2"
Check_And_Add_Line "/etc/sysctl.conf" "net.ipv4.conf.all.arp_announce = 2"
Check_And_Add_Line "/etc/sysctl.conf" "net.ipv4.conf.default.arp_announce = 2"
##############################
Check_And_Add_Line "/etc/sysctl.conf" "net.ipv4.tcp_autocorking = 0"
Check_And_Add_Line "/etc/sysctl.conf" "net.ipv4.tcp_slow_start_after_idle = 0"
Check_And_Add_Line "/etc/sysctl.conf" "net.ipv4.tcp_max_syn_backlog = 30000"
Check_And_Add_Line "/etc/sysctl.conf" "net.core.default_qdisc = fq"
Check_And_Add_Line "/etc/sysctl.conf" "net.ipv4.tcp_congestion_control = bbr"
Check_And_Add_Line "/etc/sysctl.conf" "net.ipv4.tcp_notsent_lowat = 16384"
Check_And_Add_Line "/etc/sysctl.conf" "net.ipv4.tcp_no_metrics_save = 1"
Check_And_Add_Line "/etc/sysctl.conf" "net.ipv4.tcp_ecn = 2"
Check_And_Add_Line "/etc/sysctl.conf" "net.ipv4.tcp_ecn_fallback = 1"
Check_And_Add_Line "/etc/sysctl.conf" "net.ipv4.tcp_frto = 0"
##############################
Check_And_Add_Line "/etc/sysctl.conf" "net.ipv6.conf.all.accept_redirects = 0"
Check_And_Add_Line "/etc/sysctl.conf" "net.ipv6.conf.default.accept_redirects = 0"
Check_And_Add_Line "/etc/sysctl.conf" "vm.swappiness = 1"
Check_And_Add_Line "/etc/sysctl.conf" "vm.overcommit_memory = 1"
Check_And_Add_Line "/etc/sysctl.conf" "#vm.nr_hugepages=1280"
Check_And_Add_Line "/etc/sysctl.conf" "kernel.pid_max=64000"
Check_And_Add_Line "/etc/sysctl.conf" "net.ipv4.neigh.default.gc_thresh3=8192"
Check_And_Add_Line "/etc/sysctl.conf" "net.ipv4.neigh.default.gc_thresh2=4096"
Check_And_Add_Line "/etc/sysctl.conf" "net.ipv4.neigh.default.gc_thresh1=2048"
Check_And_Add_Line "/etc/sysctl.conf" "net.ipv6.neigh.default.gc_thresh3=8192"
Check_And_Add_Line "/etc/sysctl.conf" "net.ipv6.neigh.default.gc_thresh2=4096"
Check_And_Add_Line "/etc/sysctl.conf" "net.ipv6.neigh.default.gc_thresh1=2048"
Check_And_Add_Line "/etc/sysctl.conf" "net.ipv4.tcp_max_syn_backlog = 262144"
Check_And_Add_Line "/etc/sysctl.conf" "net.netfilter.nf_conntrack_max = 262144"
Check_And_Add_Line "/etc/sysctl.conf" "net.nf_conntrack_max = 262144"

##############################
##############################
Check_And_Add_Line "/etc/systemd/system.conf" "DefaultTimeoutStopSec=30s"
Check_And_Add_Line "/etc/systemd/system.conf" "DefaultLimitCORE=infinity"
Check_And_Add_Line "/etc/systemd/system.conf" "DefaultLimitNOFILE=65535"

echo " Selesai Bossku."
echo "#############################################"
}
Install_BBR
Optimize_Parameters
rm -f /root/bbr.sh
menu
