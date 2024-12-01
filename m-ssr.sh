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

ssrmu() {
#PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
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
masaaktif=30
exp=`date -d "$masaaktif days" +"%Y-%m-%d"`
source /etc/os-release
OS=$ID

Green_font_prefix="\033[32m" && Red_font_prefix="\033[31m" && Green_background_prefix="\033[42;37m" && Red_background_prefix="\033[41;37m" && Font_color_suffix="\033[0m"
Info="${Green_font_prefix}[information]${Font_color_suffix}"
Error="${Red_font_prefix}[error]${Font_color_suffix}"
Tip="${Green_font_prefix}[note]${Font_color_suffix}"
Separator_1="——————————————————————————————"

check_pid(){
	PID=`ps -ef |grep -v grep | grep server.py |awk '{print $2}'`
}
SSR_installation_status(){
	[[ ! -e ${ssr_folder} ]] && echo -e "${Error} ShadowsocksR folder not found, please check! "&& exit 1
}
Add_iptables(){
	if [[ ! -z "${ssr_port}" ]]; then
		iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport ${ssr_port} -j ACCEPT
		iptables -I INPUT -m state --state NEW -m udp -p udp --dport ${ssr_port} -j ACCEPT
		ip6tables -I INPUT -m state --state NEW -m tcp -p tcp --dport ${ssr_port} -j ACCEPT
		ip6tables -I INPUT -m state --state NEW -m udp -p udp --dport ${ssr_port} -j ACCEPT
	fi
}
Del_iptables(){
	if [[ ! -z "${port}" ]]; then
		iptables -D INPUT -m state --state NEW -m tcp -p tcp --dport ${port} -j ACCEPT
		iptables -D INPUT -m state --state NEW -m udp -p udp --dport ${port} -j ACCEPT
		ip6tables -D INPUT -m state --state NEW -m tcp -p tcp --dport ${port} -j ACCEPT
		ip6tables -D INPUT -m state --state NEW -m udp -p udp --dport ${port} -j ACCEPT
	fi
}
Save_iptables(){
		if [[ ${OS} == "centos" ]]; then
		iptables-save > /etc/sysconfig/iptable
		ip6tables-save > /etc/sysconfig/ip6tables
else
		iptables-save > /etc/iptables.up.rules
		ip6tables-save > /etc/ip6tables.up.rules
fi
}
Set_iptables(){
		if [[ ${OS} == "centos" ]]; then
		iptables-save > /etc/sysconfig/iptable
		ip6tables-save > /etc/sysconfig/ip6tables
		chkconfig --level 2345 iptables on
		chkconfig --level 2345 ip6tables on
else
		iptables-save > /etc/iptables.up.rules
		ip6tables-save > /etc/ip6tables.up.rules
		echo -e '#!/bin/bash\n/sbin/iptables-restore < /etc/iptables.up.rules\n/sbin/ip6tables-restore < /etc/ip6tables.up.rules' > /etc/network/if-pre-up.d/iptables
		chmod +x /etc/network/if-pre-up.d/iptables
fi
}
# 读取 配置信息
Get_IP(){
	ip=$(wget -qO- -t1 -T2 ipinfo.io/ip)
	if [[ -z "${ip}" ]]; then
		ip=$(wget -qO- -t1 -T2 api.ip.sb/ip)
		if [[ -z "${ip}" ]]; then
			ip=$(wget -qO- -t1 -T2 members.3322.org/dyndns/getip)
			if [[ -z "${ip}" ]]; then
				ip="VPS_IP"
			fi
		fi
	fi
}
Get_User_info(){
	Get_user_port=$1
	user_info_get=$(python mujson_mgr.py -l -p "${Get_user_port}")
	match_info=$(echo "${user_info_get}"|grep -w "### user ")
	if [[ -z "${match_info}" ]]; then
		echo -e "${Error} Failed to get user information $ {Green Font Prefix} [Port: $ {ssh port}] $ {Font_color Suffix} " && exit 1
	fi
	user_name=$(echo "${user_info_get}"|grep -w "user :"|sed 's/[[:space:]]//g'|awk -F ":" '{print $NF}')
	port=$(echo "${user_info_get}"|grep -w "port :"|sed 's/[[:space:]]//g'|awk -F ":" '{print $NF}')
	password=$(echo "${user_info_get}"|grep -w "passwd :"|sed 's/[[:space:]]//g'|awk -F ":" '{print $NF}')
	method=$(echo "${user_info_get}"|grep -w "method :"|sed 's/[[:space:]]//g'|awk -F ":" '{print $NF}')
	protocol=$(echo "${user_info_get}"|grep -w "protocol :"|sed 's/[[:space:]]//g'|awk -F ":" '{print $NF}')
	protocol_param=$(echo "${user_info_get}"|grep -w "protocol_param :"|sed 's/[[:space:]]//g'|awk -F ":" '{print $NF}')
	[[ -z ${protocol_param} ]] && protocol_param="0(无限)"
	obfs=$(echo "${user_info_get}"|grep -w "obfs :"|sed 's/[[:space:]]//g'|awk -F ":" '{print $NF}')
	#transfer_enable=$(echo "${user_info_get}"|grep -w "transfer_enable :"|sed 's/[[:space:]]//g'|awk -F ":" '{print $NF}'|awk -F "ytes" '{print $1}'|sed 's/KB/ KB/;s/MB/ MB/;s/GB/ GB/;s/TB/ TB/;s/PB/ PB/')
	#u=$(echo "${user_info_get}"|grep -w "u :"|sed 's/[[:space:]]//g'|awk -F ":" '{print $NF}')
	#d=$(echo "${user_info_get}"|grep -w "d :"|sed 's/[[:space:]]//g'|awk -F ":" '{print $NF}')
	forbidden_port=$(echo "${user_info_get}"|grep -w "forbidden_port :"|sed 's/[[:space:]]//g'|awk -F ":" '{print $NF}')
	[[ -z ${forbidden_port} ]] && forbidden_port="Allow all"
	speed_limit_per_con=$(echo "${user_info_get}"|grep -w "speed_limit_per_con :"|sed 's/[[:space:]]//g'|awk -F ":" '{print $NF}')
	speed_limit_per_user=$(echo "${user_info_get}"|grep -w "speed_limit_per_user :"|sed 's/[[:space:]]//g'|awk -F ":" '{print $NF}')
	Get_User_transfer "${port}"
}
Get_User_transfer(){
	transfer_port=$1
	#echo "transfer_port=${transfer_port}"
	all_port=$(${jq_file} '.[]|.port' ${config_user_mudb_file})
	#echo "all_port=${all_port}"
	port_num=$(echo "${all_port}"|grep -nw "${transfer_port}"|awk -F ":" '{print $1}')
	#echo "port_num=${port_num}"
	port_num_1=$(expr ${port_num} - 1)
	#echo "port_num_1=${port_num_1}"
	transfer_enable_1=$(${jq_file} ".[${port_num_1}].transfer_enable" ${config_user_mudb_file})
	#echo "transfer_enable_1=${transfer_enable_1}"
	u_1=$(${jq_file} ".[${port_num_1}].u" ${config_user_mudb_file})
	#echo "u_1=${u_1}"
	d_1=$(${jq_file} ".[${port_num_1}].d" ${config_user_mudb_file})
	#echo "d_1=${d_1}"
	transfer_enable_Used_2_1=$(expr ${u_1} + ${d_1})
	#echo "transfer_enable_Used_2_1=${transfer_enable_Used_2_1}"
	transfer_enable_Used_1=$(expr ${transfer_enable_1} - ${transfer_enable_Used_2_1})
	#echo "transfer_enable_Used_1=${transfer_enable_Used_1}"
	
	
	if [[ ${transfer_enable_1} -lt 1024 ]]; then
		transfer_enable="${transfer_enable_1} B"
	elif [[ ${transfer_enable_1} -lt 1048576 ]]; then
		transfer_enable=$(awk 'BEGIN{printf "%.2f\n",'${transfer_enable_1}'/'1024'}')
		transfer_enable="${transfer_enable} KB"
	elif [[ ${transfer_enable_1} -lt 1073741824 ]]; then
		transfer_enable=$(awk 'BEGIN{printf "%.2f\n",'${transfer_enable_1}'/'1048576'}')
		transfer_enable="${transfer_enable} MB"
	elif [[ ${transfer_enable_1} -lt 1099511627776 ]]; then
		transfer_enable=$(awk 'BEGIN{printf "%.2f\n",'${transfer_enable_1}'/'1073741824'}')
		transfer_enable="${transfer_enable} GB"
	elif [[ ${transfer_enable_1} -lt 1125899906842624 ]]; then
		transfer_enable=$(awk 'BEGIN{printf "%.2f\n",'${transfer_enable_1}'/'1099511627776'}')
		transfer_enable="${transfer_enable} TB"
	fi
	#echo "transfer_enable=${transfer_enable}"
	if [[ ${u_1} -lt 1024 ]]; then
		u="${u_1} B"
	elif [[ ${u_1} -lt 1048576 ]]; then
		u=$(awk 'BEGIN{printf "%.2f\n",'${u_1}'/'1024'}')
		u="${u} KB"
	elif [[ ${u_1} -lt 1073741824 ]]; then
		u=$(awk 'BEGIN{printf "%.2f\n",'${u_1}'/'1048576'}')
		u="${u} MB"
	elif [[ ${u_1} -lt 1099511627776 ]]; then
		u=$(awk 'BEGIN{printf "%.2f\n",'${u_1}'/'1073741824'}')
		u="${u} GB"
	elif [[ ${u_1} -lt 1125899906842624 ]]; then
		u=$(awk 'BEGIN{printf "%.2f\n",'${u_1}'/'1099511627776'}')
		u="${u} TB"
	fi
	#echo "u=${u}"
	if [[ ${d_1} -lt 1024 ]]; then
		d="${d_1} B"
	elif [[ ${d_1} -lt 1048576 ]]; then
		d=$(awk 'BEGIN{printf "%.2f\n",'${d_1}'/'1024'}')
		d="${d} KB"
	elif [[ ${d_1} -lt 1073741824 ]]; then
		d=$(awk 'BEGIN{printf "%.2f\n",'${d_1}'/'1048576'}')
		d="${d} MB"
	elif [[ ${d_1} -lt 1099511627776 ]]; then
		d=$(awk 'BEGIN{printf "%.2f\n",'${d_1}'/'1073741824'}')
		d="${d} GB"
	elif [[ ${d_1} -lt 1125899906842624 ]]; then
		d=$(awk 'BEGIN{printf "%.2f\n",'${d_1}'/'1099511627776'}')
		d="${d} TB"
	fi
	#echo "d=${d}"
	if [[ ${transfer_enable_Used_1} -lt 1024 ]]; then
		transfer_enable_Used="${transfer_enable_Used_1} B"
	elif [[ ${transfer_enable_Used_1} -lt 1048576 ]]; then
		transfer_enable_Used=$(awk 'BEGIN{printf "%.2f\n",'${transfer_enable_Used_1}'/'1024'}')
		transfer_enable_Used="${transfer_enable_Used} KB"
	elif [[ ${transfer_enable_Used_1} -lt 1073741824 ]]; then
		transfer_enable_Used=$(awk 'BEGIN{printf "%.2f\n",'${transfer_enable_Used_1}'/'1048576'}')
		transfer_enable_Used="${transfer_enable_Used} MB"
	elif [[ ${transfer_enable_Used_1} -lt 1099511627776 ]]; then
		transfer_enable_Used=$(awk 'BEGIN{printf "%.2f\n",'${transfer_enable_Used_1}'/'1073741824'}')
		transfer_enable_Used="${transfer_enable_Used} GB"
	elif [[ ${transfer_enable_Used_1} -lt 1125899906842624 ]]; then
		transfer_enable_Used=$(awk 'BEGIN{printf "%.2f\n",'${transfer_enable_Used_1}'/'1099511627776'}')
		transfer_enable_Used="${transfer_enable_Used} TB"
	fi
	#echo "transfer_enable_Used=${transfer_enable_Used}"
	if [[ ${transfer_enable_Used_2_1} -lt 1024 ]]; then
		transfer_enable_Used_2="${transfer_enable_Used_2_1} B"
	elif [[ ${transfer_enable_Used_2_1} -lt 1048576 ]]; then
		transfer_enable_Used_2=$(awk 'BEGIN{printf "%.2f\n",'${transfer_enable_Used_2_1}'/'1024'}')
		transfer_enable_Used_2="${transfer_enable_Used_2} KB"
	elif [[ ${transfer_enable_Used_2_1} -lt 1073741824 ]]; then
		transfer_enable_Used_2=$(awk 'BEGIN{printf "%.2f\n",'${transfer_enable_Used_2_1}'/'1048576'}')
		transfer_enable_Used_2="${transfer_enable_Used_2} MB"
	elif [[ ${transfer_enable_Used_2_1} -lt 1099511627776 ]]; then
		transfer_enable_Used_2=$(awk 'BEGIN{printf "%.2f\n",'${transfer_enable_Used_2_1}'/'1073741824'}')
		transfer_enable_Used_2="${transfer_enable_Used_2} GB"
	elif [[ ${transfer_enable_Used_2_1} -lt 1125899906842624 ]]; then
		transfer_enable_Used_2=$(awk 'BEGIN{printf "%.2f\n",'${transfer_enable_Used_2_1}'/'1099511627776'}')
		transfer_enable_Used_2="${transfer_enable_Used_2} TB"
	fi
	#echo "transfer_enable_Used_2=${transfer_enable_Used_2}"
}
urlsafe_base64(){
	date=$(echo -n "$1"|base64|sed ':a;N;s/\n/ /g;ta'|sed 's/ //g;s/=//g;s/+/-/g;s/\//_/g')
	echo -e "${date}"
}
ssr_link_qr(){
	SSRprotocol=$(echo ${protocol} | sed 's/_compatible//g')
	SSRobfs=$(echo ${obfs} | sed 's/_compatible//g')
	SSRPWDbase64=$(urlsafe_base64 "${password}")
	SSRbase64=$(urlsafe_base64 "${ip}:${port}:${SSRprotocol}:${method}:${SSRobfs}:${SSRPWDbase64}")
	SSRurl="ssr://${SSRbase64}"
	ssr_link=" SSR   Link : ${Red_font_prefix}${SSRurl}${Font_color_suffix} \n"
}
ss_ssr_determine(){
	protocol_suffix=`echo ${protocol} | awk -F "_" '{print $NF}'`
	obfs_suffix=`echo ${obfs} | awk -F "_" '{print $NF}'`
	ssr_link_qr
}
# Display configuration information
View_User(){
	SSR_installation_status
	List_port_user
	while true
	do
		echo -e "Please enter the user port to view the account information"
		read -e -p "(Default: cancel):" View_user_port
		[[ -z "${View_user_port}" ]] && echo -e "cancel..." && exit 1
		View_user=$(cat "${config_user_mudb_file}"|grep '"port": '"${View_user_port}"',')
		if [[ ! -z ${View_user} ]]; then
			Get_User_info "${View_user_port}"
			View_User_info
			break
		else
			echo -e "${Error} Please enter the correct port !"
		fi
	done
}
View_User_info(){
	ip=$(cat ${config_user_api_file}|grep "SERVER_PUB_ADDR = "|awk -F "[']" '{print $2}')
	[[ -z "${ip}" ]] && Get_IP
	ss_ssr_determine
	clear && echo "===================================================" && echo
	echo -e " User [${user_name}] configuration info：" && echo
	echo -e " IP : ${Green_font_prefix}${ip}${Font_color_suffix}"
	echo -e " Port : ${Green_font_prefix}${port}${Font_color_suffix}"
	echo -e " Password : ${Green_font_prefix}${password}${Font_color_suffix}"
	echo -e " Encryption : ${Green_font_prefix}${method}${Font_color_suffix}"
	echo -e " Protocol : ${Red_font_prefix}${protocol}${Font_color_suffix}"
	echo -e " obfs : ${Red_font_prefix}${obfs}${Font_color_suffix}"
	echo -e " Device limit : ${Green_font_prefix}${protocol_param}${Font_color_suffix}"
	echo -e "${ssr_link}"
 	echo && echo "==================================================="
}
# 设置 配置信息
Set_config_enable(){
	user_total=$(expr ${user_total} - 1)
	for((integer = 0; integer <= ${user_total}; integer++))
	do
		echo -e "integer=${integer}"
		port_jq=$(${jq_file} ".[${integer}].port" "${config_user_mudb_file}")
		echo -e "port_jq=${port_jq}"
		if [[ "${ssr_port}" == "${port_jq}" ]]; then
			enable=$(${jq_file} ".[${integer}].enable" "${config_user_mudb_file}")
			echo -e "enable=${enable}"
			[[ "${enable}" == "null" ]] && echo -e "${Error} Get the current port[${ssr_port}]Disabled state failed !" && exit 1
			ssr_port_num=$(cat "${config_user_mudb_file}"|grep -n '"port": '${ssr_port}','|awk -F ":" '{print $1}')
			echo -e "ssr_port_num=${ssr_port_num}"
			[[ "${ssr_port_num}" == "null" ]] && echo -e "${Error} Get currentPort[${ssr_port}]Number of rows failed !" && exit 1
			ssr_enable_num=$(expr ${ssr_port_num} - 5)
			echo -e "ssr_enable_num=${ssr_enable_num}"
			break
		fi
	done
	if [[ "${enable}" == "1" ]]; then
		echo -e "Port [${ssr_port}] The account status is：${Green_font_prefix}Enabled ${Font_color_suffix} , switch to ${Red_font_prefix}Disabled${Font_color_suffix} ?[Y/n]"
		read -e -p "(Default: Y):" ssr_enable_yn
		[[ -z "${ssr_enable_yn}" ]] && ssr_enable_yn="y"
		if [[ "${ssr_enable_yn}" == [Yy] ]]; then
			ssr_enable="0"
		else
			echo "Cancel..." && exit 0
		fi
	elif [[ "${enable}" == "0" ]]; then
		echo -e "Port [${ssr_port}] The account status is：${Green_font_prefix}Disabled ${Font_color_suffix} , switch to ${Red_font_prefix}Disabled${Font_color_suffix} ?[Y/n]"
		read -e -p "(Default: Y):" ssr_enable_yn
		[[ -z "${ssr_enable_yn}" ]] && ssr_enable_yn = "y"
		if [[ "${ssr_enable_yn}" == [Yy] ]]; then
			ssr_enable="1"
		else
			echo "cancel..." && exit 0
		fi
	else
		echo -e "${Error} The disabled status of the current port varies[${enable}] !" && exit 1
	fi
}
Set_user_api_server_pub_addr(){
	addr=$1
	if [[ "${addr}" == "Modify" ]]; then
		server_pub_addr=$(cat ${config_user_api_file}|grep "SERVER_PUB_ADDR = "|awk -F "[']" '{print $2}')
		if [[ -z ${server_pub_addr} ]]; then
			echo -e "${Error} Failed to obtain the currently configured server IP or domain name！" && exit 1
		else
			echo -e "${Info} The currently configured server IP or domain name is： ${Green_font_prefix}${server_pub_addr}${Font_color_suffix}"
		fi
	fi
	echo "Please enter the server IP or domain name to be displayed in the user's configuration (when the server has multiple IPs, you can specify the IP or domain name displayed in the user's configuration)"
	read -e -p "(Default: Automatic detection of external network IP):" ssr_server_pub_addr
	if [[ -z "${ssr_server_pub_addr}" ]]; then
		Get_IP
		if [[ ${ip} == "VPS_IP" ]]; then
			while true
			do
			read -e -p "${Error} Automatic detection of external network IP failed, please manually enter the server IP or domain name" ssr_server_pub_addr
			if [[ -z "$ssr_server_pub_addr" ]]; then
				echo -e "${Error} Can not be empty！"
			else
				break
			fi
			done
		else
			ssr_server_pub_addr="${ip}"
		fi
	fi
	echo && echo ${Separator_1} && echo -e "	IP or domain name : ${Green_font_prefix}${ssr_server_pub_addr}${Font_color_suffix}" && echo ${Separator_1} && echo
}
Set_config_all(){
	lal=$1
	if [[ "${lal}" == "Modify" ]]; then
		Set_config_password
		Set_config_method
		Set_config_protocol
		Set_config_obfs
		Set_config_protocol_param
		Set_config_speed_limit_per_con
		Set_config_speed_limit_per_user
		Set_config_transfer
		Set_config_forbid
	else
		Set_config_user
		Set_config_port
		Set_config_password
		Set_config_method
		Set_config_protocol
		Set_config_obfs
		Set_config_protocol_param
		Set_config_speed_limit_per_con
		Set_config_speed_limit_per_user
		Set_config_transfer
		Set_config_forbid
	fi
}
Modify_config_password(){
	match_edit=$(python mujson_mgr.py -e -p "${ssr_port}" -k "${ssr_password}"|grep -w "edit user ")
	if [[ -z "${match_edit}" ]]; then
		echo -e "${Error} User password modification failed ${Green_font_prefix}[Port: ${ssr_port}]${Font_color_suffix} " && exit 1
	else
		echo -e "${Info} User password modified successfully ${Green_font_prefix}[Port: ${ssr_port}]${Font_color_suffix} (It may take about 10 seconds to apply the latest configuration)"
	fi
}
Modify_config_enable(){
	sed -i "${ssr_enable_num}"'s/"enable": '"$(echo ${enable})"',/"enable": '"$(echo ${ssr_enable})"',/' ${config_user_mudb_file}
}
Modify_user_api_server_pub_addr(){
	sed -i "s/SERVER_PUB_ADDR = '${server_pub_addr}'/SERVER_PUB_ADDR = '${ssr_server_pub_addr}'/" ${config_user_api_file}
}
centos_View_user_connection_info(){
	format_1=$1
	user_info=$(python mujson_mgr.py -l)
	user_total=$(echo "${user_info}"|wc -l)
	[[ -z ${user_info} ]] && echo -e "${Error} Didn't find the user, please check again !" && exit 1
	IP_total=`netstat -anp |grep 'ESTABLISHED' |grep 'python' |grep 'tcp' | grep '::ffff:' |awk '{print $5}' |awk -F ":" '{print $4}' |sort -u |wc -l`
	user_list_all=""
	for((integer = 1; integer <= ${user_total}; integer++))
	do
		user_port=$(echo "${user_info}"|sed -n "${integer}p"|awk '{print $4}')
		user_IP_1=`netstat -anp |grep 'ESTABLISHED' |grep 'python' |grep 'tcp' |grep ":${user_port} "|grep '::ffff:' |awk '{print $5}' |awk -F ":" '{print $4}' |sort -u`
		if [[ -z ${user_IP_1} ]]; then
			user_IP_total="0"
		else
			user_IP_total=`echo -e "${user_IP_1}"|wc -l`
			if [[ ${format_1} == "IP_address" ]]; then
				get_IP_address
			else
				user_IP=`echo -e "\n${user_IP_1}"`
			fi
		fi
		user_list_all=${user_list_all}"Port: ${Green_font_prefix}"${user_port}"${Font_color_suffix}, The total number of linked IPs: ${Green_font_prefix}"${user_IP_total}"${Font_color_suffix}, Current linked IP: ${Green_font_prefix}${user_IP}${Font_color_suffix}\n"
		user_IP=""
	done
	echo -e "The total number of users: ${Green_background_prefix} "${user_total}" ${Font_color_suffix} ，The total number of linked IPs: ${Green_background_prefix} "${IP_total}" ${Font_color_suffix} "
	echo -e "${user_list_all}"
}
debian_View_user_connection_info(){
	format_1=$1
	user_info=$(python mujson_mgr.py -l)
	user_total=$(echo "${user_info}"|wc -l)
	[[ -z ${user_info} ]] && echo -e "${Error} Didn't find the user, please check again! " && exit 1
	IP_total=`netstat -anp |grep 'ESTABLISHED' |grep 'python' |grep 'tcp6' |awk '{print $5}' |awk -F ":" '{print $1}' |sort -u |wc -l`
	user_list_all=""
	for((integer = 1; integer <= ${user_total}; integer++))
	do
		user_port=$(echo "${user_info}"|sed -n "${integer}p"|awk '{print $4}')
		user_IP_1=`netstat -anp |grep 'ESTABLISHED' |grep 'python' |grep 'tcp6' |grep ":${user_port} " |awk '{print $5}' |awk -F ":" '{print $1}' |sort -u`
		if [[ -z ${user_IP_1} ]]; then
			user_IP_total="0"
		else
			user_IP_total=`echo -e "${user_IP_1}"|wc -l`
			if [[ ${format_1} == "IP_address" ]]; then
				get_IP_address
			else
				user_IP=`echo -e "\n${user_IP_1}"`
			fi
		fi
		user_list_all=${user_list_all}"Port: ${Green_font_prefix}"${user_port}"${Font_color_suffix}, The total number of linked IPs: ${Green_font_prefix}"${user_IP_total}"${Font_color_suffix}, Current linked IP: ${Green_font_prefix}${user_IP}${Font_color_suffix}\n"
		user_IP=""
	done
	echo -e "The total number of users: ${Green_background_prefix} "${user_total}" ${Font_color_suffix} ，The total number of linked IPs: ${Green_background_prefix} "${IP_total}" ${Font_color_suffix} "
	echo -e "${user_list_all}"
}
View_user_connection_info(){
	SSR_installation_status
	echo && echo -e "Please select the format to display：
 ${Green_font_prefix}1.${Font_color_suffix} display IP 
 ${Green_font_prefix}2.${Font_color_suffix} display IP+Resolve the DNS name " && echo
	read -e -p "(Default: 1):" ssr_connection_info
	[[ -z "${ssr_connection_info}" ]] && ssr_connection_info="1"
	if [[ ${ssr_connection_info} == "1" ]]; then
		View_user_connection_info_1 ""
	elif [[ ${ssr_connection_info} == "2" ]]; then
		echo -e "${Tip} Detect IP (ipip.net)，it can take longer time if there are many IPs"
		View_user_connection_info_1 "IP_address"
	else
		echo -e "${Error} Please enter the correct number(1-2)" && exit 1
	fi
}
View_user_connection_info_1(){
	format=$1
	if [[ ${release} = "centos" ]]; then
		cat /etc/redhat-release |grep 7\..*|grep -i centos>/dev/null
		if [[ $? = 0 ]]; then
			debian_View_user_connection_info "$format"
		else
			centos_View_user_connection_info "$format"
		fi
	else
		debian_View_user_connection_info "$format"
	fi
}
get_IP_address(){
	if [[ ! -z ${user_IP_1} ]]; then
		for((integer_1 = ${user_IP_total}; integer_1 >= 1; integer_1--))
		do
			IP=`echo "${user_IP_1}" |sed -n "$integer_1"p`
			IP_address=`wget -qO- -t1 -T2 http://freeapi.ipip.net/${IP}|sed 's/\"//g;s/,//g;s/\[//g;s/\]//g'`
			user_IP="${user_IP}\n${IP}(${IP_address})"
			sleep 1s
		done
	fi
}
List_port_user(){
	user_info=$(python mujson_mgr.py -l)
	user_total=$(echo "${user_info}"|wc -l)
	[[ -z ${user_info} ]] && echo -e "${Error} Didn't find the user, please check again! " && exit 1
	user_list_all=""
	for((integer = 1; integer <= ${user_total}; integer++))
	do
		user_port=$(echo "${user_info}"|sed -n "${integer}p"|awk '{print $4}')
		user_username=$(echo "${user_info}"|sed -n "${integer}p"|awk '{print $2}'|sed 's/\[//g;s/\]//g')
		Get_User_transfer "${user_port}"
		user_list_all=${user_list_all}"Username: ${Green_font_prefix} "${user_username}"${Font_color_suffix} Port: ${Green_font_prefix}"${user_port}"${Font_color_suffix} Traffic usage (used + remaining = total): ${Green_font_prefix}${transfer_enable_Used_2}${Font_color_suffix} + ${Green_font_prefix}${transfer_enable_Used}${Font_color_suffix} = ${Green_font_prefix}${transfer_enable}${Font_color_suffix}\n"
	done
	echo && echo -e "=== Total of all users ${Green_background_prefix} "${user_total}" ${Font_color_suffix}"
	echo -e ${user_list_all}
}
Manually_Modify_Config(){
	SSR_installation_status
	nano ${config_user_mudb_file}
	echo "Do you want to restart ShadowsocksR? [Y/n]" && echo
	read -e -p "(Default: y):" yn
	[[ -z ${yn} ]] && yn="y"
	if [[ ${yn} == [Yy] ]]; then
		Restart_SSR
	fi
}
Clear_transfer(){
	SSR_installation_status
	echo && echo -e "What do you want to do?
 ${Green_font_prefix}1.${Font_color_suffix}  Clear single user traffic
 ${Green_font_prefix}2.${Font_color_suffix}  Clear all user traffic (irreparable)
 ${Green_font_prefix}3.${Font_color_suffix}  All user traffic is cleared on startup
 ${Green_font_prefix}4.${Font_color_suffix}  Stop timing all user traffic
 ${Green_font_prefix}5.${Font_color_suffix}  Modify the timing of all user traffic" && echo
	read -e -p "(Default: batal):" ssr_modify
	[[ -z "${ssr_modify}" ]] && echo "Dibatalkan..." && exit 1
	if [[ ${ssr_modify} == "1" ]]; then
		Clear_transfer_one
	elif [[ ${ssr_modify} == "2" ]]; then
		echo "Are you sure you want to clear all user traffic[y/N]" && echo
		read -e -p "(Default: n):" yn
		[[ -z ${yn} ]] && yn="n"
		if [[ ${yn} == [Yy] ]]; then
			Clear_transfer_all
		else
			echo "cancel..."
		fi
	elif [[ ${ssr_modify} == "3" ]]; then
		check_crontab
		Set_crontab
		Clear_transfer_all_cron_start
	elif [[ ${ssr_modify} == "4" ]]; then
		check_crontab
		Clear_transfer_all_cron_stop
	elif [[ ${ssr_modify} == "5" ]]; then
		check_crontab
		Clear_transfer_all_cron_modify
	else
		echo -e "${Error} Please enter the correct number (1-5) " && exit 1
	fi
}
Clear_transfer_one(){
	List_port_user
	while true
	do
		echo -e "Please enter the port of the user who wants to reset the data"
		read -e -p "(Default: batal):" Clear_transfer_user_port
		[[ -z "${Clear_transfer_user_port}" ]] && echo -e "Dibatalkan..." && exit 1
		Clear_transfer_user=$(cat "${config_user_mudb_file}"|grep '"port": '"${Clear_transfer_user_port}"',')
		if [[ ! -z ${Clear_transfer_user} ]]; then
			match_clear=$(python mujson_mgr.py -c -p "${Clear_transfer_user_port}"|grep -w "clear user ")
			if [[ -z "${match_clear}" ]]; then
				echo -e "${Error} Failed to reset data used by the user ${Green_font_prefix}[Port: ${Clear_transfer_user_port}]${Font_color_suffix} "
			else
				echo -e "${Info} Successfully reseted user-used data${Green_font_prefix}[Port: ${Clear_transfer_user_port}]${Font_color_suffix} "
			fi
			break
		else
			echo -e "${Error} Please enter the correct Port!"
		fi
	done
}
Clear_transfer_all(){
	cd "${ssr_folder}"
	user_info=$(python mujson_mgr.py -l)
	user_total=$(echo "${user_info}"|wc -l)
	[[ -z ${user_info} ]] && echo -e "${Error} No users were found, please check!" && exit 1
	for((integer = 1; integer <= ${user_total}; integer++))
	do
		user_port=$(echo "${user_info}"|sed -n "${integer}p"|awk '{print $4}')
		match_clear=$(python mujson_mgr.py -c -p "${user_port}"|grep -w "clear user ")
		if [[ -z "${match_clear}" ]]; then
			echo -e "${Error} Failed to reset data used by the user ${Green_font_prefix}[Port: ${user_port}]${Font_color_suffix} "
		else
			echo -e "${Info} The user has successfully reset traffic ${Green_font_prefix}[Port: ${user_port}]${Font_color_suffix} "
		fi
	done
	echo -e "${Info} All user traffic is removed! "
}
Clear_transfer_all_cron_start(){
	crontab -l > "$file/crontab.bak"
	sed -i "/ssrmu.sh/d" "$file/crontab.bak"
	echo -e "\n${Crontab_time} /bin/bash $file/ssrmu.sh clearall" >> "$file/crontab.bak"
	crontab "$file/crontab.bak"
	rm -r "$file/crontab.bak"
	cron_config=$(crontab -l | grep "ssrmu.sh")
	if [[ -z ${cron_config} ]]; then
		echo -e "${Error} Failed to reset all user traffic at normal time!" && exit 1
	else
		echo -e "${Info} All user traffic is cleared and it starts successfully!"
	fi
}
Clear_transfer_all_cron_stop(){
	crontab -l > "$file/crontab.bak"
	sed -i "/ssrmu.sh/d" "$file/crontab.bak"
	crontab "$file/crontab.bak"
	rm -r "$file/crontab.bak"
	cron_config=$(crontab -l | grep "ssrmu.sh")
	if [[ ! -z ${cron_config} ]]; then
		echo -e "${Error} Fail to clear all user traffic regularly to quit!" && exit 1
	else
		echo -e "${Info}All user traffic is cleaned regularly and stopped successfully!"
	fi
}
Clear_transfer_all_cron_modify(){
	Set_crontab
	Clear_transfer_all_cron_stop
	Clear_transfer_all_cron_start
}
Set_crontab(){
		echo -e "Please enter an interval to clear the flow
 === Format Description ===
 * * * * * In accordance with the minutes, hours, days, months, weeks
 ${Green_font_prefix} 0 2 1 * * ${Font_color_suffix} On behalf of every month at 2 o'clock on the 1st, clean used traffic
 ${Green_font_prefix} 0 2 15 * * ${Font_color_suffix} On the 15th of each month at 2: 0 pm Remove used traffic
 ${Green_font_prefix} 0 2 */7 * * ${Font_color_suffix} Used traffic will be cleared at 2 o'clock every 7 days
 ${Green_font_prefix} 0 2 * * 0 ${Font_color_suffix} Every Sunday (7) clean the flow used
 ${Green_font_prefix} 0 2 * * 3 ${Font_color_suffix} every Wednesday (3) clear the flow used" && echo
	read -e -p "(Default: 0 2 1 * * 2 o'clock on the 1st of every month):" Crontab_time
	[[ -z "${Crontab_time}" ]] && Crontab_time="0 2 1 * *"
}
Start_SSR(){
	SSR_installation_status
	check_pid
	[[ ! -z ${PID} ]] && echo -e "${Error} ShadowsocksR Running! " && exit 1
	/etc/init.d/ssrmu start
}
Stop_SSR(){
	SSR_installation_status
	check_pid
	[[ -z ${PID} ]] && echo -e "${Error} ShadowsocksR Is Not Running" && exit 1
	/etc/init.d/ssrmu stop
}
Restart_SSR(){
	SSR_installation_status
	check_pid
	[[ ! -z ${PID} ]] && /etc/init.d/ssrmu stop
	/etc/init.d/ssrmu start
}
View_Log(){
	SSR_installation_status
	[[ ! -e ${ssr_log_file} ]] && echo -e "${Error} The Shadowsocks log file does not exist! " && exit 1
	echo && echo -e "${Tip} Click ${Red_font_prefix}Ctrl+C${Font_color_suffix} Stop Displaying logs " && echo
	tail -f ${ssr_log_file}
}
Update_Shell(){
	echo -e "The current version is [$ {sh_ver}], start checking for the latest version ... "
	sh_new_ver=$(wget --no-check-certificate -qO- "https://raw.githubusercontent.com/hybtoy/ssrrmu/master/ssrrmu.sh"|grep 'sh_ver="'|awk -F "=" '{print $NF}'|sed 's/\"//g'|head -1) && sh_new_type="github"
	[[ -z ${sh_new_ver} ]] && sh_new_ver=$(wget --no-check-certificate -qO- "https://raw.githubusercontent.com/hybtoy/ssrrmu/master/ssrrmu.sh"|grep 'sh_ver="'|awk -F "=" '{print $NF}'|sed 's/\"//g'|head -1) && sh_new_type="github"
	[[ -z ${sh_new_ver} ]] && echo -e "${Error} Failed to detect the latest version! " && exit 0
	if [[ ${sh_new_ver} != ${sh_ver} ]]; then
		echo -e "Versi baru ditemukan[ ${sh_new_ver} ]，Do you want to be updated? [Y/n]"
		read -e -p "(default: y):" yn
		[[ -z "${yn}" ]] && yn="y"
		if [[ ${yn} == [Yy] ]]; then
			cd "${file}"
			if [[ $sh_new_type == "github" ]]; then
				wget -N --no-check-certificate https://raw.githubusercontent.com/hybtoy/ssrrmu/master/ssrrmu.sh && chmod +x ssrrmu.sh
			fi
			echo -e "The Script Has Been Updated To The Latest Version..."
		else
			echo && echo "cancel..." && echo
		fi
	else
		echo -e "Currently The Latest Version[ ${sh_new_ver} ] !"
	fi
	exit 0
}
menu_status(){
	if [[ -e ${ssr_folder} ]]; then
		check_pid
		if [[ ! -z "${PID}" ]]; then
			echo -e "  Current status: ${Green_font_prefix} Installed${Font_color_suffix} & ${Green_font_prefix} Running${Font_color_suffix}"
		else
			echo -e "  Current status: ${Green_font_prefix} Installed${Font_color_suffix} but ${Red_font_prefix} Not Running${Font_color_suffix}"
		fi
		cd "${ssr_folder}"
	else
		echo -e " Current status: ${Red_font_prefix}tidak terinstall${Font_color_suffix}"
	fi
}
if [[ "${action}" == "clearall" ]]; then
	Clear_transfer_all
elif [[ "${action}" == "monitor" ]]; then
	crontab_monitor_ssr
else
menu_status
echo -e "\033[0;34m------------------------------------\033[0m"
echo -e "\E[44;1;39m           Menu ShadowsocksR        \E[0m"
echo -e "\033[0;34m------------------------------------\033[0m"
echo -e "Versi: ${Green_font_prefix}[v${sh_ver}]${Font_color_suffix}"
echo ""
echo -e " [\e[36m 01 \e[0m] Check the account information"
echo -e " [\e[36m 02 \e[0m] Display the connection information"
echo -e " [\e[36m 03 \e[0m] Change Password User"
echo -e " [\e[36m 04 \e[0m] Manually Modify User Configuration"
echo -e " [\e[36m 05 \e[0m] Clear The Used Traffic"
echo -e " [\e[36m 06 \e[0m] Start ShadowsocksR"
echo -e " [\e[36m 07 \e[0m] Stop ShadowsocksR"
echo -e " [\e[36m 08 \e[0m] Restart ShadowsocksR"
echo -e " [\e[36m 09 \e[0m] Cek ShadowsocksR log"
echo -e " [\e[36m 10 \e[0m] Upgrade script"
echo ""
echo -e "Press x or [ Ctrl+C ]   To-Exit"
echo -e ""
echo -e "\033[0;34m------------------------------------\033[0m"
echo -e "${Tip} Username And User Port Can Not Be Changed,
If You Need To Modify,Use The Script To Manually Change 
The Function!"
echo ""
read -p " Select menu : " opt
echo -e ""
case $opt in
1)
    clear
    View_User
    ;;
