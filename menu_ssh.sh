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

user-limit() {
# Program untuk membatasi jumlah login user dropbear
PARAM=$1

echo "Semua user dropbear yang login lebih dari $1 akan di kill"
echo -n > /tmp/pid2
ps ax|grep dropbear > /tmp/pid
cat /tmp/pid | grep -i 'dropbear -p' > /tmp/pids
cat /var/log/secure |  grep -i "Password auth succeeded" > /tmp/sks
perl -pi -e 's/Password auth succeeded for//g' /tmp/sks
perl -pi -e 's/dropbear//g' /tmp/sks

cat /tmp/pid | while read line;do
set -- $line
p=$1
var=`cat /tmp/sks | grep -i $1`
set -- $var
l=$6
if [ "$6" != '' ]
then
echo "$p $l" | cat - /tmp/pid2 > /tmp/temp && mv /tmp/temp /tmp/pid2
fi
 done

case $PARAM in

1)
echo -n > /tmp/user1
cat /tmp/pid2 | while read line;do
set -- $line
p=$1
u=$2
cat /tmp/user1 | grep -i $u > /dev/null
if [ $? = 1 ];then
echo $line >> /tmp/user1
else
kill $p
echo "kill $p user $u" 
fi
done
rm -f /tmp/pid
rm -f /tmp/pid2
rm -f /tmp/pids
rm -f /tmp/sks
rm -f /tmp/user1
exit 0
;;
2)
echo -n > /tmp/user1
echo -n > /tmp/user2
cat /tmp/pid2 | while read line;do
set -- $line
p=$1
u=$2
cat /tmp/user1 | grep -i $u > /dev/null
if [ $? = 1 ];then
echo $line >> /tmp/user1
else
cat /tmp/user2 | grep -i $u > /dev/null
if [ $? = 1 ];then
echo $line >> /tmp/user2
else
kill $p
echo "kill $p user $u"
fi
fi
done
rm -f /tmp/pid
rm -f /tmp/pid2
rm -f /tmp/pids
rm -f /tmp/sks
rm -f /tmp/user1
rm -f /tmp/user2
exit 0
;;
*)
  echo " gunakan perintah userlimit 1 untuk limit 1 login saja"
  echo " atau userlimit 2  untuk melimit max 2 login"   
rm -f /tmp/pid
rm -f /tmp/pid2
rm -f /tmp/pids
rm -f /tmp/sks
exit 1
;;
esac
}

