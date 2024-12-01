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

menu_nf () {
nf() {
clear
UA_Browser="Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.87 Safari/537.36";
UA_Dalvik="Dalvik/2.1.0 (Linux; U; Android 9; ALP-AL00 Build/HUAWEIALP-AL00)";
DisneyAuth="grant_type=urn%3Aietf%3Aparams%3Aoauth%3Agrant-type%3Atoken-exchange&latitude=0&longitude=0&platform=browser&subject_token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJiNDAzMjU0NS0yYmE2LTRiZGMtOGFlOS04ZWI3YTY2NzBjMTIiLCJhdWQiOiJ1cm46YmFtdGVjaDpzZXJ2aWNlOnRva2VuIiwibmJmIjoxNjIyNjM3OTE2LCJpc3MiOiJ1cm46YmFtdGVjaDpzZXJ2aWNlOmRldmljZSIsImV4cCI6MjQ4NjYzNzkxNiwiaWF0IjoxNjIyNjM3OTE2LCJqdGkiOiI0ZDUzMTIxMS0zMDJmLTQyNDctOWQ0ZC1lNDQ3MTFmMzNlZjkifQ.g-QUcXNzMJ8DwC9JqZbbkYUSKkB1p4JGW77OON5IwNUcTGTNRLyVIiR8mO6HFyShovsR38HRQGVa51b15iAmXg&subject_token_type=urn%3Abamtech%3Aparams%3Aoauth%3Atoken-type%3Adevice"
DisneyHeader="authorization: Bearer ZGlzbmV5JmJyb3dzZXImMS4wLjA.Cu56AgSfBTDag5NiRA81oLHkDZfu5L3CKadnefEAY84"
Font_Black="\033[30m";
Font_Red="\033[31m";
Font_Green="\033[32m";
Font_Yellow="\033[33m";
Font_Blue="\033[34m";
Font_Purple="\033[35m";
Font_SkyBlue="\033[36m";
Font_White="\033[37m";
Font_Suffix="\033[0m";
tele="https://t.me/vpnlegasi"
echo -e "\033[0;34m------------------------------------\033[0m"
echo -e "\E[44;1;39m   CHECK DNS REGION BY VPN LEGASI   \E[0m"
echo -e "\033[0;34m------------------------------------\033[0m"
echo ""
echo -e "${Font_Blue}SCRIPT EDIT MOD BY VPN LEGASI"
echo -e "Streaming Unlock Content Checker By VPN Legasi" 
echo -e "Contact     : ${tele} / @vpnlegasi"
echo -e "system time : $(date)"
echo -e "Message     : Keputusan ujian adalah untuk rujukan sahaja,"
echo -e "              sila rujuk penggunaan sebenar${Font_Suffix}"

export LANG="en_US";
export LANGUAGE="en_US";

function InstallJQ() {
    #Install JQ
    if [ -e "/etc/redhat-release" ];then
        echo -e "${Font_Green} is installing dependencies: epel-release${Font_Suffix}"
        yum install epel-release -y -q > /dev/null;
        echo -e "${Font_Green} is installing dependencies: jq${Font_Suffix}";
        yum install jq -y -q > /dev/null;
        elif [[ $(cat /etc/os-release | grep '^ID=') =~ ubuntu ]] || [[ $(cat /etc/os-release | grep '^ID=') =~ debian ]];then
        echo -e "${Font_Green} is updating package list...${Font_Suffix}";
        apt-get update -y > /dev/null;
        echo -e "${Font_Green} is installing dependencies: jq${Font_Suffix}";
        apt-get install jq -y > /dev/null;
        elif [[ $(cat /etc/issue | grep '^ID=') =~ alpine ]];then
        apk update > /dev/null;
        echo -e "${Font_Green} is installing dependencies: jq${Font_Suffix}";
        apk add jq > /dev/null;
    else
        echo -e "${Font_Red}Please manually install jq${Font_Suffix}";
        exit;
    fi
}

function PharseJSON() {
    # Usage: PharseJSON "Original JSON text to parse" "Key value to parse"
    # Example: PharseJSON ""Value":"123456"" "Value" [Return result: 123456]
    echo -n $1 | jq -r .$2;
}

function GameTest_Steam(){
    echo -n -e " Steam Currency : \c";
    local result=`curl --user-agent "${UA_Browser}" -${1} -fsSL --max-time 30 https://store.steampowered.com/app/761830 2>&1 | grep priceCurrency | cut -d '"' -f4`;
    
    if [ ! -n "$result" ]; then
        echo -n -e "\r Steam Currency : ${Font_Red}Failed (Network Connection)${Font_Suffix}\n" 
        echo -n -e ""
    else
        echo -n -e "\r Steam Currency : ${Font_Green}${result}${Font_Suffix}\n" 
        echo -n -e ""
    fi
}


function MediaUnlockTest_Netflix() {
    echo -n -e " Netflix        :\c";
    local result=`curl -${1} --user-agent "${UA_Browser}" -sSL "https://www.netflix.com/" 2>&1`;
    if [ "$result" == "Not Available" ];then
        echo -n -e "\r Netflix Access : ${Font_Red}Unsupport${Font_Suffix}\n"
        echo -n -e "\r Info           : ${Font_Purple}PM @vpnlegasi for rent DNS Unlock Netflix SG + MY${Font_Suffix}\n"
        return;
    fi
    
    if [[ "$result" == "curl"* ]];then
        echo -n -e "\r Netflix Access : ${Font_Red}No : Failed (Network Connection) ${Font_Suffix}\n"
        echo -n -e "\r Info           : ${Font_Purple}PM @vpnlegasi for rent DNS Unlock Netflix SG + MY${Font_Suffix}\n"
        return;
    fi
    
    local result=`curl -${1} --user-agent "${UA_Browser}" -sL "https://www.netflix.com/title/80018499" 2>&1`;
    if [[ "$result" == *"page-404"* ]] || [[ "$result" == *"NSEZ-403"* ]];then
        echo -n -e "\r Netflix Access : ${Font_Red}No${Font_Suffix}\n"
        echo -n -e "\r Info           : ${Font_Purple}PM @vpnlegasi for rent DNS Unlock Netflix SG + MY${Font_Suffix}\n"
        return;
    fi
    
    local result1=`curl -${1} --user-agent "${UA_Browser}" -sL "https://www.netflix.com/title/70143836" 2>&1`;
    local result2=`curl -${1} --user-agent "${UA_Browser}" -sL "https://www.netflix.com/title/80027042" 2>&1`;
    local result3=`curl -${1} --user-agent "${UA_Browser}" -sL "https://www.netflix.com/title/70140425" 2>&1`;
    local result4=`curl -${1} --user-agent "${UA_Browser}" -sL "https://www.netflix.com/title/70283261" 2>&1`;
    local result5=`curl -${1} --user-agent "${UA_Browser}"-sL "https://www.netflix.com/title/70143860" 2>&1`;
    local result6=`curl -${1} --user-agent "${UA_Browser}" -sL "https://www.netflix.com/title/70202589" 2>&1`;

    if [[ "$result1" == *"page-404"* ]] && [[ "$result2" == *"page-404"* ]] && [[ "$result3" == *"page-404"* ]] && [[ "$result4" == *"page-404"* ]] && [[ "$result5" == *"page-404"* ]] && [[ "$result6" == *"page-404"* ]];then
        echo -n -e "\r Netflix Access : ${Font_Green}Yes${Font_Suffix}\n"
        echo -n -e "\r Netflix Type   : ${Font_Yellow}Only Homemade : Limited Movie :) ${Font_Suffix}\n"
        echo -n -e "\r Info           : ${Font_Purple}PM @vpnlegasi for rent DNS Unlock Netflix SG + MY${Font_Suffix}\n"
        return;
    fi
    
    local region=`tr [:lower:] [:upper:] <<< $(curl -${1} --user-agent "${UA_Browser}" -fs --write-out %{redirect_url} --output /dev/null "https://www.netflix.com/title/80018499" | cut -d '/' -f4 | cut -d '-' -f1)` ;
    
    if [[ ! -n "$region" ]];then
        region="US";
    fi
        echo -n -e "\r Netflix Access : ${Font_Green}Yes${Font_Suffix}\n"
        echo -n -e "\r Netflix Type   : ${Font_SkyBlue}Full (Region: ${region}) : Enjoy Your Movie :) ${Font_Suffix}\n" 
    return;
}    


function MediaUnlockTest_HotStar() {
    echo -n -e " Hotstar Region :\c";
    local result=$(curl $useNIC $xForward --user-agent "${UA_Browser}" -${1} ${ssll} -fsL --write-out %{http_code} --output /dev/null --max-time 10 "https://api.hotstar.com/o/v1/page/1557?offset=0&size=20&tao=0&tas=20")
    if [ "$result" = "000" ]; then
        echo -n -e "\r HotStar        : ${Font_Red}Failed (Network Connection)${Font_Suffix}\n"
        return
    elif [ "$result" = "401" ]; then
        local region=$(curl $useNIC $xForward --user-agent "${UA_Browser}" -${1} ${ssll} -sI "https://www.hotstar.com" | grep 'geo=' | sed 's/.*geo=//' | cut -f1 -d",")
        local site_region=$(curl $useNIC $xForward -${1} ${ssll} -s -o /dev/null -L --max-time 10 -w '%{url_effective}\n' "https://www.hotstar.com" | sed 's@.*com/@@' | tr [:lower:] [:upper:])
        if [ -n "$region" ] && [ "$region" = "$site_region" ]; then
            echo -n -e "\r HotStar Region : ${Font_SkyBlue}Full (Region: ${region}) : Enjoy Your Movie :) ${Font_Suffix}\n"
            return
        else
            eecho -n -e "\r Hotstar Region : ${Font_Red}No${Font_Suffix}\n"
            return
        fi
    elif [ "$result" = "475" ]; then
        echo -n -e "\r Hotstar Region : ${Font_Red}No${Font_Suffix}\n"
        return
    else
        echo -n -e "\r Hotstar Region : ${Font_Red}Failed${Font_Suffix}\n"
    fi

}

function MediaUnlockTest_iQiyi(){
    echo -n -e " iQiyi Region   :\c";
    local tmpresult=$(curl -${1} -s -I "https://www.iq.com/" 2>&1);
    if [[ "$tmpresult" == "curl"* ]];then
        	echo -n -e "\r iQiyi Region   : ${Font_Red}Failed (Network Connection)${Font_Suffix}\n"
        	return;
    fi
    
    local result=$(echo "${tmpresult}" | grep 'mod=' | awk '{print $2}' | cut -f2 -d'=' | cut -f1 -d';');
    if [ -n "$result" ]; then
		if [[ "$result" == "ntw" ]]; then
			echo -n -e "\r iQiyi Region   : ${Font_Green}Yes(Region: TW)${Font_Suffix}\n"
			return;
		else
			region=$(echo ${result} | tr 'a-z' 'A-Z') 
			echo -n -e "\r iQiyi Region   : ${Font_SkyBlue}Full (Region: ${region}) : Enjoy Your Movie :) ${Font_Suffix}\n"
			return;
		fi	
    else
		echo -n -e "\r iQiyi Region   : ${Font_Red}Failed${Font_Suffix}\n"
		return;
	fi	
}

function MediaUnlockTest_Viu_com() {
    echo -n -e " Viu.com        :\c";
    local tmpresult=$(curl -${1} -s -o /dev/null -L --max-time 30 -w '%{url_effective}\n' "https://www.viu.com/" 2>&1);
	if [[ "${tmpresult}" == "curl"* ]];then
        echo -n -e "\r Viu.com        : ${Font_Red}Failed (Network Connection)${Font_Suffix}\n"
        return;
    fi
	
	local result=$(echo ${tmpresult} | cut -f5 -d"/")
	if [ -n "${result}" ]; then
		if [[ "${result}" == "no-service" ]]; then
			echo -n -e "\r Viu.com Region : ${Font_Red}No${Font_Suffix}\n"
			return;
		else
			region=$(echo ${result} | tr 'a-z' 'A-Z')
			echo -n -e "\r Viu.com Region : ${Font_SkyBlue}Full (Region: ${region}) : Enjoy Your Movie :) ${Font_Suffix}\n"
			return;
		fi
    else
		echo -n -e "\r Viu.com Region : ${Font_Red}Failed (Network Connection)${Font_Suffix}\n"
		return;
	fi
}


function MediaUnlockTest_YouTube_Region() {
    echo -n -e " YouTube Region : ->\c";
    local result=`curl --user-agent "${UA_Browser}" -${1} -sSL "https://www.youtube.com/" 2>&1`;
    
    if [[ "$result" == "curl"* ]];then
        echo -n -e "\r YouTube Region : ${Font_Red}Failed (Network Connection)${Font_Suffix}\n"
        echo -n -e ""
        return;
    fi
    
    local result=`curl --user-agent "${UA_Browser}" -${1} -sL "https://www.youtube.com/red" | sed 's/,/\n/g' | grep "countryCode" | cut -d '"' -f4`;
    if [ -n "$result" ]; then
        echo -n -e "\r YouTube Region : ${Font_Green}${result}${Font_Suffix}\n" 
        return;
    fi
    
    echo -n -e "\r YouTube Region : ${Font_Red}No${Font_Suffix}\n"
    return;
}

function MediaUnlockTest_DisneyPlus() {
    echo -n -e " DisneyPlus     : \c";
    local result=`curl -${1} --user-agent "${UA_Browser}" -sSL "https://global.edge.bamgrid.com/token" 2>&1`;
    
    if [[ "$result" == "curl"* ]];then
        echo -n -e "\r DisneyPlus     : ${Font_Red}Failed (Network Connection)${Font_Suffix}\n" 
        return;
    fi
    
    local previewcheck=`curl -sSL -o /dev/null -L --max-time 30 -w '%{url_effective}\n' "https://disneyplus.com" 2>&1`;
    if [[ "${previewcheck}" == "curl"* ]];then
        echo -n -e "\r DisneyPlus     : ${Font_Red}Failed (Network Connection)${Font_Suffix}\n" 
        return;
    fi
    
    if [[ "${previewcheck}" == *"preview"* ]];then
        echo -n -e "\r DisneyPlus     : ${Font_Red}No${Font_Suffix}\n" 
        return;
    fi
    
    local result=`curl -${1} --user-agent "${UA_Browser}" -fs --write-out '%{redirect_url}\n' --output /dev/null "https://www.disneyplus.com" 2>&1`;
    if [[ "${website}" == "https://disneyplus.disney.co.jp/" ]];then
        echo -n -e "\r DisneyPlus     : ${Font_Green}Yes(Region: JP)${Font_Suffix}\n"
        return;
    fi
    
    local result=`curl -${1} -sSL --user-agent "$UA_Browser" -H "Content-Type: application/x-www-form-urlencoded" -H "${DisneyHeader}" -d "${DisneyAuth}" -X POST  "https://global.edge.bamgrid.com/token" 2>&1`;
    PharseJSON "${result}" "access_token" 2>&1 > /dev/null;
    if [[ "$?" -eq 0 ]]; then
        local region=$(curl -${1} -sSL https://www.disneyplus.com | grep 'region: ' | awk '{print $2}')
        if [ -n "$region" ];then
            echo -n -e "\r DisneyPlus     : ${Font_Green}Yes(Region: $region)${Font_Suffix}\n"
            return;
        fi
        echo -n -e "\r DisneyPlus     : ${Font_Green}Yes${Font_Suffix}\n" 
        return;
    fi
        echo -n -e "\r DisneyPlus     : ${Font_Red}No${Font_Suffix}\n" 
}

function ISP(){
    local result=`curl -sSL -${1} "https://api.ip.sb/geoip" 2>&1`;
    if [[ "$result" == "curl"* ]];then
        return
    fi
    local ip=$(wget -qO- ipinfo.io/ip);
    local isp=$(curl -s ipinfo.io/org | cut -d " " -f 2-10 )
    if [ $? -eq 0 ];then
        echo " ** Your IP     : ${ip}"
        echo " ** Your ISP    : ${isp}"
    fi
}

function MediaUnlockTest() {
    ISP ${1};
    MediaUnlockTest_Netflix ${1};
    MediaUnlockTest_YouTube_Region ${1};
    MediaUnlockTest_DisneyPlus ${1};
    MediaUnlockTest_HotStar ${1};
    MediaUnlockTest_Viu_com ${1};
    MediaUnlockTest_iQiyi ${1};
    GameTest_Steam ${1};
}

curl -V > /dev/null 2>&1;
if [ $? -ne 0 ];then
    echo -e "${Font_Red}Please install curl${Font_Suffix}";
    exit;
fi

jq -V > /dev/null 2>&1;
if [ $? -ne 0 ];then
    InstallJQ;
fi
echo " ** Testing IPv4 unlocking"
check4=`ping 1.1.1.1 -c 1 2>&1`;
if [[ "$check4" != *"unreachable"* ]] && [[ "$check4" != *"Unreachable"* ]];then
    MediaUnlockTest 4;
else
    echo -e "${Font_SkyBlue}The current host does not support IPv4, skip...${Font_Suffix}"
fi
    echo -n -e " "
echo -e "\033[0;34m------------------------------------\033[0m"
echo -e "\E[44;1;39m   CHECK DNS REGION BY VPN LEGASI   \E[0m"
echo -e "\033[0;34m------------------------------------\033[0m"
    read -n 1 -s -r -p "Press any key to back on menu"
    menu
}


dns() {
clear
echo -e "\033[0;34m-------------------------------\033[0m"
echo -e "\E[44;1;39m    ADD DNS SERVER VPN LEGASI  \E[0m"
echo -e "\033[0;34m-------------------------------\033[0m"
if ! command -v resolvconf >/dev/null; then
    echo "Installing resolvconf"
    apt install resolvconf -y >/dev/null
fi
sleep 1
echo "AUTO SCRIPT BY VPN LEGASI"
echo "TELEGRAM : https://t.me/vpnlegasi / @vpnlegasi "
echo "PLEASE INPUT THE OPTION NUMBER CORRECTLY"
echo "   1 : INPUT DNS TEMPORARY.REBOOT VPS FOR RETURN TO INITIAL DNS"
echo "   2 : INPUT DNS PERMANENTLY"
read -p "OPTION NUMBER :" option
if [ $option = "1" ]; then
sudo systemctl enable resolvconf.service > /dev/null && clear -x && sudo systemctl start resolvconf.service > /dev/null
clear -x
echo " "
read -p "KEY IN IP DNS: " ip1

echo "nameserver $ip1" > /etc/resolv.conf && systemctl start resolvconf.service
fi

if [ $option = "2" ]; then
sudo systemctl enable resolvconf.service > /dev/null && clear -x && sudo systemctl start resolvconf.service > /dev/null
clear -x
echo " "
read -p "KEY IN IP DNS: " ip2
sudo dd if=/dev/null of=/etc/resolvconf/resolv.conf.d/head
echo "nameserver $ip2" | sudo tee /etc/resolvconf/resolv.conf.d/head
clear -x
sudo systemctl restart resolvconf.service > /dev/null 
clear -x
sudo resolvconf --enable-updates > /dev/null 
clear -x
sudo resolvconf -u > /dev/null 
clear -x
fi
echo -e "\033[0;34m-------------------------------\033[0m"
echo -e "\E[44;1;39m         NEW DNS SERVER        \E[0m"
echo -e "\033[0;34m-------------------------------\033[0m"
cat /etc/resolv.conf
echo -e "\033[0;34m-------------------------------\033[0m"
read -n 1 -s -r -p "Press any key to back on menu"
menu
}


clear
echo -e "\033[0;34m------------------------------------\033[0m"
echo -e "\E[44;1;39mADD DNS & NETFLIX CHECKER VPN LEGASI\E[0m"
echo -e "\033[0;34m------------------------------------\033[0m"
echo ""
echo -e " [\e[36m 01 \e[0m] Check Netflix Region"
echo -e " [\e[36m 02 \e[0m] Add DNS Nameserver"
echo ""
echo -e "Press [ Ctrl+C ] To-Exit or x back to menu"
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
    nf
    ;;
2)
    clear
    dns
    ;;  
x)  clear
    menu
    ;;