2)
    clear
    View_user_connection_info
    ;;
3)
    clear
    Modify_port
    Set_config_password
    Modify_config_password
    ;;
4)
    clear
    Manually_Modify_Config
    ;;
5)
    clear
    Clear_transfer
    ;;
6)
    clear
    Start_SSR
    ;;
7)
    clear
    Stop_SSR
    ;;
8)
    clear
    Restart_SSR
    ;;
9)
    clear
    View_Log
    ;;
10)
    clear
    Update_Shell
    ;;
x)  
    clear
    menu
    ;;
*)
    echo -e ""
    echo "Please enter an correct number"
    sleep 1
    m-ssr
    ;;
esac
fi
}

add-ssr () {
IP=$(wget -qO- ipinfo.io/ip);
echo "Please enter the username you want to set (do not repeat, does not support Chinese, will be reported incorrect!)"
read -e -p "(Default: ):" ssr_user
CLIENT_EXISTS=$(grep -w $ssr_user /usr/local/shadowsocksr/akun.conf | wc -l)
if [[ ${CLIENT_EXISTS} == '1' ]]; then
echo ""
echo "A client with the specified name was already created, please choose another name."
exit 1
fi
read -p "Expired (days): " masaaktif
exp=`date -d "$masaaktif days" +"%Y-%m-%d"`
lastport=$(cat /usr/local/shadowsocksr/mudb.json | grep '"port": ' | tail -n1 | awk '{print $2}' | cut -d "," -f 1 | cut -d ":" -f 1 )
if [[ $lastport == '' ]]; then
ssr_port=1443
else
ssr_port=$((lastport+1))
fi
ssr_password="$ssr_user"
ssr_method="aes-256-cfb"
ssr_protocol="origin"
ssr_obfs="tls1.2_ticket_auth_compatible"
ssr_protocol_param="2"
ssr_speed_limit_per_con=0
ssr_speed_limit_per_user=0
ssr_transfer="838868"
ssr_forbid="bittorrent"
cd /usr/local/shadowsocksr
match_add=$(python mujson_mgr.py -a -u "${ssr_user}" -p "${ssr_port}" -k "${ssr_password}" -m "${ssr_method}" -O "${ssr_protocol}" -G "${ssr_protocol_param}" -o "${ssr_obfs}" -s "${ssr_speed_limit_per_con}" -S "${ssr_speed_limit_per_user}" -t "${ssr_transfer}" -f "${ssr_forbid}"|grep -w "add user info")
cd
echo -e "${Info} Penambahan user berhasil [username: ${ssr_user}]"
echo -e "### $ssr_user $exp" >> /usr/local/shadowsocksr/akun.conf
tmp1=$(echo -n "${ssr_password}" | base64 -w0 | sed 's/=//g;s/\//_/g;s/+/-/g')
SSRobfs=$(echo ${ssr_obfs} | sed 's/_compatible//g')
tmp2=$(echo -n "$IP:${ssr_port}:${ssr_protocol}:${ssr_method}:${SSRobfs}:${tmp1}/obfsparam=" | base64 -w0)
ssr_link="ssr://${tmp2}"
/etc/init.d/ssrmu restart
service cron restart
IP=$(wget -qO- ifconfig.co);
clear && echo && echo "===================================================" && echo
echo -e " User [${ssr_user}] configuration info："
echo -e " IP            : ${IP}"
echo -e " Port          : ${ssr_port}"
echo -e " Password      : ${ssr_password}"
echo -e " Encryption    : ${ssr_method}"
echo -e " Protocol      : ${Red_font_prefix}${ssr_protocol}"
echo -e " Obfs          : ${Red_font_prefix}${ssr_obfs}"
echo -e " Device limit  : ${ssr_protocol_param}"
echo -e " Expired On    : ${exp} "
echo -e " ==================================================="
echo -e " Link SSR      : ${ssr_link}"
echo -e " ==================================================="
}