autokill-menu() {
Green_font_prefix="\033[32m" && Red_font_prefix="\033[31m" && Green_background_prefix="\033[42;37m" && Red_background_prefix="\033[41;37m" && Font_color_suffix="\033[0m"
Info="${Green_font_prefix}[ON]${Font_color_suffix}"
Error="${Red_font_prefix}[OFF]${Font_color_suffix}"
cek=$(grep -c -E "^# Autokill" /etc/cron.d/tendang)
if [[ "$cek" = "1" ]]; then
sts="${Info}"
else
sts="${Error}"
fi
clear
echo -e "\033[0;34m-------------------------------\033[0m"
echo -e "\E[44;1;39m           AUTOKILL SSH        \E[0m"
echo -e "\033[0;34m-------------------------------\033[0m"
echo -e "Status Autokill : $sts        "
echo -e ""
echo -e "[1]  AutoKill After 5 Minutes"
echo -e "[2]  AutoKill After 10 Minutes"
echo -e "[3]  AutoKill After 15 Minutes"
echo -e "[4]  Turn Off AutoKill/MultiLogin"
echo ""
echo -e "\033[0;34m------------------------------------\033[0m"
echo -e ""
read -p "Select From Options [1-4 or x] :  " AutoKill
if [ -z $AutoKill ]; then
autokill-menu
fi
read -p "Multilogin Maximum Number Of Allowed: " max
echo -e ""
case $AutoKill in
                1)
                echo -e ""
                sleep 1
                clear
                echo > /etc/cron.d/tendang
                echo "# Autokill" >/etc/cron.d/tendang
                echo "*/5 * * * *  root /usr/bin/tendang $max" >>/etc/cron.d/tendang
                echo -e ""
                echo -e "\033[0;34m------------------------------------\033[0m"
                echo -e ""
                echo -e "      Allowed MultiLogin : $max"
                echo -e "      AutoKill Every     : 5 Minutes"      
                echo -e ""
                echo -e "\033[0;34m------------------------------------\033[0m"                                                                                                                                 
                service cron restart >/dev/null 2>&1
                service cron reload >/dev/null 2>&1                                                                  
                ;;
                2)
                echo -e ""
                sleep 1
                clear
                echo > /etc/cron.d/tendang
                echo "# Autokill" >/etc/cron.d/tendang
                echo "*/10 * * * *  root /usr/bin/tendang $max" >>/etc/cron.d/tendang
                echo -e ""
                echo -e "\033[0;34m------------------------------------\033[0m"
                echo -e ""
                echo -e "      Allowed MultiLogin : $max"
                echo -e "      AutoKill Every     : 10 Minutes"
                echo -e ""
                echo -e "\033[0;34m------------------------------------\033[0m"
                service cron restart >/dev/null 2>&1
                service cron reload >/dev/null 2>&1
                ;;
                3)
                echo -e ""
                sleep 1
                clear
                echo > /etc/cron.d/tendang
                echo "# Autokill" >/etc/cron.d/tendang
                echo "*/15 * * * *  root /usr/bin/tendang $max" >>/etc/cron.d/tendang
                echo -e ""
                echo -e "\033[0;34m------------------------------------\033[0m"
                echo -e ""
                echo -e "      Allowed MultiLogin : $max"
                echo -e "      AutoKill Every     : 15 Minutes"
                echo -e ""
                echo -e "\033[0;34m------------------------------------\033[0m"
                service cron restart >/dev/null 2>&1
                service cron reload >/dev/null 2>&1
                ;;
                4)
                clear
                rm /etc/cron.d/tendang
                echo -e ""
                echo -e "\033[0;34m------------------------------------\033[0m"
                echo -e ""
                echo -e "      AutoKill MultiLogin Turned Off  "
                echo -e ""
                echo -e "\033[0;34m------------------------------------\033[0m"
                service cron restart >/dev/null 2>&1
                service cron reload >/dev/null 2>&1
                ;;
                x)
                clear
                autokill-menu
                ;;
        esac
read -n 1 -s -r -p "Press any key to back on menu"
menu
}

