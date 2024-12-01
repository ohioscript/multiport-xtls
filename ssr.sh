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
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

sh_ver="1.0.26"
filepath=$(cd "$(dirname "$0")"; pwd)
file=$(echo -e "${filepath}"|awk -F "$0" '{print $1}')
ssr_folder="/usr/local/shadowsocksr"
config_file="${ssr_folder}/config.json"
config_user_file="${ssr_folder}/user-config.json"
config_user_api_file="${ssr_folder}/userapiconfig.py"
config_user_mudb_file="${ssr_folder}/mudb.json"
ssr_log_file="${ssr_folder}/ssserver.log"
Libsodiumr_file="/usr/local/lib/libsodium.so"
Libsodiumr_ver_backup="1.0.17"
jq_file="${ssr_folder}/jq"
source /etc/os-release
OS=$ID
ver=$VERSION_ID

Green_font_prefix="\033[32m" && Red_font_prefix="\033[31m" && Green_background_prefix="\033[42;37m" && Red_background_prefix="\033[41;37m" && Font_color_suffix="\033[0m"
Info="${Green_font_prefix}[information]${Font_color_suffix}"
Error="${Red_font_prefix}[error]${Font_color_suffix}"
Tip="${Green_font_prefix}[note]${Font_color_suffix}"
Separator_1="——————————————————————————————"
check_pid(){
	PID=`ps -ef |grep -v grep | grep server.py |awk '{print $2}'`
}
Add_iptables(){
		iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport 1443:1543 -j ACCEPT
		iptables -I INPUT -m state --state NEW -m udp -p udp --dport 1443:1543 -j ACCEPT
}
Save_iptables(){
if [[ ${OS} == "centos" ]]; then
		service iptables save
		service ip6tables save
else
		iptables-save > /etc/iptables.up.rules
fi
}
Set_iptables(){
if [[ ${OS} == "centos" ]]; then
		service iptables save
		service ip6tables save
		chkconfig --level 2345 iptables on
		chkconfig --level 2345 ip6tables on
else
		iptables-save > /etc/iptables.up.rules
		echo -e '#!/bin/bash\n/sbin/iptables-restore < /etc/iptables.up.rules\n/sbin/ip6tables-restore < /etc/ip6tables.up.rules' > /etc/network/if-pre-up.d/iptables
		chmod +x /etc/network/if-pre-up.d/iptables
fi
}
Set_user_api_server_pub_addr(){
ip=$(wget -qO- ipv4.ipinfo.io/ip);
ssr_server_pub_addr="${ip}"
}
Modify_user_api_server_pub_addr(){
	sed -i "s/SERVER_PUB_ADDR = '${server_pub_addr}'/SERVER_PUB_ADDR = '${ssr_server_pub_addr}'/" ${config_user_api_file}
}
Check_python(){
if [[ ${OS} == "centos" ]]; then
if [[ $ver == '7' ]]; then
yum -y install python
elif [[ $ver == '8' ]]; then
yum install -y python2
alternatives --set python /usr/bin/python2
fi
else
apt-get install -y python
fi
}
Centos_yum(){
	yum update
	cat /etc/redhat-release |grep 7\..*|grep -i centos>/dev/null
	if [[ $? = 0 ]]; then
		yum install -y vim unzip crond net-tools git
	else
		yum install -y vim unzip crond git
	fi
}
Debian_apt(){
	apt-get update
	apt-get install -y vim unzip cron git net-tools
}
Download_SSR(){
	cd "/usr/local"
	git clone -b akkariiin/master https://github.com/shadowsocksrr/shadowsocksr.git
	cd "shadowsocksr"
	cp "${ssr_folder}/config.json" "${config_user_file}"
	cp "${ssr_folder}/mysql.json" "${ssr_folder}/usermysql.json"
	cp "${ssr_folder}/apiconfig.py" "${config_user_api_file}"
	sed -i "s/API_INTERFACE = 'sspanelv2'/API_INTERFACE = 'mudbjson'/" ${config_user_api_file}
	server_pub_addr="127.0.0.1"
	Modify_user_api_server_pub_addr
	sed -i 's/ \/\/ only works under multi-user mode//g' "${config_user_file}"
}
Service_SSR(){
if [[ ${OS} = "centos" ]]; then
	wget --no-check-certificate https://raw.githubusercontent.com/hybtoy/ssrrmu/master/ssrmu_centos -O /etc/init.d/ssrmu
chmod +x /etc/init.d/ssrmu
chkconfig --add ssrmu
chkconfig ssrmu on
else
	wget --no-check-certificate https://raw.githubusercontent.com/hybtoy/ssrrmu/master/ssrmu_debian -O /etc/init.d/ssrmu
chmod +x /etc/init.d/ssrmu
update-rc.d -f ssrmu defaults
fi
}
JQ_install(){
cd "${ssr_folder}"
wget --no-check-certificate "https://github.com/stedolan/jq/releases/download/jq-1.5/jq-linux64" -O ${jq_file}
chmod +x ${jq_file}
}
Installation_dependency(){
if [[ ${OS} == "centos" ]]; then
		Centos_yum
		service crond restart
	else
		Debian_apt
		/etc/init.d/cron restart
	fi
}
Start_SSR(){
	check_pid
	wget -O /etc/init.d/ssrmu "${gitlink}/${resourses}/ssrmu"
	/etc/init.d/ssrmu start
}
Install_SSR(){
Set_user_api_server_pub_addr
Check_python
Installation_dependency
Download_SSR
Service_SSR
JQ_install
Set_iptables
Add_iptables
Save_iptables
Start_SSR
}
Install_SSR
touch /usr/local/shadowsocksr/akun.conf
rm -f /root/ssr.sh