add-ss () {
IP=$(wget -qO- ipinfo.io/ip);
lastport1=$(grep "port_tls" /etc/shadowsocks-libev/akun.conf | tail -n1 | awk '{print $2}')
lastport2=$(grep "port_http" /etc/shadowsocks-libev/akun.conf | tail -n1 | awk '{print $2}')
if [[ $lastport1 == '' ]]; then
tls=2443
else
tls="$((lastport1+1))"
fi
if [[ $lastport2 == '' ]]; then
http=3443
else
http="$((lastport2+1))"
fi
echo ""
echo "Masukkan password"

until [[ $user =~ ^[a-zA-Z0-9_]+$ && ${CLIENT_EXISTS} == '0' ]]; do
		read -rp "Password: " -e user
		CLIENT_EXISTS=$(grep -w $user /etc/shadowsocks-libev/akun.conf | wc -l)

		if [[ ${CLIENT_EXISTS} == '1' ]]; then
			echo ""
			echo "A client with the specified name was already created, please choose another name."
			exit 1
		fi
	done
read -p "Expired (hari): " masaaktif
exp=`date -d "$masaaktif days" +"%Y-%m-%d"`
cat > /etc/shadowsocks-libev/$user-tls.json<<END
{   
    "server":"0.0.0.0",
    "server_port":$tls,
    "password":"$user",
    "timeout":60,
    "method":"aes-256-cfb",
    "fast_open":true,
    "no_delay":true,
    "nameserver":"8.8.8.8",
    "mode":"tcp_and_udp",
    "plugin":"obfs-server",
    "plugin_opts":"obfs=tls"
}
END
cat > /etc/shadowsocks-libev/$user-http.json <<-END
{
    "server":"0.0.0.0",
    "server_port":$http,
    "password":"$user",
    "timeout":60,
    "method":"aes-256-cfb",
    "fast_open":true,
    "no_delay":true,
    "nameserver":"8.8.8.8",
    "mode":"tcp_and_udp",
    "plugin":"obfs-server",
    "plugin_opts":"obfs=http"
}
END
chmod +x /etc/shadowsocks-libev/$user-tls.json
chmod +x /etc/shadowsocks-libev/$user-http.json

systemctl start shadowsocks-libev-server@$user-tls.service
systemctl enable shadowsocks-libev-server@$user-tls.service
systemctl start shadowsocks-libev-server@$user-http.service
systemctl enable shadowsocks-libev-server@$user-http.service
tmp1=$(echo -n "aes-256-cfb:${user}@${IP}:$tls" | base64 -w0)
tmp2=$(echo -n "aes-256-cfb:${user}@${IP}:$http" | base64 -w0)
linkss1="ss://${tmp1}?plugin=obfs-local;obfs=tls;obfs-host=bing.com"
linkss2="ss://${tmp2}?plugin=obfs-local;obfs=http;obfs-host=bing.com"
echo -e "### $user $exp
port_tls $tls
port_http $http">>"/etc/shadowsocks-libev/akun.conf"
service cron restart
clear
	echo -e ""
	echo -e "=========-Shadowsocks-========="
	echo -e "    AUTOSCRIPT BY VPN LEGASI   "
    echo -e "==============================="
    echo -e "IP/Host        : $IP"
	echo -e "Port OBFS TLS  : $tls"
	echo -e "Port OBFS HTTP : $http"
	echo -e "Password       : $user"
	echo -e "Method         : aes-256-cfb"
	echo -e "Expired On     : $exp"
	echo -e "==============================="
	echo -e "Link OBFS TLS  : $linkss1"
	echo -e "==============================="
	echo -e "Link OBFS HTTP : $linkss2"
	echo -e "==============================="
}