trial_ssh() {
clear
domain=$(cat /etc/xray/domain)
portsshws=`cat ~/log-install.txt | grep -w "SSH Websocket" | cut -d: -f2 | awk '{print $1}'`
wsssl=`cat /root/log-install.txt | grep -w "SSH SSL Websocket" | cut -d: -f2 | awk '{print $1}'`
clear
IP=$(curl -sS ifconfig.me);
ossl=`cat /root/log-install.txt | grep -w "OpenVPN" | cut -f2 -d: | awk '{print $6}'`
opensh=`cat /root/log-install.txt | grep -w "OpenSSH" | cut -f2 -d: | awk '{print $1}'`
db=`cat /root/log-install.txt | grep -w "Dropbear" | cut -f2 -d: | awk '{print $1,$2}'`
ssl="$(cat ~/log-install.txt | grep -w "Stunnel4" | cut -d: -f2)"
sqd="$(cat ~/log-install.txt | grep -w "Squid" | cut -d: -f2)"
OHP=`cat /root/log-install.txt | grep -w "OHP" | cut -d: -f2 | awk '{print $1}'`
ovpn="$(netstat -nlpt | grep -i openvpn | grep -i 0.0.0.0 | awk '{print $4}' | cut -d: -f2)"
ovpn2="$(netstat -nlpu | grep -i openvpn | grep -i 0.0.0.0 | awk '{print $4}' | cut -d: -f2)"
OhpSSH=`cat /root/log-install.txt | grep -w "OHP SSH" | cut -d: -f2 | awk '{print $1}'`
OhpDB=`cat /root/log-install.txt | grep -w "OHP DBear" | cut -d: -f2 | awk '{print $1}'`
OhpOVPN=`cat /root/log-install.txt | grep -w "OHP OpenVPN" | cut -d: -f2 | awk '{print $1}'`
Login=trial`</dev/urandom tr -dc X-Z0-9 | head -c4`
hari="1"
Pass=1
echo Ping Host
echo Create Akun: $Login
sleep 0.5
echo Setting Password: $Pass
sleep 0.5
clear
useradd -e `date -d "$masaaktif days" +"%Y-%m-%d"` -s /bin/false -M $Login
hariini=`date +%d-%m-%Y`
expp="$(chage -l $Login | grep "Account expires" | awk -F": " '{print $2}')"
exp=`date -d "$expp" "+%d-%m-%Y"`
echo -e "$Pass\n$Pass\n"|passwd $Login &> /dev/null
echo -e "\033[0;34m------------------------------------\033[0m"
echo -e "\E[44;1;39m        TRIAL SSH USER ACCOUNT      \E[0m"
echo -e "\033[0;34m------------------------------------\033[0m"
echo -e "Username     : $Login"
echo -e "Password     : $Pass"
echo -e "Created date : ${hariini}"
echo -e "Expired On   : $exp"
echo -e "IP           : $IP"
echo -e "Host         : $domain"
echo -e "\033[0;34m------------------------------------\033[0m"
echo -e "OpenSSH      : $opensh"
echo -e "Dropbear     : $db"
echo -e "SSH-WS       : $portsshws"
echo -e "SSH-SSL-WS   : $wsssl"
echo -e "SSL/TLS      :$ssl"
echo -e "Port Squid   :$sqd"
echo -e "OHP SSH      : $OHP"
echo -e "UDPGW        : 7100-7300"
echo -e "\033[0;34m------------------------------------\033[0m"
echo -e "Config OVPN"
echo -e "OpenVPN      : TCP $ovpn http://$IP:81/client-tcp-$ovpn.ovpn"
echo -e "OpenVPN      : UDP $ovpn2 http://$IP:81/client-udp-$ovpn2.ovpn"
echo -e "OpenVPN      : SSL $ssl http://$IP:81/client-tcp-ssl.ovpn"
echo -e "OHPVPN       : OHP $OHP http://$IP:81/tcp-ohp.ovpn"
echo -e "\033[0;34m------------------------------------\033[0m"
echo -e "Login SSH"
echo -e "domain:port@user:password"
echo -e ' ``` '
echo -e "sshws.$domain:$portsshws@$Login:$Pass"
echo -e ' ``` '
echo -e "Payload WS NTLS"
echo -e ""
echo -e ' ``` '
echo -e "GET / HTTP/1.1[crlf]Host: sshws.$domain[crlf]Upgrade: websocket[crlf][crlf]"
echo -e ' ``` '
echo -e "\033[0;34m------------------------------------\033[0m"
echo -e "Login SSH"
echo -e "domain:port@user:password"
echo -e ' ``` '
echo -e "sshws.$domain:$wsssl@$Login:$Pass"
echo -e ' ``` '
echo -e "Payload WS TLS"
echo -e ' ``` '
echo -e "GET wss://$sni/ HTTP/1.1[crlf]Host: sshws.$domain[crlf]Upgrade: websocket[crlf]Connection: Keep-Alive[crlf][crlf]"
echo -e ' ``` '
echo -e "\033[0;34m------------------------------------\033[0m"
echo -e "Remote Proxy"
echo -e ' ``` '
echo -e "bug.com:$wsssl"
echo -e ' ``` '
echo -e "\033[0;34m------------------------------------\033[0m"
echo ""
read -n 1 -s -r -p "Press any key to back on menu"
menu_ssh
}