*)
    echo -e ""
    echo "Sila Pilih Semula"
    sleep 1
    menu_nf
    ;;
esac
}

backupmenu() {
clear
setbot() {
clear
rm -rf /etc/.maA* > /dev/null 2>&1
rm -rf /etc/token_bott > /dev/null 2>&1
rm -rf /etc/admin_id > /dev/null 2>&1
rm -rf botautobckp > /dev/null 2>&1
rm -rf /usr/bin/botautobckp > /dev/null 2>&1
cd /usr/bin
wget -O botautobckp "${host}/script/${sc}/botautobckp.sh" && chmod +x botautobckp
cd
clear
firtsTimeRun() {

    [[ ! -f /usr/bin/jq ]] && {
        wget -q --no-check-certificate "https://github.com/stedolan/jq/releases/download/jq-1.6/jq-linux64" -O /usr/bin/jq
        chmod +x usr/bin/jq
    }
    [[ ! -d /etc/.maAsiss ]] && mkdir -p /etc/.maAsiss
    [[ ! -f /etc/.maAsiss/.botku ]] && {
        wget -qO- ${host}/script/${sc}/BotAPI.sh >/etc/.maAsiss/.botku
    }
    [[ ! -f /etc/.maAsiss/backup.conf ]] && {
        echo -ne "Input your Bot TOKEN : "
        read bot_tkn
        echo "Token: $bot_tkn" > /etc/.maAsiss/backup.conf
        echo "Token: $bot_tkn" > /etc/token_bott
        echo -ne "Input your Admin ID : "
        read adm_ids
        echo "AdminID: $adm_ids" >> /etc/.maAsiss/backup.conf
        echo "AdminID: $adm_ids" >> /etc/admin_id
    }
}
firtsTimeRun
backup_bot
fun_bot1() {
			[[ "$(grep -wc "vpnlegasibot" "/etc/rc.local")" = '0' ]] && {
			    sed -i '$ i\screen -dmS vpnlegasibot backup_bot' /etc/rc.local >/dev/null 2>&1
			}
        }
        screen -dmS vpnlegasibot backup_bot >/dev/null 2>&1
        fun_bot1
        [[ $(ps x | grep "vpnlegasibot" | grep -v grep | wc -l) != '0' ]] && echo -e "\nBot successfully activated !" || echo -e "\nError1! Information not valid !"
        sleep 2
        menu
        } || {
       clear
        echo -e "Info...\n"
        fun_bot2() {
            screen -r -S "vpnlegasibot" -X quit >/dev/null 2>&1
            [[ $(grep -wc "vpnlegasibot" /etc/rc.local) != '0' ]] && {
                sed -i '/vpnlegasibot/d' /etc/rc.local
            }
            rm -f /etc/.maAsiss/backup.conf
            sleep 1
        }
        fun_bot2
        echo -e "\nBot Reseller Stopped!"
        sleep 2
        menu
clear
rm -rf /etc/.maA*
rm -rf setbot.sh
backupmenu       
}

backup_bot() {
clear
IP=$MYIP
date=$(date +"%Y-%m-%d")
token=$(cat /etc/token_bott | awk '{print $2}')
admin=$(cat /etc/admin_id | awk '{print $2}')
Name=$(curl -sS http://www.vpnlegasi.xyz/ipaccess/ip-multiport-v2 | grep $MYIP | awk '{print $4}')
clear
if [[ -z $token ]]; then
echo -e "[ ${green}INFO${NC} ] Please Setbot FIRST!!!"
sleep 3
clear
backupmenu
fi

echo -e "[ ${green}INFO${NC} ] Create password for database"
read -rp "Enter password : " -e InputPass
sleep 1
if [[ -z $InputPass ]]; then
backup_bot
fi
rm -rf /root/backup
mkdir -p /root/backup
cp /etc/passwd backup/
cp /etc/group backup/
cp /etc/shadow backup/
cp /etc/gshadow backup/
cp -r /etc/wireguard backup/wireguard
cp /etc/shadowsocks-libev/akun.conf backup/ss.conf
cp -r /var/lib/premium-script/ backup/premium-script
cp -r /usr/local/etc/xray backup/xray
cp -r /usr/local/shadowsocksr/ backup/shadowsocksr
cp -r /home/vps/public_html backup/public_html
rm /root/backup/public_html/*.ovpn
cd /root
zip -rP $InputPass $IP-$Name-$date.zip backup >/dev/null 2>&1
curl --request POST \
  --url https://api.telegram.org/bot$token/sendDocument?chat_id=$admin \
  --header 'content-type: multipart/form-data' \
  --form document=@/root/$IP-$Name-$date.zip \
  --form 'caption=Here Is Your Backup Files'
clear
rm -rf backup >/dev/null 2>&1
rm -f /root/$IP-$Name-$date.zip >/dev/null 2>&1
backupmenu
}

restore() {
echo -e "\033[0;34m------------------------------------\033[0m"
echo -e "\E[44;1;39m            RESTORE DATA VPS        \E[0m"
echo -e "\033[0;34m------------------------------------\033[0m"
echo -e "Default password autobackup : 123"
echo -e ""
read -p "Link : " url
read -p "Pass : " InputPass
if [[ -z $InputPass ]]; then
InputPass=123
fi 
mkdir /root/backup
wget -O backup.zip "$url" &>/dev/null
echo -e "[ ${green}INFO${NC} ]   Getting your data..."
unzip -P $InputPass backup.zip &>/dev/null
echo -e "[ ${green}INFO${NC} ]   Starting to restore data..."
rm -f backup.zip &>/dev/null
sleep 1
cd /root/backup
echo -e "[ ${green}INFO${NC} ]   Restoring passwd data..."
sleep 1
cp passwd /etc/ &>/dev/null
echo -e "[ ${green}INFO${NC} ]   Restoring group data..."
sleep 1
cp group /etc/ &>/dev/null
echo -e "[ ${green}INFO${NC} ]   Restoring shadow data..."
sleep 1
cp shadow /etc/ &>/dev/null
echo -e "[ ${green}INFO${NC} ]   Restoring gshadow data..."
sleep 1
cp gshadow /etc/ &>/dev/null
echo -e "[ ${green}INFO${NC} ]   Restoring Wireguard data..."
sleep 1
cp -r wireguard /etc/ &>/dev/null
echo -e "[ ${green}INFO${NC} ]   Restoring Xray data..."
sleep 1
cp -r xray /usr/local/etc/  &>/dev/null
echo -e "[ ${green}INFO${NC} ]   Restoring SSR User data..."
sleep 1
cp -r shadowsocksr /usr/local/ &>/dev/null
cp ss.conf /etc/shadowsocks-libev/ss.conf &>/dev/null
echo -e "[ ${green}INFO${NC} ]   Restoring Vps Info..."
sleep 1
cp -r premium-script /var/lib/ &>/dev/null
cp -r public_html /home/vps/ &>/dev/null
cd
rm -rf /root/backup &>/dev/null
echo -e "[ ${green}INFO${NC} ]   Done..."
sleep 1
rm -rf /root/backup
rm -f backup.zip
sleep 3
clear
echo -e "\033[0;34m------------------------------------\033[0m"
echo -e "\E[44;1;39m       SUCCESSFULLY RESTORE VPS     \E[0m"
echo -e "\033[0;34m------------------------------------\033[0m"
echo -e "PLEASE WAIT FOR RESTART SERVICE"
echo -e ""
/etc/init.d/ssh restart
/etc/init.d/dropbear restart
/etc/init.d/stunnel4 restart
/etc/init.d/openvpn restart
/etc/init.d/fail2ban restart
/etc/init.d/cron restart
/etc/init.d/nginx restart
/etc/init.d/squid restart
systemctl restart xray
systemctl restart xray@none
systemctl restart xray@trojan
systemctl restart xray@vmess
systemctl restart xray@shadowsocks
if [[ ! -z $(which dnsmasq) ]] && [[ -e /etc/dnsmasq ]]; then
systemctl restart dnsmasq
else
echo -e ""
fi
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7300 --max-clients 1000
echo""
echo -e " PLEASE WAIT WE CHECK RUNNING SERVICE AFTER RESTORE"
sleep 3
echo -e "\033[0;34m------------------------------------\033[0m"
running
echo -e "PLEASE INFORM IF FOUND ANY ERROR AFTER RESTORE"
echo -e "\033[0;34m-------------------------------\033[0m"
read -n 1 -s -r -p "Press any key to back on menu"
menu
}

clear
cek=$(grep -c -E "^# BOTBEGIN_Backupp" /etc/crontab)
if [[ "$cek" = "1" ]]; then
sts="On"
else
sts="Off"
fi
start() {
clear
sed -i "/^# BOTBEGIN_Backupp/,/^# BOTEND_Backupp/d" /etc/crontab
sed -i "/Auto Backup Status/c\   - Auto Backup Status      : [ON]" /root/log-install.txt
cat << EOF >> /etc/crontab
# BOTBEGIN_Backupp
5 0 * * * root /usr/bin/botautobckp
# BOTEND_Backupp
EOF
service cron restart
echo " Please Wait"
sleep 1
clear
echo " Autobackup Has Been Started"
echo " Data Will Be Backed Up Automatically at 00:05"
backupmenu
}
function stop() {
sed -i "/^# BOTBEGIN_Backupp/,/^# BOTEND_Backupp/d" /etc/crontab
sed -i "/Auto Backup Status/c\   - Auto Backup Status      : [OFF]" /root/log-install.txt
service cron restart
sleep 1
echo " Please Wait"
clear
echo " Autobackup Has Been Stopped"
backupmenu
}

clear
echo -e "\033[0;34m------------------------------------\033[0m"
echo -e "\E[44;1;39m            BACKUP DATA MENU        \E[0m"
echo -e "\033[0;34m------------------------------------\033[0m"
echo -e " Status AutoBackup : $sts"
echo ""
echo -e " [\e[36m 01 \e[0m] Setup Bot Backup Data"
echo -e " [\e[36m 02 \e[0m] Start Bot Autobackup"
echo -e " [\e[36m 03 \e[0m] Stop Bot Autobackup"
echo -e " [\e[36m 04 \e[0m] Backup Data VPS"
echo -e " [\e[36m 05 \e[0m] Restore Data VPS"
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
    setbot
    ;;
2)
    clear
    start
    ;;
3)
    clear
    stop
    ;;
4)
    clear
    backup_bot
    ;;
5)
    clear
    restore
    ;;
x)  clear
    menu
    ;;
*)
    echo -e ""
    echo "Please enter an correct number"
    sleep 1
    backupmenu
    ;;
esac
}

update () {
clear
versi=$(curl -sS ${gitlink}/${sc}/main/versi/main | awk '{print $3}')
cvursion=$(cat /home/.ver | awk '{print $3}')
echo -e "\033[0;34m------------------------------------\033[0m"
echo -e "\E[44;1;39m              UPDATE SCRIPT         \E[0m"
echo -e "\033[0;34m------------------------------------\033[0m"
 if [ $versi = $cvursion ]; then
	echo "Script Up To Date"
	read -n 1 -s -r -p "Press any key go to menu"
	menu
 else
	echo "Your Script use old Version"
	echo "Do you Wish to Update?"
	read -p "Please Input the Answer y/n  : " ans
		if [[ $ans = [yY] ]]; then
			wget ${host}/script/${sc}/update-sc.sh && chmod +x update-sc.sh && ./update-sc.sh
			rm -f /root/update-sc.sh
			rm -rf /home/.ver
                        serverV=$(curl -sS ${gitlink}/${sc}/main/versi/main | awk '{print $3}')
                        echo $serverV > /home/.ver
		fi
	sleep 1
clear
echo -e "\033[0;34m------------------------------------\033[0m"
echo -e "\E[44;1;39m         UPDATE SCRIPT SELESAI      \E[0m"
echo -e "\033[0;34m------------------------------------\033[0m"
read -n 1 -s -r -p "Press any key go to menu"
menu
fi
}

rest_art() {
echo -e "\033[0;34m------------------------------------\033[0m"
echo -e "\E[44;1;39m        RESTART ALL SERVICE VPS     \E[0m"
echo -e "\033[0;34m------------------------------------\033[0m"
/etc/init.d/ssh restart
/etc/init.d/dropbear restart
/etc/init.d/stunnel4 restart
/etc/init.d/openvpn restart
/etc/init.d/fail2ban restart
/etc/init.d/cron restart
/etc/init.d/nginx restart
/etc/init.d/squid restart
systemctl restart xray
systemctl restart xray@none
systemctl restart xray@trojan
systemctl restart xray@vmess
systemctl restart xray@shadowsocks
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7300 --max-clients 1000
sleep 2
clear
running
echo -e "\E[44;1;39m  SERVICE SUCCESSFULLY RESTART \E[0m"
echo -e "\033[0;34m-------------------------------\033[0m"
read -n 1 -s -r -p "Press any key go to menu"
m-system
}

bw() {
clear
echo -e "\033[0;34m------------------------------------\033[0m"
echo -e "\E[44;1;39m          BANDWITH MONITOR          \E[0m"
echo -e "\033[0;34m------------------------------------\033[0m"
echo ""
echo -e " [\e[36m 01 \e[0m] Lihat Total Bandwith Tersisa"
echo -e " [\e[36m 02 \e[0m] Tabel Penggunaan Setiap 5 Menit"
echo -e " [\e[36m 03 \e[0m] Tabel Penggunaan Setiap Jam"
echo -e " [\e[36m 04 \e[0m] Tabel Penggunaan Setiap Hari"
echo -e " [\e[36m 05 \e[0m] Tabel Penggunaan Setiap Bulan"
echo -e " [\e[36m 06 \e[0m] Tabel Penggunaan Setiap Tahun"
echo -e " [\e[36m 07 \e[0m] Tabel Penggunaan Tertinggi"
echo -e " [\e[36m 08 \e[0m] Statistik Penggunaan Setiap Jam"
echo -e " [\e[36m 09 \e[0m] Lihat Penggunaan Aktif Saat Ini"
echo -e " [\e[36m 10 \e[0m] Lihat Trafik Penggunaan Aktif Saat Ini [5s]"
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
    echo -e "\033[0;34m------------------------------------\033[0m"
    echo -e "\E[44;1;39m    TOTAL BANDWITH SERVER TERSISA   \E[0m"
    echo -e "\033[0;34m------------------------------------\033[0m"
    vnstat
    echo -e "\033[0;34m------------------------------------\033[0m"
    echo ""
    read -n 1 -s -r -p "Press any key go to bw menu"
    bw
    ;;
2)
    clear
    echo -e "\033[0;34m------------------------------------\033[0m"
    echo -e "\E[44;1;39m PENGGUNAAN BANDWITH SETIAP 5 MENIT \E[0m"
    echo -e "\033[0;34m------------------------------------\033[0m"
    vnstat -5
    echo -e "\033[0;34m------------------------------------\033[0m"
    echo ""
    read -n 1 -s -r -p "Press any key go to bw menu"
    bw
    ;;
3)
    clear
    echo -e "\033[0;34m------------------------------------\033[0m"
    echo -e "\E[44;1;39m   PENGGUNAAN BANDWITH SETIAP JAM   \E[0m"
    echo -e "\033[0;34m------------------------------------\033[0m"
    vnstat -h
    echo -e "\033[0;34m------------------------------------\033[0m"
    echo ""
    read -n 1 -s -r -p "Press any key go to bw menu"
    bw
    ;;
4)
    clear
    echo -e "\033[0;34m------------------------------------\033[0m"
    echo -e "\E[44;1;39m   PENGGUNAAN BANDWITH SETIAP HARI  \E[0m"
    echo -e "\033[0;34m------------------------------------\033[0m"
    vnstat -d
    echo -e "\033[0;34m------------------------------------\033[0m"
    echo ""
    read -n 1 -s -r -p "Press any key go to bw menu"
    bw
    ;;
5)
    clear
    echo -e "\033[0;34m------------------------------------\033[0m"
    echo -e "\E[44;1;39m  PENGGUNAAN BANDWITH SETIAP BULAN  \E[0m"
    echo -e "\033[0;34m------------------------------------\033[0m"
    vnstat -m
    echo -e "\033[0;34m------------------------------------\033[0m"
    echo ""
    read -n 1 -s -r -p "Press any key go to bw menu"
    bw
    ;;
6)
    clear
    echo -e "\033[0;34m------------------------------------\033[0m"
    echo -e "\E[44;1;39m  PENGGUNAAN BANDWITH SETIAP TAHUN  \E[0m"
    echo -e "\033[0;34m------------------------------------\033[0m"
    vnstat -d
    echo -e "\033[0;34m------------------------------------\033[0m"
    echo ""
    read -n 1 -s -r -p "Press any key go to bw menu"
    bw
    ;;
7)
    clear
    echo -e "\033[0;34m------------------------------------\033[0m"
    echo -e "\E[44;1;39m    PENGGUNAAN BANDWITH TERTINGGI   \E[0m"
    echo -e "\033[0;34m------------------------------------\033[0m"
    vnstat -t
    echo -e "\033[0;34m------------------------------------\033[0m"
    echo ""
    read -n 1 -s -r -p "Press any key go to bw menu"
    bw
    ;;
8)
    clear
    echo -e "\033[0;34m------------------------------------\033[0m"
    echo -e "\E[44;1;39mGRAFIK BANDWITH TERPAKAI SETIAP JAM \E[0m"
    echo -e "\033[0;34m------------------------------------\033[0m"
    vnstat -hg
    echo -e "\033[0;34m------------------------------------\033[0m"
    echo ""
    read -n 1 -s -r -p "Press any key go to bw menu"
    bw
    ;;
9)
    clear
    echo -e "\033[0;34m------------------------------------\033[0m"
    echo -e "\E[44;1;39m  LIVE PENGGUNAAN BANDWITH SAAT INI \E[0m"
    echo -e "\033[0;34m------------------------------------\033[0m"
    vnstat -l
    echo -e "\033[0;34m------------------------------------\033[0m"
    echo ""
    read -n 1 -s -r -p "Press any key go to bw menu"
    bw
    ;;
10)
    clear
    echo -e "\033[0;34m------------------------------------\033[0m"
    echo -e "\E[44;1;39m   LIVE TRAFIK PENGGUNAAN BANDWITH  \E[0m"
    echo -e "\033[0;34m------------------------------------\033[0m"
    vnstat -tr
    echo -e "\033[0;34m------------------------------------\033[0m"
    echo ""
    read -n 1 -s -r -p "Press any key go to bw menu"
    bw
    ;;
x)  
    clear
    menu
    ;;
*)
    echo -e ""
    echo "Please enter an correct number"
    sleep 1
    bw
    ;;
esac
}

swap_kvm() {
dd if=/dev/zero of=/swapfile1 bs=1024 count=524288
dd if=/dev/zero of=/swapfile2 bs=1024 count=524288
mkswap /swapfile1
mkswap /swapfile2
chown root:root /swapfile1
chown root:root /swapfile2
chmod 0600 /swapfile1
chmod 0600 /swapfile2
swapon /swapfile1
swapon /swapfile2
sed -i '$ i\swapon /swapfile1' /etc/rc.local
sed -i '$ i\swapon /swapfile2' /etc/rc.local
sed -i '$ i\/swapfile1      swap swap   defaults    0 0' /etc/fstab
sed -i '$ i\/swapfile2      swap swap   defaults    0 0' /etc/fstab
m-system
}

panel_domain() {
add-host() {
clear
echo -e "\033[0;34m-------------------------------\033[0m"
echo -e "\E[44;1;39m        CHANGE DOMAIN VPS      \E[0m"
echo -e "\033[0;34m-------------------------------\033[0m"
echo ""
read -rp "Add New Domain / Host: " -e pp
echo ""
if [ -z $pp ]; then
echo -e "Nothing input for domain!"
sleep 3
add-host
menu
else
rm -rf /root/dom
echo $(cat /root/domain) >> /root/dom
rm -rf /var/lib/premium-script/ipvps.conf
rm -rf /root/domain
rm -rf /etc/v2ray/domain
sleep 2
echo "$pp" > /root/domain
echo "IP=$pp" > /var/lib/premium-script/ipvps.conf
echo -e "[ ${green}INFO${NC} ] Start " 
sleep 0.5
systemctl stop nginx
systemctl stop xray
systemctl stop xray@none
systemctl stop xray@vless
systemctl stop xray@vlessnone
systemctl stop xray@tcp
systemctl stop xray@trojan
systemctl stop xray@trojannone
systemctl stop xray@vmess
systemctl stop xray@vmessnone
sleep 2
Cek=$(lsof -i:80 | cut -d' ' -f1 | awk 'NR==2 {print $1}')
if [[ ! -z "$Cek" ]]; then
sleep 1
echo -e "[ ${red}WARNING${NC} ] Detected port 80 used by $Cek " 
sleep 1
systemctl stop $Cek
systemctl stop $Cek@none
echo -e "[ ${green}INFO${NC} ] Processing to stop $Cek " 
sleep 2
fi
echo -e "[ ${green}INFO${NC} ] Starting renew cert... " 
sleep 2
source /var/lib/premium-script/ipvps.conf
domain=$pp
/root/.acme.sh/acme.sh --issue -d $domain -d sshws.$domain --standalone -k ec-256 --listen-v6
~/.acme.sh/acme.sh --installcert -d $domain -d sshws.$domain --fullchainpath /etc/xray/xray.crt --keypath /etc/xray/xray.key --ecc

dom=$(cat /root/dom)
filename=(/usr/local/etc/xray/config.json)
if [[ $dom != "" && $pp != "" ]]; then
  sed -i "s/$dom/$pp/" $filename
fi
rm -rf /root/dom

#Restart Service
systemctl daemon-reload
systemctl restart nginx
systemctl restart xray
systemctl restart xray@none
systemctl restart xray@vless
systemctl restart xray@vlessnone
systemctl restart xray@tcp
systemctl restart xray@trojan
systemctl restart xray@trojannone
systemctl restart xray@vmess
systemctl restart xray@vmessnone
clear
echo -e "[ ${green}INFO${NC} ] All finished... " 
sleep 0.5
echo ""
echo "Domain Successfully Change"
echo "Domain Cert Successfully Update"
echo ""
read -n 1 -s -r -p "Press any key to back on menu"
m-system
fi
}

cert() {
clear
echo -e "\033[0;34m-------------------------------\033[0m"
echo -e "\E[44;1;39m         CERT DOMAIN VPS       \E[0m"
echo -e "\033[0;34m-------------------------------\033[0m"
source /var/lib/premium-script/ipvps.conf
domain=$(cat /root/domain)
echo -e "[ ${green}INFO${NC} ] Start " 
sleep 0.5
systemctl stop nginx
systemctl stop xray
systemctl stop xray@none
systemctl stop xray@vless
systemctl stop xray@vlessnone
systemctl stop xray@tcp
systemctl stop xray@trojan
systemctl stop xray@trojannone
systemctl stop xray@vmess
systemctl stop xray@vmessnone
sleep 2
Cek=$(lsof -i:80 | cut -d' ' -f1 | awk 'NR==2 {print $1}')
if [[ ! -z "$Cek" ]]; then
sleep 1
echo -e "[ ${red}WARNING${NC} ] Detected port 80 used by $Cek " 
sleep 1
systemctl stop $Cek
systemctl stop $Cek@none
echo -e "[ ${green}INFO${NC} ] Processing to stop $Cek " 
sleep 2
fi
echo -e "[ ${green}INFO${NC} ] Starting renew cert... " 
sleep 2

/root/.acme.sh/acme.sh --issue -d $domain -d sshws.$domain --standalone -k ec-256 --listen-v6
~/.acme.sh/acme.sh --installcert -d $domain -d sshws.$domain --fullchainpath /etc/xray/xray.crt --keypath /etc/xray/xray.key --ecc
systemctl daemon-reload
systemctl restart nginx
systemctl restart xray
systemctl restart xray@none
systemctl restart xray@vless
systemctl restart xray@vlessnone
systemctl restart xray@tcp
systemctl restart xray@trojan
systemctl restart xray@trojannone
systemctl restart xray@vmess
systemctl restart xray@vmessnone
clear
echo -e "[ ${green}INFO${NC} ] All finished... " 
sleep 0.5
echo ""
echo "Domain Successfully Change"
echo "Domain Cert Successfully Update"
echo ""
read -n 1 -s -r -p "Press any key to back on menu"
m-system
}
echo -e "\033[0;34m------------------------------------\033[0m"
echo -e "\E[44;1;39m           VPS DOMAIN MENU          \E[0m"
echo -e "\033[0;34m------------------------------------\033[0m"
echo ""
echo -e " [\e[36m 01 \e[0m] Change Domain VPS"
echo -e " [\e[36m 02 \e[0m] Renew Cert Domain VPS"
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
    add-host
    ;;
2)
    clear
    cert
    ;;
x)  clear
    menu
    ;;
*)
    echo -e ""
    echo "Please enter an correct number"
    sleep 1
    panel_domain
    ;;
esac
}

auto-reboot() {
if [ ! -e /usr/local/bin/reboot_otomatis ]; then
echo '#!/bin/bash' > /usr/local/bin/reboot_otomatis 
echo 'tanggal=$(date +"%m-%d-%Y")' >> /usr/local/bin/reboot_otomatis 
echo 'waktu=$(date +"%T")' >> /usr/local/bin/reboot_otomatis 
echo 'echo "Server successfully rebooted on the date of $tanggal hit $waktu." >> /root/log-reboot.txt' >> /usr/local/bin/reboot_otomatis 
echo '/sbin/shutdown -r now' >> /usr/local/bin/reboot_otomatis 
chmod +x /usr/local/bin/reboot_otomatis
fi

clear
echo -e "\033[0;34m------------------------------------\033[0m"
echo -e "\E[44;1;39m        System Auto Reboot Menu     \E[0m"
echo -e "\033[0;34m------------------------------------\033[0m"
echo ""
echo -e " [\e[36m 01 \e[0m] Set Auto-Reboot Setiap 1 Jam"
echo -e " [\e[36m 02 \e[0m] Set Auto-Reboot Setiap 6 Jam"
echo -e " [\e[36m 03 \e[0m] Set Auto-Reboot Setiap 12 Jam"
echo -e " [\e[36m 04 \e[0m] Set Auto-Reboot Setiap 1 Hari"
echo -e " [\e[36m 05 \e[0m] Set Auto-Reboot Setiap 1 Minggu"
echo -e " [\e[36m 06 \e[0m] Set Auto-Reboot Setiap 1 Bulan"
echo -e " [\e[36m 07 \e[0m] Matikan Auto-Reboot"
echo -e " [\e[36m 08 \e[0m] View reboot log"
echo -e " [\e[36m 09 \e[0m] Remove reboot log"
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
    echo "10 * * * * root /usr/local/bin/reboot_otomatis" > /etc/cron.d/reboot_otomatis
    echo "Auto-Reboot has been set every an hour."
    echo -e "\033[0;34m------------------------------------\033[0m"
    echo ""
    read -n 1 -s -r -p "Press any key to back on menu"
    m-system
    ;;
2)
    clear
    echo "10 */6 * * * root /usr/local/bin/reboot_otomatis" > /etc/cron.d/reboot_otomatis
    echo "Auto-Reboot has been successfully set every 6 hours."
    echo -e "\033[0;34m------------------------------------\033[0m"
    echo ""
    read -n 1 -s -r -p "Press any key to back on menu"
    m-system
    ;;
3)
    clear
    echo "10 */12 * * * root /usr/local/bin/reboot_otomatis" > /etc/cron.d/reboot_otomatis
    echo "Auto-Reboot has been successfully set every 12 hours."
    echo -e "\033[0;34m------------------------------------\033[0m"
    echo ""
    read -n 1 -s -r -p "Press any key to back on menu"
    m-system
    ;;
4)
    clear
    echo "10 0 * * * root /usr/local/bin/reboot_otomatis" > /etc/cron.d/reboot_otomatis
    echo "Auto-Reboot has been successfully set once a day."
    echo -e "\033[0;34m------------------------------------\033[0m"
    echo ""
    read -n 1 -s -r -p "Press any key to back on menu"
    m-system
    ;;
5)
    clear
    echo "10 0 */7 * * root /usr/local/bin/reboot_otomatis" > /etc/cron.d/reboot_otomatis
    echo "Auto-Reboot has been successfully set once a week."
    echo -e "\033[0;34m------------------------------------\033[0m"
    echo ""
    read -n 1 -s -r -p "Press any key to back on menu"
    m-system
    ;;