del-ssr () {
NUMBER_OF_CLIENTS=$(grep -c -E "^### " "/usr/local/shadowsocksr/akun.conf")
	if [[ ${NUMBER_OF_CLIENTS} == '0' ]]; then
		clear
		echo ""
		echo "You have no existing clients!"
		exit 1
	fi

	clear
	echo ""
	echo " Select the existing client you want to remove"
	echo " Press CTRL+C to return"
	echo " ==============================="
	echo "     No  Expired   User"
	grep -E "^### " "/usr/local/shadowsocksr/akun.conf" | cut -d ' ' -f 2-3 | nl -s ') '
	until [[ ${CLIENT_NUMBER} -ge 1 && ${CLIENT_NUMBER} -le ${NUMBER_OF_CLIENTS} ]]; do
		if [[ ${CLIENT_NUMBER} == '1' ]]; then
			read -rp "Select one client [1]: " CLIENT_NUMBER
		else
			read -rp "Select one client [1-${NUMBER_OF_CLIENTS}]: " CLIENT_NUMBER
		fi
	done

	# match the selected number to a client name
	CLIENT_NAME=$(grep -E "^### " "/usr/local/shadowsocksr/akun.conf" | cut -d ' ' -f 2-3 | sed -n "${CLIENT_NUMBER}"p)
	user=$(grep -E "^### " "/usr/local/shadowsocksr/akun.conf" | cut -d ' ' -f 2 | sed -n "${CLIENT_NUMBER}"p)
	exp=$(grep -E "^### " "/usr/local/shadowsocksr/akun.conf" | cut -d ' ' -f 3 | sed -n "${CLIENT_NUMBER}"p)

	# remove [Peer] block matching $CLIENT_NAME
	sed -i "/^### $CLIENT_NAME/d" "/usr/local/shadowsocksr/akun.conf"
cd /usr/local/shadowsocksr
match_del=$(python mujson_mgr.py -d -u "${user}"|grep -w "delete user")
cd
service cron restart
/etc/init.d/ssrmu restart
clear
echo " Shadowsocks-R Account Deleted Successfully"
echo " =========================="
echo " Client Name : $user"
echo " Expired On  : $exp"
echo " =========================="
}