add_ssh() {
clear
domain=$(cat /etc/xray/domain)
portsshws=`cat ~/log-install.txt | grep -w "SSH Websocket" | cut -d: -f2 | awk '{print $1}'`
wsssl=`cat /root/log-install.txt | grep -w "SSH SSL Websocket" | cut -d: -f2 | awk '{print $1}'`
clear
IP=$(curl -sS ifconfig.me);
ossl=`cat /root/log-install.txt | grep -w "OpenVPN" | cut -f2 -d: | awk '{print $6}'`
opensh=`cat /root/log-install.txt | grep -w "OpenSSH" | cut -f2 -d: | awk '{print $1}'`
db=`cat /root/log-install.txt | grep -w "Dropbear" | cut -f2 -d: | awk '{print $1,$2}'`
ssl="$(cat ~/log-install.txt | grep -w "Stunnel4" | cut -d: -f2)"
sqd="$(cat ~/log-install.txt | grep -w "Squid" | cut -d: -f2)"
OHP=`cat /root/log-install.txt | grep -w "OHP" | cut -d: -f2 | awk '{print $1}'`
ovpn="$(netstat -nlpt | grep -i openvpn | grep -i 0.0.0.0 | awk '{print $4}' | cut -d: -f2)"
ovpn2="$(netstat -nlpu | grep -i openvpn | grep -i 0.0.0.0 | awk '{print $4}' | cut -d: -f2)"
OhpSSH=`cat /root/log-install.txt | grep -w "OHP SSH" | cut -d: -f2 | awk '{print $1}'`
OhpDB=`cat /root/log-install.txt | grep -w "OHP DBear" | cut -d: -f2 | awk '{print $1}'`
OhpOVPN=`cat /root/log-install.txt | grep -w "OHP OpenVPN" | cut -d: -f2 | awk '{print $1}'`
clear
echo -e "\033[0;34m------------------------------------\033[0m"
echo -e "\E[44;1;39m              ADD SSH USER          \E[0m"
echo -e "\033[0;34m------------------------------------\033[0m"
read -p "Username : " Login
read -p "Password : " Pass
read -p "Expired (hari): " masaaktif
useradd -e `date -d "$masaaktif days" +"%Y-%m-%d"` -s /bin/false -M $Login
hariini=`date +%d-%m-%Y`
expp="$(chage -l $Login | grep "Account expires" | awk -F": " '{print $2}')"
exp=`date -d "$expp" "+%d-%m-%Y"`
echo -e "$Pass\n$Pass\n"|passwd $Login &> /dev/null
clear
echo -e "\033[0;34m------------------------------------\033[0m"
echo -e "\E[44;1;39m            SSH USER ACCOUNT        \E[0m"
echo -e "\033[0;34m------------------------------------\033[0m"
echo -e "Username     : $Login"
echo -e "Password     : $Pass"
echo -e "Created date : ${hariini}"
echo -e "Expired On   : $exp"
echo -e "IP           : $IP"
echo -e "Host         : $domain"
echo -e "\033[0;34m------------------------------------\033[0m"
echo -e "OpenSSH      : $opensh"
echo -e "Dropbear     : $db"
echo -e "SSH-WS       : $portsshws"
echo -e "SSH-SSL-WS   : $wsssl"
echo -e "SSL/TLS      :$ssl"
echo -e "Port Squid   :$sqd"
echo -e "OHP SSH      : $OHP"
echo -e "UDPGW        : 7100-7300"
echo -e "\033[0;34m------------------------------------\033[0m"
echo -e "Config OVPN"
echo -e "OpenVPN      : TCP $ovpn http://$IP:81/client-tcp-$ovpn.ovpn"
echo -e "OpenVPN      : UDP $ovpn2 http://$IP:81/client-udp-$ovpn2.ovpn"
echo -e "OpenVPN      : SSL $ssl http://$IP:81/client-tcp-ssl.ovpn"
echo -e "OHPVPN       : OHP $OHP http://$IP:81/tcp-ohp.ovpn"
echo -e "\033[0;34m------------------------------------\033[0m"
echo -e "Login SSH"
echo -e "domain:port@user:password"
echo -e ' ``` '
echo -e "sshws.$domain:$portsshws@$Login:$Pass"
echo -e ' ``` '
echo -e "Payload WS NTLS"
echo -e ""
echo -e ' ``` '
echo -e "GET / HTTP/1.1[crlf]Host: sshws.$domain[crlf]Upgrade: websocket[crlf][crlf]"
echo -e ' ``` '
echo -e "\033[0;34m------------------------------------\033[0m"
echo -e "Login SSH"
echo -e "domain:port@user:password"
echo -e ' ``` '
echo -e "sshws.$domain:$wsssl@$Login:$Pass"
echo -e ' ``` '
echo -e "Payload WS TLS"
echo -e ' ``` '
echo -e "GET wss://$sni/ HTTP/1.1[crlf]Host: sshws.$domain[crlf]Upgrade: websocket[crlf]Connection: Keep-Alive[crlf][crlf]"
echo -e ' ``` '
echo -e "\033[0;34m------------------------------------\033[0m"
echo -e "Remote Proxy"
echo -e ' ``` '
echo -e "bug.com:$wsssl"
echo -e ' ``` '
echo -e "\033[0;34m------------------------------------\033[0m"
echo ""
read -n 1 -s -r -p "Press any key to back on menu"
menu_ssh
}