6)
    clear
    echo "10 0 1 * * root /usr/local/bin/reboot_otomatis" > /etc/cron.d/reboot_otomatis
    echo "Auto-Reboot has been successfully set once a month."
    echo -e "\033[0;34m------------------------------------\033[0m"
    echo ""
    read -n 1 -s -r -p "Press any key to back on menu"
    m-system
    ;;
7)
    clear
    rm -f /etc/cron.d/reboot_otomatis
    echo "Auto-Reboot successfully TURNED OFF."
    echo -e "\033[0;34m------------------------------------\033[0m"
    echo ""
    read -n 1 -s -r -p "Press any key to back on menu"
    auto-reboot
    ;;
8)
    clear
    if [ ! -e /root/log-reboot.txt ]; then
    echo "No reboot activity found"
    echo -e "\033[0;34m------------------------------------\033[0m"
    echo ""
    read -n 1 -s -r -p "Press any key to back on menu"
    m-system
    else 
    echo -e "\033[0;34m------------------------------------\033[0m"
    echo -e "\E[44;1;39m            LOG REBOOT VPS          \E[0m"
    echo -e "\033[0;34m------------------------------------\033[0m"
    cat /root/log-reboot.txt
    echo -e "\033[0;34m------------------------------------\033[0m"
    echo ""
    read -n 1 -s -r -p "Press any key to back on menu"
    auto-reboot
    fi
    ;;