del-ss () {
NUMBER_OF_CLIENTS=$(grep -c -E "^### " "/etc/shadowsocks-libev/akun.conf")
	if [[ ${NUMBER_OF_CLIENTS} == '0' ]]; then
		clear
		echo ""
		echo "You have no existing clients!"
		exit 1
	fi

	clear
	echo ""
	echo " Select the existing client you want to remove"
	echo " Press CTRL+C to return"
	echo " ==============================="
	echo "     No  Expired   User"
	grep -E "^### " "/etc/shadowsocks-libev/akun.conf" | cut -d ' ' -f 2-3 | nl -s ') '
	until [[ ${CLIENT_NUMBER} -ge 1 && ${CLIENT_NUMBER} -le ${NUMBER_OF_CLIENTS} ]]; do
		if [[ ${CLIENT_NUMBER} == '1' ]]; then
			read -rp "Pilih salah satu[1]: " CLIENT_NUMBER
		else
			read -rp "Pilih salah satu [1-${NUMBER_OF_CLIENTS}]: " CLIENT_NUMBER
		fi
	done
	# match the selected number to a client name
	CLIENT_NAME=$(grep -E "^### " "/etc/shadowsocks-libev/akun.conf" | cut -d ' ' -f 2-3 | sed -n "${CLIENT_NUMBER}"p)
	user=$(grep -E "^### " "/etc/shadowsocks-libev/akun.conf" | cut -d ' ' -f 2 | sed -n "${CLIENT_NUMBER}"p)
	exp=$(grep -E "^### " "/etc/shadowsocks-libev/akun.conf" | cut -d ' ' -f 3 | sed -n "${CLIENT_NUMBER}"p)

	# remove [Peer] block matching $CLIENT_NAME
	sed -i "/^### $user $exp/,/^port_http/d" "/etc/shadowsocks-libev/akun.conf"
	# remove generated client file
service cron restart
systemctl disable shadowsocks-libev-server@$user-tls.service
	systemctl disable shadowsocks-libev-server@$user-http.service
	systemctl stop shadowsocks-libev-server@$user-tls.service
	systemctl stop shadowsocks-libev-server@$user-http.service
	rm -f "/etc/shadowsocks-libev/$user-tls.json"
	rm -f "/etc/shadowsocks-libev/$user-http.json"
clear
echo " SS OBFS Account Deleted Successfully"
echo " =========================="
echo " Client Name : $user"
echo " Expired On  : $exp"
echo " =========================="
}