cek_ssh() {
clear
echo " "
echo " "
if [ -e "/var/log/auth.log" ]; then
        LOG="/var/log/auth.log";
fi
if [ -e "/var/log/secure" ]; then
        LOG="/var/log/secure";
fi            
data=( `ps aux | grep -i dropbear | awk '{print $2}'`);
echo -e "\033[0;34m------------------------------------\033[0m"
echo -e "\E[44;1;39m         Dropbear User Login        \E[0m"
echo -e "\033[0;34m------------------------------------\033[0m"
echo "ID  |  Username  |  IP Address";
echo -e "\033[0;34m------------------------------------\033[0m"
cat $LOG | grep -i dropbear | grep -i "Password auth succeeded" > /tmp/login-db.txt;
for PID in "${data[@]}"
do
        cat /tmp/login-db.txt | grep "dropbear\[$PID\]" > /tmp/login-db-pid.txt;
        NUM=`cat /tmp/login-db-pid.txt | wc -l`;
        USER=`cat /tmp/login-db-pid.txt | awk '{print $10}'`;
        IP=`cat /tmp/login-db-pid.txt | awk '{print $12}'`;
        if [ $NUM -eq 1 ]; then
        echo "$PID - $USER - $IP";
        fi
done
echo -e "\033[0;34m------------------------------------\033[0m"
echo -e "\E[44;1;39m          OpenSSH User Login        \E[0m"
echo -e "\033[0;34m------------------------------------\033[0m"
echo "ID  |  Username  |  IP Address";
echo -e "\033[0;34m------------------------------------\033[0m"
cat $LOG | grep -i sshd | grep -i "Accepted password for" > /tmp/login-db.txt
data=( `ps aux | grep "\[priv\]" | sort -k 72 | awk '{print $2}'`);
for PID in "${data[@]}"
do
        cat /tmp/login-db.txt | grep "sshd\[$PID\]" > /tmp/login-db-pid.txt;
        NUM=`cat /tmp/login-db-pid.txt | wc -l`;
        USER=`cat /tmp/login-db-pid.txt | awk '{print $9}'`;
        IP=`cat /tmp/login-db-pid.txt | awk '{print $11}'`;
        if [ $NUM -eq 1 ]; then
        echo "$PID - $USER - $IP";
        fi
echo -e "\033[0;34m------------------------------------\033[0m"
done
if [ -f "/etc/openvpn/server/openvpn-tcp.log" ]; then
	echo -e "\033[0;34m------------------------------------\033[0m"
	echo -e "\E[44;1;39m        OpenVPN TCP User Login      \E[0m"
	echo -e "\033[0;34m------------------------------------\033[0m"
        echo "Username  |  IP Address  |  Connected Since";
        echo -e "\033[0;34m------------------------------------\033[0m"
        cat /etc/openvpn/server/openvpn-tcp.log | grep -w "^CLIENT_LIST" | cut -d ',' -f 2,3,8 | sed -e 's/,/      /g' > /tmp/vpn-login-tcp.txt
        cat /tmp/vpn-login-tcp.txt
fi
if [ -f "/etc/openvpn/server/openvpn-udp.log" ]; then
	echo -e "\033[0;34m------------------------------------\033[0m"
	echo -e "\E[44;1;39m        OpenVPN UDP User Login      \E[0m"
	echo -e "\033[0;34m------------------------------------\033[0m"
        echo "Username  |  IP Address  |  Connected Since";
        echo -e "\033[0;34m------------------------------------\033[0m"
        cat /etc/openvpn/server/openvpn-udp.log | grep -w "^CLIENT_LIST" | cut -d ',' -f 2,3,8 | sed -e 's/,/      /g' > /tmp/vpn-login-udp.txt
        cat /tmp/vpn-login-udp.txt
fi
echo -e "\033[0;34m------------------------------------\033[0m"
echo "";
rm -f /tmp/login-db-pid.txt
rm -f /tmp/login-db.txt
rm -f /tmp/vpn-login-tcp.txt
rm -f /tmp/vpn-login-udp.txt
read -n 1 -s -r -p "Press any key to back on menu"
menu_ssh
}