9)
    clear
    echo "" > /root/log-reboot.txt
    echo "Auto Reboot Log successfully deleted!"
    echo -e "\033[0;34m------------------------------------\033[0m"
    read -n 1 -s -r -p "Press any key to back on menu"
    auto-reboot
    echo "Options Not Found In Menu"
    echo -e "\033[0;34m------------------------------------\033[0m"
    echo ""
    read -n 1 -s -r -p "Press any key to back on menu"
    auto-reboot
    ;;
10)
    clear
    echo "10 */6 * * * root /usr/local/bin/reboot_otomatis" > /etc/cron.d/reboot_otomatis
    echo "Auto-Reboot has been successfully set every 6 hours."
    echo -e "\033[0;34m------------------------------------\033[0m"
    echo ""
    read -n 1 -s -r -p "Press any key to back on menu"
    m-system
    ;;
x)
    clear
    menu
    ;;
*)
    echo -e ""
    echo "Please enter an correct number"
    sleep 1
    auto-reboot
    ;;
esac
}

clear
echo -e "\033[0;34m------------------------------------\033[0m"
echo -e "\E[44;1;39m           VPS SYSTEM MENU          \E[0m"
echo -e "\033[0;34m------------------------------------\033[0m"
echo ""
echo -e " [\e[36m 01 \e[0m] Panel Domain"
echo -e " [\e[36m 02 \e[0m] Change Port All Account"
echo -e " [\e[36m 03 \e[0m] Menu Backup Data VPS"
echo -e " [\e[36m 04 \e[0m] Webmin Menu"
echo -e " [\e[36m 05 \e[0m] Limit Bandwith Speed Server"
echo -e " [\e[36m 06 \e[0m] Check Running System Status Tunneling"
echo -e " [\e[36m 07 \e[0m] Check Usage of VPS Ram"
echo -e " [\e[36m 08 \e[0m] Reboot VPS"
echo -e " [\e[36m 09 \e[0m] Speedtest VPS"
echo -e " [\e[36m 10 \e[0m] Information Display System"
echo -e " [\e[36m 11 \e[0m] Install Default BBR"
echo -e " [\e[36m 12 \e[0m] Set Auto Reboot"
echo -e " [\e[36m 13 \e[0m] Clear Log"
echo -e " [\e[36m 14 \e[0m] Restart All Service"
echo -e " [\e[36m 15 \e[0m] Change Banner"
echo -e " [\e[36m 16 \e[0m] Cek Bandwith"
echo -e " [\e[36m 17 \e[0m] Update Script To Latest Version"
echo -e " [\e[36m 18 \e[0m] Kernel Update"
echo -e " [\e[36m 19 \e[0m] Swap KVM"
echo -e " [\e[36m 20 \e[0m] Add DNS Server & Netflix Content Checker"
echo -e " [\e[36m 21 \e[0m] Install TCP Tweaker"
echo -e " [\e[36m 22 \e[0m] Install Option BBR & TCP Acceleration"
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
    panel_domain
    ;;
2)
    clear
    port-change
    ;;
3)
    clear
    backupmenu
    ;;
4)
    clear
    webmin
    ;;
5)
    clear
    limit-speed
    ;;
6)
    clear
    running
    echo -e ""
    read -n 1 -s -r -p "Press any key go to menu"
    menu
    ;;
7)
    clear
    ram
    ;;
8)
    clear
    reboot
    ;;
9)
    clear
    speedtest
    ;;
10)
    clear
    info
    ;;
11)
    clear
    bbr
    ;;
12)
    clear
    auto-reboot
    ;;
13)
    clear
    clear-log
    ;;
14)
    clear
    rest_art
    ;;
15)
    clear
    nano /etc/issue.net
    ;;
16)
    clear
    bw
    ;;
17)
    clear
    update
    ;;
18)
    clear
    kernel-update
    ;;
19)
    clear
    swap_kvm
    ;;
20)
    clear
    menu_nf
    ;;
21)
    clear
    tweak
    ;;
22)
    clear
    tcp
    ;;
x)
    clear
    menu
    ;;
*)
    echo -e ""
    echo "Please enter an correct number"
    sleep 1
    m-system
    ;;
esac