renew-ssr () {
NUMBER_OF_CLIENTS=$(grep -c -E "^### " "/usr/local/shadowsocksr/akun.conf")
	if [[ ${NUMBER_OF_CLIENTS} == '0' ]]; then
		clear
		echo ""
		echo "You have no existing clients!"
		exit 1
	fi

	clear
	echo ""
	echo "Select the existing client you want to renew"
	echo " Press CTRL+C to return"
	echo -e "==============================="
	grep -E "^### " "/usr/local/shadowsocksr/akun.conf" | cut -d ' ' -f 2-3 | nl -s ') '
	until [[ ${CLIENT_NUMBER} -ge 1 && ${CLIENT_NUMBER} -le ${NUMBER_OF_CLIENTS} ]]; do
		if [[ ${CLIENT_NUMBER} == '1' ]]; then
			read -rp "Select one client [1]: " CLIENT_NUMBER
		else
			read -rp "Select one client [1-${NUMBER_OF_CLIENTS}]: " CLIENT_NUMBER
		fi
	done
read -p "Expired (days): " masaaktif
user=$(grep -E "^### " "/usr/local/shadowsocksr/akun.conf" | cut -d ' ' -f 2 | sed -n "${CLIENT_NUMBER}"p)
exp=$(grep -E "^### " "/usr/local/shadowsocksr/akun.conf" | cut -d ' ' -f 3 | sed -n "${CLIENT_NUMBER}"p)
now=$(date +%Y-%m-%d)
d1=$(date -d "$exp" +%s)
d2=$(date -d "$now" +%s)
exp2=$(( (d1 - d2) / 86400 ))
exp3=$(($exp2 + $masaaktif))
exp4=`date -d "$exp3 days" +"%Y-%m-%d"`
tgl=$(echo "$exp4" | cut -d- -f3)
bln=$(echo "$exp4" | cut -d- -f2)
sed -i "s/### $user $exp/### $user $exp4/g" /usr/local/shadowsocksr/akun.conf
clear
echo ""
echo " Shadowsocks-R Account Has Been Successfully Renewed"
echo " =========================="
echo " Client Name : $user"
echo " Expired On  : $exp4"
echo " =========================="
}