del-ssh() {
AKUN="$(echo $expired | cut -d: -f1)"
ID="$(echo $expired | grep -v nobody | cut -d: -f3)"
exp="$(chage -l $AKUN | grep "Account expires" | awk -F": " '{print $2}')"
status="$(passwd -S $AKUN | awk '{print $2}' )"
clear
echo -e "\033[0;34m-------------------------------\033[0m"
echo -e "\E[44;1;39m            DELETE USER        \E[0m"
echo -e "\033[0;34m-------------------------------\033[0m" 
while read expired
do
AKUN="$(echo $expired | cut -d: -f1)"
ID="$(echo $expired | grep -v nobody | cut -d: -f3)"
exp="$(chage -l $AKUN | grep "Account expires" | awk -F": " '{print $2}')"
status="$(passwd -S $AKUN | awk '{print $2}' )"
if [[ $ID -ge 1000 ]]; then
if [[ "$status" = "L" ]]; then
printf "%-17s %2s %-17s %2s \n" "$AKUN" "$exp     "
else
printf "%-17s %2s %-17s %2s \n" "$AKUN" "$exp     "
fi
fi
done < /etc/passwd
JUMLAH="$(awk -F: '$3 >= 1000 && $1 != "nobody" {print $1}' /etc/passwd | wc -l)"
echo -e "\033[0;34m-------------------------------\033[0m" 
echo -e "Please Input Username "
read -p "Username SSH to Delete : " Pengguna
if getent passwd $Pengguna > /dev/null 2>&1; then
        userdel $Pengguna > /dev/null 2>&1
        echo -e "User $Pengguna was removed."
else
        echo -e "Failure: User $Pengguna Not Exist."
fi
read -n 1 -s -r -p "Press any key to back on menu"
menu
}

hapus_ssh() {
clear
               hariini=`date +%d-%m-%Y`
	       echo -e "\033[0;34m-------------------------------\033[0m"
	       echo -e "\E[44;1;39m            AUTO DELETE        \E[0m"
	       echo -e "\033[0;34m-------------------------------\033[0m"
               echo "Thank you for removing the EXPIRED USERS"
               echo -e "\033[0;34m------------------------------------\033[0m"  
               cat /etc/shadow | cut -d: -f1,8 | sed /:$/d > /tmp/expirelist.txt
               totalaccounts=`cat /tmp/expirelist.txt | wc -l`
               for((i=1; i<=$totalaccounts; i++ ))
               do
               tuserval=`head -n $i /tmp/expirelist.txt | tail -n 1`
               username=`echo $tuserval | cut -f1 -d:`
               userexp=`echo $tuserval | cut -f2 -d:`
               userexpireinseconds=$(( $userexp * 86400 ))
               tglexp=`date -d @$userexpireinseconds`             
               tgl=`echo $tglexp |awk -F" " '{print $3}'`
               while [ ${#tgl} -lt 2 ]
               do
               tgl="0"$tgl
               done
               while [ ${#username} -lt 15 ]
               do
               username=$username" " 
               done
               bulantahun=`echo $tglexp |awk -F" " '{print $2,$6}'`
               echo "echo "Expired- User : $username Expire at : $tgl $bulantahun"" >> /usr/local/bin/alluser
               todaystime=`date +%s`
               if [ $userexpireinseconds -ge $todaystime ] ;
               then
		    	:
               else
               echo "echo "Expired- Username : $username are expired at: $tgl $bulantahun and removed : $hariini "" >> /usr/local/bin/deleteduser
	           echo "Username $username that are expired at $tgl $bulantahun removed from the VPS $hariini"
               userdel $username
               fi
               done
               echo " "
               echo -e "\033[0;34m------------------------------------\033[0m"  
               
               read -n 1 -s -r -p "Press any key to back on menu"
               menu_ssh
}

member() {
clear
echo -e "\033[0;34m---------------------------------------------------\033[0m"
echo -e "\E[44;1;39m                     LIST MEMBER SSH               \E[0m"
echo -e "\033[0;34m---------------------------------------------------\033[0m"
echo "USERNAME          EXP DATE          STATUS"
echo -e "\033[0;34m---------------------------------------------------\033[0m"
while read expired
do
AKUN="$(echo $expired | cut -d: -f1)"
ID="$(echo $expired | grep -v nobody | cut -d: -f3)"
exp="$(chage -l $AKUN | grep "Account expires" | awk -F": " '{print $2}')"
status="$(passwd -S $AKUN | awk '{print $2}' )"
if [[ $ID -ge 1000 ]]; then
if [[ "$status" = "L" ]]; then
printf "%-17s %2s %-17s %2s \n" "$AKUN" "$exp     " "LOCKED"
else
printf "%-17s %2s %-17s %2s \n" "$AKUN" "$exp     " "UNLOCKED"
fi
fi
done < /etc/passwd
JUMLAH="$(awk -F: '$3 >= 1000 && $1 != "nobody" {print $1}' /etc/passwd | wc -l)"
echo -e "\033[0;34m---------------------------------------------------\033[0m"
echo "Account number: $JUMLAH user"
echo -e "\033[0;34m---------------------------------------------------\033[0m"
read -n 1 -s -r -p "Press any key to back on menu"
menu_ssh
}

renew_ssh() {
AKUN="$(echo $expired | cut -d: -f1)"
ID="$(echo $expired | grep -v nobody | cut -d: -f3)"
exp="$(chage -l $AKUN | grep "Account expires" | awk -F": " '{print $2}')"
status="$(passwd -S $AKUN | awk '{print $2}' )"
clear
echo -e "\033[0;34m-------------------------------\033[0m"
echo -e "\E[44;1;39m            RENEW  USER        \E[0m"
echo -e "\033[0;34m-------------------------------\033[0m"  
while read expired
do
AKUN="$(echo $expired | cut -d: -f1)"
ID="$(echo $expired | grep -v nobody | cut -d: -f3)"
exp="$(chage -l $AKUN | grep "Account expires" | awk -F": " '{print $2}')"
status="$(passwd -S $AKUN | awk '{print $2}' )"
if [[ $ID -ge 1000 ]]; then
if [[ "$status" = "L" ]]; then
printf "%-17s %2s %-17s %2s \n" "$AKUN" "$exp     "
else
printf "%-17s %2s %-17s %2s \n" "$AKUN" "$exp     "
fi
fi
done < /etc/passwd
JUMLAH="$(awk -F: '$3 >= 1000 && $1 != "nobody" {print $1}' /etc/passwd | wc -l)"
echo -e "\033[0;34m-------------------------------\033[0m" 
echo -e "Please Input Username "
read -p "Username : " User
egrep "^$User" /etc/passwd >/dev/null
if [ $? -eq 0 ]; then
read -p "Day Extend : " Days
Today=`date +%s`
Days_Detailed=$(( $Days * 86400 ))
Expire_On=$(($Today + $Days_Detailed))
Expiration=$(date -u --date="1970-01-01 $Expire_On sec GMT" +%Y/%m/%d)
Expiration_Display1=$(date -u --date="1970-01-01 $Expire_On sec GMT" '+%d %b %Y')
Expiration_Display=`date -d "$Expiration_Display1" "+%d-%m-%Y"`
passwd -u $User
usermod -e  $Expiration $User
egrep "^$User" /etc/passwd >/dev/null
echo -e "$Pass\n$Pass\n"|passwd $User &> /dev/null
clear
echo -e "\033[0;34m-------------------------------\033[0m"
echo -e "\E[44;1;39m         RENEW SSH USER        \E[0m"
echo -e "\033[0;34m-------------------------------\033[0m"  
echo -e ""
echo -e " Username   : $User"
echo -e " Days Added : $Days Days"
echo -e " Expires on : $Expiration_Display"
echo -e ""
echo -e "\033[0;34m-------------------------------\033[0m" 
read -n 1 -s -r -p "Press any key to back on menu"
menu
else
clear
echo -e "\033[0;34m-------------------------------\033[0m"
echo -e "\E[44;1;39m            RENEW  USER        \E[0m"
echo -e "\033[0;34m-------------------------------\033[0m" 
echo -e ""
echo -e "   Username Doesnt Exist      "
echo -e ""
echo -e "\033[0;34m-------------------------------\033[0m" 
fi
read -n 1 -s -r -p "Press any key to back on menu"
menu_ssh
}

sshws() {
clear
portdb=`cat ~/log-install.txt | grep -w "Dropbear" | cut -d: -f2|sed 's/ //g' | cut -f2 -d","`
portsshws=`cat ~/log-install.txt | grep -w "SSH Websocket" | cut -d: -f2 | awk '{print $1}'`
if [ -f "/etc/systemd/system/sshws.service" ]; then
clear
else
wget -q -O /usr/bin/proxy3.js "http://${link}/${directory}/sshws/proxy3.js"
cat <<EOF> /etc/systemd/system/sshws.service
[Unit]
Description=WSenabler By VPN Legasi
Documentation=VPNLegasi

[Service]
Type=simple
ExecStart=/usr/bin/ssh-wsenabler
KillMode=process
Restart=on-failure
RestartSec=1s

[Install]
WantedBy=multi-user.target
EOF
fi

Green_font_prefix="\033[32m" && Red_font_prefix="\033[31m" && Green_background_prefix="\033[42;37m" && Red_background_prefix="\033[41;37m" && Font_color_suffix="\033[0m"
Info="${Green_font_prefix}[ON]${Font_color_suffix}"
Error="${Red_font_prefix}[OFF]${Font_color_suffix}"

function start() {
PID=`ps -ef |grep -v grep | grep sshws |awk '{print $2}'`
if [[ ! -z "${PID}" ]]; then
echo "Already ON !"
else
wget -q -O /usr/bin/ssh-wsenabler "http://${link}/${directory}/sshws/sshws-true.sh" && chmod +x /usr/bin/ssh-wsenabler && /usr/bin/ssh-wsenabler
systemctl daemon-reload >/dev/null 2>&1
systemctl enable sshws.service >/dev/null 2>&1
systemctl start sshws.service >/dev/null 2>&1
sed -i "/SSH Websocket/c\   - SSH Websocket           : $portsshws [ON]" /root/log-install.txt
echo -e "${green}SSH Websocket Started${NC}"
fi
read -n 1 -s -r -p "Press any key to back on menu"
menu
}

function stop() {
PID=`ps -ef |grep -v grep | grep sshws |awk '{print $2}'`
if [[ ! -z "${PID}" ]]; then
systemctl stop sshws.service
tmux kill-session -t sshws
sed -i "/SSH Websocket/c\   - SSH Websocket           : $portsshws [OFF]" /root/log-install.txt
echo -e "${red}SSH Websocket Stopped${NC}"
fi
read -n 1 -s -r -p "Press any key to back on menu"
menu
}

clear
echo -e "\033[0;34m-------------------------------\033[0m"
echo -e "\E[44;1;39m           SSH WEBSOCKET       \E[0m"
echo -e "\033[0;34m-------------------------------\033[0m"
echo ""
echo -e " 1. Enable SSH Websocket"
echo -e " 2. Disable SSh Websocket"
echo ""
echo -e "\033[0;34m-------------------------------\033[0m"
echo ""
read -rp "Input Number : " -e num
if [[ "$num" = "1" ]]; then
start
elif [[ "$num" = "2" ]]; then
stop
else
clear
read -n 1 -s -r -p "Press any key to back on menu"
sshws
fi
}

clear
echo -e "\033[0;34m------------------------------------\033[0m"
echo -e "\E[44;1;39m               SSH MENU             \E[0m"
echo -e "\033[0;34m------------------------------------\033[0m"
echo ""
echo -e " [\e[36m 01 \e[0m] Trial Ssh User"
echo -e " [\e[36m 02 \e[0m] Add Ssh User"
echo -e " [\e[36m 03 \e[0m] All Ssh User"
echo -e " [\e[36m 04 \e[0m] Delete Ssh"
echo -e " [\e[36m 05 \e[0m] Delete User Expired"
echo -e " [\e[36m 06 \e[0m] Extend Ssh"
echo -e " [\e[36m 07 \e[0m] Check User Login"
echo -e " [\e[36m 08 \e[0m] SSh WS Menu"
echo -e " [\e[36m 09 \e[0m] AutoKill Menu"
echo -e " [\e[36m 10 \e[0m] User Limit Login (Dropbear)"
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
    trial_ssh
    ;;
2)
    clear
    add_ssh
    ;;
3)
    clear
    member
    ;;
4)
    clear
    del-ssh
    ;;
5)
    clear
    hapus_ssh
    ;;
6)
    clear
    renew_ssh
    ;;
7)
    clear
    cek_ssh
    ;;
8)
    clear
    sshws
    ;;
9)
    clear
    autokill-menu
    ;;
10)
    clear
    user-limit
    ;;
x)  clear
    menu
    ;;
*)
    echo -e ""
    echo "Sila Pilih Semula"
    sleep 1
    menu_ssh
    ;;
esac