renew-ss () {
NUMBER_OF_CLIENTS=$(grep -c -E "^### " "/etc/shadowsocks-libev/akun.conf")
	if [[ ${NUMBER_OF_CLIENTS} == '0' ]]; then
		clear
		echo ""
		echo "You have no existing clients!"
		exit 1
	fi

	clear
	echo ""
	echo "Select the existing client you want to renew"
	echo " Press CTRL+C to return"
	echo -e "==============================="
	grep -E "^### " "/etc/shadowsocks-libev/akun.conf" | cut -d ' ' -f 2-3 | nl -s ') '
	until [[ ${CLIENT_NUMBER} -ge 1 && ${CLIENT_NUMBER} -le ${NUMBER_OF_CLIENTS} ]]; do
		if [[ ${CLIENT_NUMBER} == '1' ]]; then
			read -rp "Select one client [1]: " CLIENT_NUMBER
		else
			read -rp "Select one client [1-${NUMBER_OF_CLIENTS}]: " CLIENT_NUMBER
		fi
	done
read -p "Expired (days): " masaaktif
user=$(grep -E "^### " "/etc/shadowsocks-libev/akun.conf" | cut -d ' ' -f 2 | sed -n "${CLIENT_NUMBER}"p)
exp=$(grep -E "^### " "/etc/shadowsocks-libev/akun.conf" | cut -d ' ' -f 3 | sed -n "${CLIENT_NUMBER}"p)
now=$(date +%Y-%m-%d)
d1=$(date -d "$exp" +%s)
d2=$(date -d "$now" +%s)
exp2=$(( (d1 - d2) / 86400 ))
exp3=$(($exp2 + $masaaktif))
exp4=`date -d "$exp3 days" +"%Y-%m-%d"`
sed -i "s/### $user $exp/### $user $exp4/g" /etc/shadowsocks-libev/akun.conf
clear
echo ""
echo " SS OBFS Account Has Been Successfully Renewed"
echo " =========================="
echo " Client Name : $user"
echo " Expired On  : $exp4"
echo " =========================="
}

clear
echo -e "\033[0;34m------------------------------------\033[0m"
echo -e "\E[44;1;39m            SSR & SS MENU           \E[0m"
echo -e "\033[0;34m------------------------------------\033[0m"
echo ""
echo -e " [\e[36m 01 \e[0m] Create SSR Account"
echo -e " [\e[36m 02 \e[0m] Create Shadowsocks Account"
echo -e " [\e[36m 03 \e[0m] Deleting SSR Account"
echo -e " [\e[36m 04 \e[0m] Delete Shadowsocks Account"
echo -e " [\e[36m 05 \e[0m] Renew SSR Account Active"
echo -e " [\e[36m 06 \e[0m] Renew Shadowsocks Account"
echo -e " [\e[36m 07 \e[0m] Check User Login Shadowsocks"
echo -e " [\e[36m 08 \e[0m] Show Other SSR Menu"
echo ""
echo -e "Press x or [ Ctrl+C ]   To-Exit"
echo -e ""
echo -e "\033[0;34m------------------------------------\033[0m"
echo -e "Client Name    : $Name"
echo -e "Expiry On      : $scexpireddate"
echo -e "Countdown Days : $sisa_hari Days Left"
echo -e "Script Type    : $sc $scv"
echo -e "\033[0;34m------------------------------------\033[0m"
echo ""
read -p " Select menu : " opt
echo -e ""
case $opt in
1)
    clear
    add-ssr
    ;;
2)
    clear
    add-ss
    ;;
3)
    clear
    del-ssr
    ;;
4)
    clear
    del-ss
    ;;
5)
    clear
    renew-ssr
    ;;
6)
    clear
    renew-ss
    ;;
7)
    clear
    cek-ss
    ;;
8)
    clear
    ssrmu
    ;;
x)  clear
    menu
    ;;
*)
    echo -e ""
    echo "Please enter an correct number"
    sleep 1
    m-ssr
    ;;
esac