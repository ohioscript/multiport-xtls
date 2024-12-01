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

link_multipath() {
clear
echo -e "\033[0;34m------------------------------------\033[0m"
echo -e "\E[44;1;39m        Xray Vless User Account     \E[0m"
echo -e "\033[0;34m------------------------------------\033[0m"
echo -e "Remarks       : ${user}"
echo -e "IP Address    : ${MYIP}"
echo -e "Domain        : ${domainn}"
echo -e "Port XTLS     : ${xtls}"
echo -e "Port TLS      : ${tls}"
echo -e "Port none TLS : ${none}"
echo -e "Path Vless WS : /vlessws or anypath"
echo -e "id            : ${uuid}"
echo -e "\033[0;34m------------------------------------\033[0m"
echo -e "Link Vless XTLS DIRECT :"
echo -e '```'
echo -e "${vlesslink1}"
echo -e '```'
echo -e "\033[0;34m------------------------------------\033[0m"
echo -e "Link Vless XTLS SPLICE :"
echo -e '```'
echo -e "${vlesslink2}"
echo -e '```'
echo -e "\033[0;34m------------------------------------\033[0m"
echo -e "Link Vless TCP TLS :"
echo -e '```'
echo -e "${vlesslink3}"
echo -e '```'
echo -e "\033[0;34m------------------------------------\033[0m"
echo -e "Link Vless WS TLS :"
echo -e '```'
echo -e "${vlesslink4}"
echo -e '```'
echo -e "\033[0;34m------------------------------------\033[0m"
echo -e "Link Vless WS none TLS :"
echo -e '```'
echo -e "${vlesslink5}"
echo -e '```'
echo -e "\033[0;34m------------------------------------\033[0m"
echo -e "Link Yaml TLS :"
echo -e ""
echo -e "${vlessyamltls}"
echo -e ""
echo -e "\033[0;34m------------------------------------\033[0m"
echo -e "Link Yaml none TLS :"
echo -e ""
echo -e "${vlessyamlntls}"
echo -e ""
echo -e "\033[0;34m------------------------------------\033[0m"
echo -e "Created On    : $hariini"
echo -e "Expired On    : $exp"
echo -e "\033[0;34m------------------------------------\033[0m"
echo ""
read -n 1 -s -r -p "Press any key to back on menu"
menu
}

link1() {
clear
echo -e "\033[0;34m------------------------------------\033[0m"
echo -e "\E[44;1;39m        Xray Vless User Account     \E[0m"
echo -e "\033[0;34m------------------------------------\033[0m"
echo -e "Remarks       : ${user}"
echo -e "IP Address    : ${MYIP}"
echo -e "Domain        : ${domainn}"
echo -e "Port XTLS     : ${xtls}"
echo -e "Port TLS      : ${tls}"
echo -e "Port none TLS : ${none}"
echo -e "id            : ${uuid}"
echo -e "\033[0;34m------------------------------------\033[0m"
echo -e "Link Vless XTLS DIRECT :"
echo -e '```'
echo -e "${vlesslink1}"
echo -e '```'
echo -e "\033[0;34m------------------------------------\033[0m"
echo -e "Link Vless XTLS SPLICE :"
echo -e '```'
echo -e "${vlesslink2}"
echo -e '```'
echo -e "\033[0;34m------------------------------------\033[0m"
echo -e "Link Vless TCP TLS :"
echo -e '```'
echo -e "${vlesslink3}"
echo -e '```'
echo -e "\033[0;34m------------------------------------\033[0m"
echo -e "Link Vless WS TLS :"
echo -e '```'
echo -e "${vlesslink4}"
echo -e '```'
echo -e "\033[0;34m------------------------------------\033[0m"
echo -e "Link Vless WS none TLS :"
echo -e '```'
echo -e "${vlesslink5}"
echo -e '```'
echo -e "\033[0;34m------------------------------------\033[0m"
echo -e "Link Yaml TLS :"
echo -e ""
echo -e "${vlessyamltls}"
echo -e ""
echo -e "\033[0;34m------------------------------------\033[0m"
echo -e "Link Yaml none TLS :"
echo -e ""
echo -e "${vlessyamlntls}"
echo -e ""
echo -e "\033[0;34m------------------------------------\033[0m"
echo -e "Created On    : $hariini"
echo -e "Expired On    : $exp"
echo -e "\033[0;34m------------------------------------\033[0m"
echo ""
read -n 1 -s -r -p "Press any key to back on menu"
menu
}

add_data() {
echo -e "1) WildCard BUG Domain"
echo -e "2) Domain Use IP Address"
echo -e "3) Reverse Proxy"    
read -p "Please Input Your Option " ans
if [[ "$ans" = 1 ]]; then
read -p "Input Wildcard BUG  : " wild
domain=$(cat /etc/xray/domain)
wild=${wild}.
read -p "Bug SNI / Host  : " BUG
if [ -z $BUG ]; then
BUG=isi_bug_disini
fi
elif [[ "$ans" = 2 ]]; then
domain=$MYIP
read -p "Bug SNI / Host  : " BUG
if [ -z $BUG ]; then
BUG=isi_bug_disini
fi
elif [[ "$ans" = 3 ]]; then
read -p "Bug SNI / Host  : " BUG
if [ -z $BUG ]; then
echo -e "PLEASE INPUT BUG!!"
sleep 3
add_data
fi
domain=$BUG
BUG=$(cat /root/domain)
else
domain=$(cat /etc/xray/domain)
read -p "Bug SNI / Host  : " BUG
if [ -z $BUG ]; then
BUG=isi_bug_disini
fi
fi
if [ -z $BUG ]; then
BUG=isi_bug_disini
fi
}

trojan_yamlntls() {
cat << EOF >> /home/vps/public_html/${user}_trojanntls.yaml
#Yaml MOD by VPN Legasi
port: 7890
socks-port: 7891
redir-port: 7892
mixed-port: 7893
tproxy-port: 7895
ipv6: false
mode: rule
log-level: silent
allow-lan: true
external-controller: 0.0.0.0:9090
secret: ""
bind-address: "*"
unified-delay: true
profile:
  store-selected: true
  store-fake-ip: true
dns:
  enable: true
  ipv6: false
  use-host: true
  enhanced-mode: fake-ip
  listen: 0.0.0.0:7874
  nameserver:
    - 8.8.8.8
    - 1.0.0.1
    - https://dns.google/dns-query
  fallback:
    - 1.1.1.1
    - 8.8.4.4
    - https://cloudflare-dns.com/dns-query
    - 112.215.203.254
  default-nameserver:
    - 8.8.8.8
    - 1.1.1.1
    - 112.215.203.254
  fake-ip-range: 198.18.0.1/16
  fake-ip-filter:
    - "*.lan"
    - "*.localdomain"
    - "*.example"
    - "*.invalid"
    - "*.localhost"
    - "*.test"
    - "*.local"
    - "*.home.arpa"
    - time.*.com
    - time.*.gov
    - time.*.edu.cn
    - time.*.apple.com
    - time1.*.com
    - time2.*.com
    - time3.*.com
    - time4.*.com
    - time5.*.com
    - time6.*.com
    - time7.*.com
    - ntp.*.com
    - ntp1.*.com
    - ntp2.*.com
    - ntp3.*.com
    - ntp4.*.com
    - ntp5.*.com
    - ntp6.*.com
    - ntp7.*.com
    - "*.time.edu.cn"
    - "*.ntp.org.cn"
    - +.pool.ntp.org
    - time1.cloud.tencent.com
    - music.163.com
    - "*.music.163.com"
    - "*.126.net"
    - musicapi.taihe.com
    - music.taihe.com
    - songsearch.kugou.com
    - trackercdn.kugou.com
    - "*.kuwo.cn"
    - api-jooxtt.sanook.com
    - api.joox.com
    - joox.com
    - y.qq.com
    - "*.y.qq.com"
    - streamoc.music.tc.qq.com
    - mobileoc.music.tc.qq.com
    - isure.stream.qqmusic.qq.com
    - dl.stream.qqmusic.qq.com
    - aqqmusic.tc.qq.com
    - amobile.music.tc.qq.com
    - "*.xiami.com"
    - "*.music.migu.cn"
    - music.migu.cn
    - "*.msftconnecttest.com"
    - "*.msftncsi.com"
    - msftconnecttest.com
    - msftncsi.com
    - localhost.ptlogin2.qq.com
    - localhost.sec.qq.com
    - +.srv.nintendo.net
    - +.stun.playstation.net
    - xbox.*.microsoft.com
    - xnotify.xboxlive.com
    - +.battlenet.com.cn
    - +.wotgame.cn
    - +.wggames.cn
    - +.wowsgame.cn
    - +.wargaming.net
    - proxy.golang.org
    - stun.*.*
    - stun.*.*.*
    - +.stun.*.*
    - +.stun.*.*.*
    - +.stun.*.*.*.*
    - heartbeat.belkin.com
    - "*.linksys.com"
    - "*.linksyssmartwifi.com"
    - "*.router.asus.com"
    - mesu.apple.com
    - swscan.apple.com
    - swquery.apple.com
    - swdownload.apple.com
    - swcdn.apple.com
    - swdist.apple.com
    - lens.l.google.com
    - stun.l.google.com
    - +.nflxvideo.net
    - "*.square-enix.com"
    - "*.finalfantasyxiv.com"
    - "*.ffxiv.com"
    - "*.mcdn.bilivideo.cn"
    - +.media.dssott.com
proxies:
  - name: ${user}
    server: ${domain}
    port: ${tr2}
    type: trojan
    password: ${uuid}
    skip-cert-verify: true
    sni: trojan-ws
    network: ws
    ws-opts:
      path: /trojan-ws
      headers:
        Host: isi_bug_disini
    udp: true
proxy-groups:
  - name: YAML-VPN-LEGASI
    type: select
    proxies:
      - ${user}
      - DIRECT
rules:
  - MATCH,YAML-VPN-LEGASI
EOF
}

trojan_yamltls() {
cat << EOF >> /home/vps/public_html/${user}_trojantls.yaml
#Yaml MOD by VPN Legasi
port: 7890
socks-port: 7891
redir-port: 7892
mixed-port: 7893
tproxy-port: 7895
ipv6: false
mode: rule
log-level: silent
allow-lan: true
external-controller: 0.0.0.0:9090
secret: ""
bind-address: "*"
unified-delay: true
profile:
  store-selected: true
  store-fake-ip: true
dns:
  enable: true
  ipv6: false
  use-host: true
  enhanced-mode: fake-ip
  listen: 0.0.0.0:7874
  nameserver:
    - 8.8.8.8
    - 1.0.0.1
    - https://dns.google/dns-query
  fallback:
    - 1.1.1.1
    - 8.8.4.4
    - https://cloudflare-dns.com/dns-query
    - 112.215.203.254
  default-nameserver:
    - 8.8.8.8
    - 1.1.1.1
    - 112.215.203.254
  fake-ip-range: 198.18.0.1/16
  fake-ip-filter:
    - "*.lan"
    - "*.localdomain"
    - "*.example"
    - "*.invalid"
    - "*.localhost"
    - "*.test"
    - "*.local"
    - "*.home.arpa"
    - time.*.com
    - time.*.gov
    - time.*.edu.cn
    - time.*.apple.com
    - time1.*.com
    - time2.*.com
    - time3.*.com
    - time4.*.com
    - time5.*.com
    - time6.*.com
    - time7.*.com
    - ntp.*.com
    - ntp1.*.com
    - ntp2.*.com
    - ntp3.*.com
    - ntp4.*.com
    - ntp5.*.com
    - ntp6.*.com
    - ntp7.*.com
    - "*.time.edu.cn"
    - "*.ntp.org.cn"
    - +.pool.ntp.org
    - time1.cloud.tencent.com
    - music.163.com
    - "*.music.163.com"
    - "*.126.net"
    - musicapi.taihe.com
    - music.taihe.com
    - songsearch.kugou.com
    - trackercdn.kugou.com
    - "*.kuwo.cn"
    - api-jooxtt.sanook.com
    - api.joox.com
    - joox.com
    - y.qq.com
    - "*.y.qq.com"
    - streamoc.music.tc.qq.com
    - mobileoc.music.tc.qq.com
    - isure.stream.qqmusic.qq.com
    - dl.stream.qqmusic.qq.com
    - aqqmusic.tc.qq.com
    - amobile.music.tc.qq.com
    - "*.xiami.com"
    - "*.music.migu.cn"
    - music.migu.cn
    - "*.msftconnecttest.com"
    - "*.msftncsi.com"
    - msftconnecttest.com
    - msftncsi.com
    - localhost.ptlogin2.qq.com
    - localhost.sec.qq.com
    - +.srv.nintendo.net
    - +.stun.playstation.net
    - xbox.*.microsoft.com
    - xnotify.xboxlive.com
    - +.battlenet.com.cn
    - +.wotgame.cn
    - +.wggames.cn
    - +.wowsgame.cn
    - +.wargaming.net
    - proxy.golang.org
    - stun.*.*
    - stun.*.*.*
    - +.stun.*.*
    - +.stun.*.*.*
    - +.stun.*.*.*.*
    - heartbeat.belkin.com
    - "*.linksys.com"
    - "*.linksyssmartwifi.com"
    - "*.router.asus.com"
    - mesu.apple.com
    - swscan.apple.com
    - swquery.apple.com
    - swdownload.apple.com
    - swcdn.apple.com
    - swdist.apple.com
    - lens.l.google.com
    - stun.l.google.com
    - +.nflxvideo.net
    - "*.square-enix.com"
    - "*.finalfantasyxiv.com"
    - "*.ffxiv.com"
    - "*.mcdn.bilivideo.cn"
    - +.media.dssott.com
proxies:
  - name: ${user}
    server: ${domain}
    port: ${tr}
    type: trojan
    password: ${uuid}
    skip-cert-verify: true
    sni: isi_bug_disini
    network: ws
    ws-opts:
      path: /trojan-ws
      headers:
        Host: ""
    udp: true
proxy-groups:
  - name: YAML-VPN-LEGASI
    type: select
    proxies:
      - ${user}
      - DIRECT
rules:
  - MATCH,YAML-VPN-LEGASI
EOF
}

vless_yamltls() {
cat << EOF >> /home/vps/public_html/${user}_vlesstls.yaml
#Yaml MOD by VPN Legasi
port: 7890
socks-port: 7891
redir-port: 7892
mixed-port: 7893
tproxy-port: 7895
ipv6: false
mode: rule
log-level: silent
allow-lan: true
external-controller: 0.0.0.0:9090
secret: ""
bind-address: "*"
unified-delay: true
profile:
  store-selected: true
  store-fake-ip: true
dns:
  enable: true
  ipv6: false
  use-host: true
  enhanced-mode: fake-ip
  listen: 0.0.0.0:7874
  nameserver:
    - 8.8.8.8
    - 1.0.0.1
    - https://dns.google/dns-query
  fallback:
    - 1.1.1.1
    - 8.8.4.4
    - https://cloudflare-dns.com/dns-query
    - 112.215.203.254
  default-nameserver:
    - 8.8.8.8
    - 1.1.1.1
    - 112.215.203.254
  fake-ip-range: 198.18.0.1/16
  fake-ip-filter:
    - "*.lan"
    - "*.localdomain"
    - "*.example"
    - "*.invalid"
    - "*.localhost"
    - "*.test"
    - "*.local"
    - "*.home.arpa"
    - time.*.com
    - time.*.gov
    - time.*.edu.cn
    - time.*.apple.com
    - time1.*.com
    - time2.*.com
    - time3.*.com
    - time4.*.com
    - time5.*.com
    - time6.*.com
    - time7.*.com
    - ntp.*.com
    - ntp1.*.com
    - ntp2.*.com
    - ntp3.*.com
    - ntp4.*.com
    - ntp5.*.com
    - ntp6.*.com
    - ntp7.*.com
    - "*.time.edu.cn"
    - "*.ntp.org.cn"
    - +.pool.ntp.org
    - time1.cloud.tencent.com
    - music.163.com
    - "*.music.163.com"
    - "*.126.net"
    - musicapi.taihe.com
    - music.taihe.com
    - songsearch.kugou.com
    - trackercdn.kugou.com
    - "*.kuwo.cn"
    - api-jooxtt.sanook.com
    - api.joox.com
    - joox.com
    - y.qq.com
    - "*.y.qq.com"
    - streamoc.music.tc.qq.com
    - mobileoc.music.tc.qq.com
    - isure.stream.qqmusic.qq.com
    - dl.stream.qqmusic.qq.com
    - aqqmusic.tc.qq.com
    - amobile.music.tc.qq.com
    - "*.xiami.com"
    - "*.music.migu.cn"
    - music.migu.cn
    - "*.msftconnecttest.com"
    - "*.msftncsi.com"
    - msftconnecttest.com
    - msftncsi.com
    - localhost.ptlogin2.qq.com
    - localhost.sec.qq.com
    - +.srv.nintendo.net
    - +.stun.playstation.net
    - xbox.*.microsoft.com
    - xnotify.xboxlive.com
    - +.battlenet.com.cn
    - +.wotgame.cn
    - +.wggames.cn
    - +.wowsgame.cn
    - +.wargaming.net
    - proxy.golang.org
    - stun.*.*
    - stun.*.*.*
    - +.stun.*.*
    - +.stun.*.*.*
    - +.stun.*.*.*.*
    - heartbeat.belkin.com
    - "*.linksys.com"
    - "*.linksyssmartwifi.com"
    - "*.router.asus.com"
    - mesu.apple.com
    - swscan.apple.com
    - swquery.apple.com
    - swdownload.apple.com
    - swcdn.apple.com
    - swdist.apple.com
    - lens.l.google.com
    - stun.l.google.com
    - +.nflxvideo.net
    - "*.square-enix.com"
    - "*.finalfantasyxiv.com"
    - "*.ffxiv.com"
    - "*.mcdn.bilivideo.cn"
    - +.media.dssott.com
proxies:
  - name: ${user}
    server: ${domain}
    port: ${tls}
    type: vless
    uuid: ${uuid}
    cipher: auto
    tls: true
    skip-cert-verify: true
    servername: isi_bug_disini
    network: ws
    ws-opts:
      path: /vlessws
      headers:
        Host: ${domain}
    udp: true
proxy-groups:
  - name: YAML-VPN-LEGASI
    type: select
    proxies:
      - ${user}
      - DIRECT
rules:
  - MATCH,YAML-VPN-LEGASI
EOF
}

vless_yamlntls() {
cat << EOF >> /home/vps/public_html/${user}_vlessntls.yaml
#Yaml MOD by VPN Legasi
port: 7890
socks-port: 7891
redir-port: 7892
mixed-port: 7893
tproxy-port: 7895
ipv6: false
mode: rule
log-level: silent
allow-lan: true
external-controller: 0.0.0.0:9090
secret: ""
bind-address: "*"
unified-delay: true
profile:
  store-selected: true
  store-fake-ip: true
dns:
  enable: true
  ipv6: false
  use-host: true
  enhanced-mode: fake-ip
  listen: 0.0.0.0:7874
  nameserver:
    - 8.8.8.8
    - 1.0.0.1
    - https://dns.google/dns-query
  fallback:
    - 1.1.1.1
    - 8.8.4.4
    - https://cloudflare-dns.com/dns-query
    - 112.215.203.254
  default-nameserver:
    - 8.8.8.8
    - 1.1.1.1
    - 112.215.203.254
  fake-ip-range: 198.18.0.1/16
  fake-ip-filter:
    - "*.lan"
    - "*.localdomain"
    - "*.example"
    - "*.invalid"
    - "*.localhost"
    - "*.test"
    - "*.local"
    - "*.home.arpa"
    - time.*.com
    - time.*.gov
    - time.*.edu.cn
    - time.*.apple.com
    - time1.*.com
    - time2.*.com
    - time3.*.com
    - time4.*.com
    - time5.*.com
    - time6.*.com
    - time7.*.com
    - ntp.*.com
    - ntp1.*.com
    - ntp2.*.com
    - ntp3.*.com
    - ntp4.*.com
    - ntp5.*.com
    - ntp6.*.com
    - ntp7.*.com
    - "*.time.edu.cn"
    - "*.ntp.org.cn"
    - +.pool.ntp.org
    - time1.cloud.tencent.com
    - music.163.com
    - "*.music.163.com"
    - "*.126.net"
    - musicapi.taihe.com
    - music.taihe.com
    - songsearch.kugou.com
    - trackercdn.kugou.com
    - "*.kuwo.cn"
    - api-jooxtt.sanook.com
    - api.joox.com
    - joox.com
    - y.qq.com
    - "*.y.qq.com"
    - streamoc.music.tc.qq.com
    - mobileoc.music.tc.qq.com
    - isure.stream.qqmusic.qq.com
    - dl.stream.qqmusic.qq.com
    - aqqmusic.tc.qq.com
    - amobile.music.tc.qq.com
    - "*.xiami.com"
    - "*.music.migu.cn"
    - music.migu.cn
    - "*.msftconnecttest.com"
    - "*.msftncsi.com"
    - msftconnecttest.com
    - msftncsi.com
    - localhost.ptlogin2.qq.com
    - localhost.sec.qq.com
    - +.srv.nintendo.net
    - +.stun.playstation.net
    - xbox.*.microsoft.com
    - xnotify.xboxlive.com
    - +.battlenet.com.cn
    - +.wotgame.cn
    - +.wggames.cn
    - +.wowsgame.cn
    - +.wargaming.net
    - proxy.golang.org
    - stun.*.*
    - stun.*.*.*
    - +.stun.*.*
    - +.stun.*.*.*
    - +.stun.*.*.*.*
    - heartbeat.belkin.com
    - "*.linksys.com"
    - "*.linksyssmartwifi.com"
    - "*.router.asus.com"
    - mesu.apple.com
    - swscan.apple.com
    - swquery.apple.com
    - swdownload.apple.com
    - swcdn.apple.com
    - swdist.apple.com
    - lens.l.google.com
    - stun.l.google.com
    - +.nflxvideo.net
    - "*.square-enix.com"
    - "*.finalfantasyxiv.com"
    - "*.ffxiv.com"
    - "*.mcdn.bilivideo.cn"
    - +.media.dssott.com
proxies:
  - name: ${user}
    server: ${domain}
    port: ${none}
    type: vless
    uuid: ${uuid}
    cipher: auto
    tls: false
    skip-cert-verify: true
    servername: ""
    network: ws
    ws-opts:
      path: /vlessws
      headers:
        Host: isi_bug_disini
    udp: true
proxy-groups:
  - name: YAML-VPN-LEGASI
    type: select
    proxies:
      - ${user}
      - DIRECT
rules:
  - MATCH,YAML-VPN-LEGASI
EOF
}

vmess_yamltls() {
cat << EOF >> /home/vps/public_html/${user}_vmesstls.yaml
#Yaml MOD by VPN Legasi
port: 7890
socks-port: 7891
redir-port: 7892
mixed-port: 7893
tproxy-port: 7895
ipv6: false
mode: rule
log-level: silent
allow-lan: true
external-controller: 0.0.0.0:9090
secret: ""
bind-address: "*"
unified-delay: true
profile:
  store-selected: true
  store-fake-ip: true
dns:
  enable: true
  ipv6: false
  use-host: true
  enhanced-mode: fake-ip
  listen: 0.0.0.0:7874
  nameserver:
    - 8.8.8.8
    - 1.0.0.1
    - https://dns.google/dns-query
  fallback:
    - 1.1.1.1
    - 8.8.4.4
    - https://cloudflare-dns.com/dns-query
    - 112.215.203.254
  default-nameserver:
    - 8.8.8.8
    - 1.1.1.1
    - 112.215.203.254
  fake-ip-range: 198.18.0.1/16
  fake-ip-filter:
    - "*.lan"
    - "*.localdomain"
    - "*.example"
    - "*.invalid"
    - "*.localhost"
    - "*.test"
    - "*.local"
    - "*.home.arpa"
    - time.*.com
    - time.*.gov
    - time.*.edu.cn
    - time.*.apple.com
    - time1.*.com
    - time2.*.com
    - time3.*.com
    - time4.*.com
    - time5.*.com
    - time6.*.com
    - time7.*.com
    - ntp.*.com
    - ntp1.*.com
    - ntp2.*.com
    - ntp3.*.com
    - ntp4.*.com
    - ntp5.*.com
    - ntp6.*.com
    - ntp7.*.com
    - "*.time.edu.cn"
    - "*.ntp.org.cn"
    - +.pool.ntp.org
    - time1.cloud.tencent.com
    - music.163.com
    - "*.music.163.com"
    - "*.126.net"
    - musicapi.taihe.com
    - music.taihe.com
    - songsearch.kugou.com
    - trackercdn.kugou.com
    - "*.kuwo.cn"
    - api-jooxtt.sanook.com
    - api.joox.com
    - joox.com
    - y.qq.com
    - "*.y.qq.com"
    - streamoc.music.tc.qq.com
    - mobileoc.music.tc.qq.com
    - isure.stream.qqmusic.qq.com
    - dl.stream.qqmusic.qq.com
    - aqqmusic.tc.qq.com
    - amobile.music.tc.qq.com
    - "*.xiami.com"
    - "*.music.migu.cn"
    - music.migu.cn
    - "*.msftconnecttest.com"
    - "*.msftncsi.com"
    - msftconnecttest.com
    - msftncsi.com
    - localhost.ptlogin2.qq.com
    - localhost.sec.qq.com
    - +.srv.nintendo.net
    - +.stun.playstation.net
    - xbox.*.microsoft.com
    - xnotify.xboxlive.com
    - +.battlenet.com.cn
    - +.wotgame.cn
    - +.wggames.cn
    - +.wowsgame.cn
    - +.wargaming.net
    - proxy.golang.org
    - stun.*.*
    - stun.*.*.*
    - +.stun.*.*
    - +.stun.*.*.*
    - +.stun.*.*.*.*
    - heartbeat.belkin.com
    - "*.linksys.com"
    - "*.linksyssmartwifi.com"
    - "*.router.asus.com"
    - mesu.apple.com
    - swscan.apple.com
    - swquery.apple.com
    - swdownload.apple.com
    - swcdn.apple.com
    - swdist.apple.com
    - lens.l.google.com
    - stun.l.google.com
    - +.nflxvideo.net
    - "*.square-enix.com"
    - "*.finalfantasyxiv.com"
    - "*.ffxiv.com"
    - "*.mcdn.bilivideo.cn"
    - +.media.dssott.com
proxies:
  - name: ${user}
    server: ${domain}
    port: ${tls}
    type: vmess
    uuid: ${uuid}
    alterId: 0
    cipher: auto
    tls: true
    skip-cert-verify: true
    servername: isi_bug_disini
    network: ws
    ws-opts:
      path: /vmessws
      headers:
        Host: ""
    udp: true
proxy-groups:
  - name: YAML-VPN-LEGASI
    type: select
    proxies:
      - ${user}
      - DIRECT
rules:
  - MATCH,YAML-VPN-LEGASI
EOF
}

vmess_yamlntls() {
cat << EOF >> /home/vps/public_html/${user}_vmessntls.yaml
#Yaml MOD by VPN Legasi
port: 7890
socks-port: 7891
redir-port: 7892
mixed-port: 7893
tproxy-port: 7895
ipv6: false
mode: rule
log-level: silent
allow-lan: true
external-controller: 0.0.0.0:9090
secret: ""
bind-address: "*"
unified-delay: true
profile:
  store-selected: true
  store-fake-ip: true
dns:
  enable: true
  ipv6: false
  use-host: true
  enhanced-mode: fake-ip
  listen: 0.0.0.0:7874
  nameserver:
    - 8.8.8.8
    - 1.0.0.1
    - https://dns.google/dns-query
  fallback:
    - 1.1.1.1
    - 8.8.4.4
    - https://cloudflare-dns.com/dns-query
    - 112.215.203.254
  default-nameserver:
    - 8.8.8.8
    - 1.1.1.1
    - 112.215.203.254
  fake-ip-range: 198.18.0.1/16
  fake-ip-filter:
    - "*.lan"
    - "*.localdomain"
    - "*.example"
    - "*.invalid"
    - "*.localhost"
    - "*.test"
    - "*.local"
    - "*.home.arpa"
    - time.*.com
    - time.*.gov
    - time.*.edu.cn
    - time.*.apple.com
    - time1.*.com
    - time2.*.com
    - time3.*.com
    - time4.*.com
    - time5.*.com
    - time6.*.com
    - time7.*.com
    - ntp.*.com
    - ntp1.*.com
    - ntp2.*.com
    - ntp3.*.com
    - ntp4.*.com
    - ntp5.*.com
    - ntp6.*.com
    - ntp7.*.com
    - "*.time.edu.cn"
    - "*.ntp.org.cn"
    - +.pool.ntp.org
    - time1.cloud.tencent.com
    - music.163.com
    - "*.music.163.com"
    - "*.126.net"
    - musicapi.taihe.com
    - music.taihe.com
    - songsearch.kugou.com
    - trackercdn.kugou.com
    - "*.kuwo.cn"
    - api-jooxtt.sanook.com
    - api.joox.com
    - joox.com
    - y.qq.com
    - "*.y.qq.com"
    - streamoc.music.tc.qq.com
    - mobileoc.music.tc.qq.com
    - isure.stream.qqmusic.qq.com
    - dl.stream.qqmusic.qq.com
    - aqqmusic.tc.qq.com
    - amobile.music.tc.qq.com
    - "*.xiami.com"
    - "*.music.migu.cn"
    - music.migu.cn
    - "*.msftconnecttest.com"
    - "*.msftncsi.com"
    - msftconnecttest.com
    - msftncsi.com
    - localhost.ptlogin2.qq.com
    - localhost.sec.qq.com
    - +.srv.nintendo.net
    - +.stun.playstation.net
    - xbox.*.microsoft.com
    - xnotify.xboxlive.com
    - +.battlenet.com.cn
    - +.wotgame.cn
    - +.wggames.cn
    - +.wowsgame.cn
    - +.wargaming.net
    - proxy.golang.org
    - stun.*.*
    - stun.*.*.*
    - +.stun.*.*
    - +.stun.*.*.*
    - +.stun.*.*.*.*
    - heartbeat.belkin.com
    - "*.linksys.com"
    - "*.linksyssmartwifi.com"
    - "*.router.asus.com"
    - mesu.apple.com
    - swscan.apple.com
    - swquery.apple.com
    - swdownload.apple.com
    - swcdn.apple.com
    - swdist.apple.com
    - lens.l.google.com
    - stun.l.google.com
    - +.nflxvideo.net
    - "*.square-enix.com"
    - "*.finalfantasyxiv.com"
    - "*.ffxiv.com"
    - "*.mcdn.bilivideo.cn"
    - +.media.dssott.com
proxies:
  - name: ${user}
    server: ${domain}
    port: ${none}
    type: vmess
    uuid: ${uuid}
    alterId: 0
    cipher: auto
    tls: false
    skip-cert-verify: true
    servername: ""
    network: ws
    ws-opts:
      path: /vmessws
      headers:
        Host: isi_bug_disini
    udp: true
proxy-groups:
  - name: YAML-VPN-LEGASI
    type: select
    proxies:
      - ${user}
      - DIRECT
rules:
  - MATCH,YAML-VPN-LEGASI
EOF
}

sodosok_ntls() {
cat <<EOF >>"/home/vps/public_html/${user}-NTLS"
{
  "dns": {
    "servers": [
      "8.8.8.8",
      "8.8.4.4"
    ]
  },
 "inbounds": [
   {
      "port": 10808,
      "protocol": "socks",
      "settings": {
        "auth": "noauth",
        "udp": true,
        "userLevel": 8
      },
      "sniffing": {
        "destOverride": [
          "http",
          "tls"
        ],
        "enabled": false
      },
      "tag": "socks"
    },
    {
      "port": 10809,
      "protocol": "http",
      "settings": {
        "userLevel": 8
      },
      "tag": "http"
    }
  ],
  "log": {
    "loglevel": "none"
  },
  "outbounds": [
    {
      "mux": {
        "enabled": false
      },
      "protocol": "shadowsocks",
      "settings": {
        "servers": [
          {
            "address": "${wild}${domain}",
            "level": 8,
            "method": "aes-128-gcm",
            "password": "${uuid}",
            "port": ${none},
            "uot": true
          }
        ]
      },
      "streamSettings": {
        "network": "ws",
        "security": "none",
        "wsSettings": {
          "headers": {
            "Host": "${BUG}"
          },
          "path": "/shadowsocks"
        }
      },
      "tag": "proxy"
    },
    {
      "protocol": "freedom",
      "settings": {},
      "tag": "direct"
    },
    {
      "protocol": "blackhole",
      "settings": {
        "response": {
          "type": "http"
        }
      },
      "tag": "block"
    }
  ],
  "policy": {
    "levels": {
      "8": {
        "connIdle": 300,
        "downlinkOnly": 1,
        "handshake": 4,
        "uplinkOnly": 1
      }
    },
    "system": {
      "statsOutboundUplink": true,
      "statsOutboundDownlink": true
    }
  },
  "routing": {
    "domainStrategy": "Asls",
"rules": []
  },
  "stats": {}
}
EOF
}

sodosok_tls() {
cat <<EOF >>"/home/vps/public_html/${user}-TLS"
{ 
 "dns": {
    "servers": [
      "8.8.8.8",
      "8.8.4.4"
    ]
  },
 "inbounds": [
   {
      "port": 10808,
      "protocol": "socks",
      "settings": {
        "auth": "noauth",
        "udp": true,
        "userLevel": 8
      },
      "sniffing": {
        "destOverride": [
          "http",
          "tls"
        ],
        "enabled": true
      },
      "tag": "socks"
    },
    {
      "port": 10809,
      "protocol": "http",
      "settings": {
        "userLevel": 8
      },
      "tag": "http"
    }
  ],
  "log": {
    "loglevel": "none"
  },
  "outbounds": [
    {
      "mux": {
        "enabled": true
      },
      "protocol": "shadowsocks",
      "settings": {
        "servers": [
          {
            "address": "${wild}${domain}",
            "level": 8,
            "method": "aes-128-gcm",
            "password": "${uuid}",
            "port": ${tls}
          }
        ]
      },
      "streamSettings": {
        "network": "ws",
        "security": "tls",
        "tlsSettings": {
          "allowInsecure": true,
          "serverName": "${BUG}"
        },
        "wsSettings": {
          "headers": {
            "Host": "${domain}"
          },
          "path": "/shadowsocks"
        }
      },
      "tag": "proxy"
    },
    {
      "protocol": "freedom",
      "settings": {},
      "tag": "direct"
    },
    {
      "protocol": "blackhole",
      "settings": {
        "response": {
          "type": "http"
        }
      },
      "tag": "block"
    }
  ],
  "policy": {
    "levels": {
      "8": {
        "connIdle": 300,
        "downlinkOnly": 1,
        "handshake": 4,
        "uplinkOnly": 1
      }
    },
    "system": {
      "statsOutboundUplink": true,
      "statsOutboundDownlink": true
    }
  },
  "routing": {
    "domainStrategy": "Asls",
"rules": []
  },
  "stats": {}
}
EOF
}

trial-vmess() {
clear
tls="$(cat ~/log-install.txt | grep -w "XRAY Vmess WS TLS" | cut -d: -f2|sed 's/ //g')"
none="$(cat ~/log-install.txt | grep -w "XRAY Vmess WS None TLS" | cut -d: -f2|sed 's/ //g')"
source /var/lib/premium-script/ipvps.conf
if [[ "$IP" = "" ]]; then
domain=$(cat /etc/xray/domain)
else
domain=$IP
fi

until [[ $user =~ ^[a-zA-Z0-9_]+$ && ${CLIENT_EXISTS} == '0' ]]; do
echo -e "\033[0;34m-------------------------------\033[0m"
echo -e "\E[44;1;39m    Trial Xray Vmess Account   \E[0m"
echo -e "\033[0;34m-------------------------------\033[0m"
	user=VMESS`</dev/urandom tr -dc X-Z0-9 | head -c4`
	CLIENT_EXISTS=$(grep -w $user /usr/local/etc/xray/vmess.json | wc -l)
	if [[ ${CLIENT_EXISTS} == '1' ]]; then
	clear
	echo -e "\033[0;34m-------------------------------\033[0m"
	echo -e "\E[44;1;39m    Trial Xray Vmess Account   \E[0m"
	echo -e "\033[0;34m-------------------------------\033[0m"
	echo ""
	echo "A client with the specified name was already created, please choose another name."
	echo ""
	echo -e "\033[0;34m------------------------------------\033[0m"
	read -n 1 -s -r -p "Press any key to back on menu"
	menu_xray
	fi
	done
add_data
uuid=$(cat /proc/sys/kernel/random/uuid)
masaaktif=1
hariini=`date -d "0 days" +"%Y-%m-%d"`
exp=`date -d "$masaaktif days" +"%Y-%m-%d"`
sed -i '/#vmess$/a\### '"$user $exp"'\
},{"id": "'""$uuid""'","alterId": '"0"',"email": "'""$user""'"' /usr/local/etc/xray/vmess.json
exp=`date -d "$masaaktif days" +"%Y-%m-%d"`
asu=`cat<<EOF
      {
      "v": "2",
      "ps": "${user}",
      "add": "${wild}${domain}",
      "port": "${tls}",
      "id": "${uuid}",
      "aid": "0",
      "net": "ws",
      "path": "/vmessws",
      "type": "none",
      "host": "${BUG}",
      "tls": "tls"
}
EOF`
ask=`cat<<EOF
      {
      "v": "2",
      "ps": "${user}",
      "add": "${wild}${domain}",
      "port": "${none}",
      "id": "${uuid}",
      "aid": "0",
      "net": "ws",
      "path": "/vmessws",
      "type": "none",
      "host": "${BUG}",
      "tls": "none"
}
EOF`

vmess_base641=$( base64 -w 0 <<< $vmess_json1)
vmess_base642=$( base64 -w 0 <<< $vmess_json2)

vmesslink1="vmess://$(echo $asu | base64 -w 0)" 
vmesslink2="vmess://$(echo $ask | base64 -w 0)"

rm -rf /home/vps/public_html/${user}* > /dev/null 2>&1
vmess_yamltls
vmess_yamlntls
vmessyamltls=http://$MYIP:81/${user}_vmesstls.yaml
vmessyamlntls=http://$MYIP:81/${user}_vmessntls.yaml

service cron restart > /dev/null 2>&1
systemctl restart xray@vmess > /dev/null 2>&1

clear
echo -e "\033[0;34m------------------------------------\033[0m"
echo -e "\E[44;1;39m       Trial Xray Vmess Account     \E[0m"
echo -e "\033[0;34m------------------------------------\033[0m"
echo -e "Remarks       : ${user}"
echo -e "IP Address    : ${MYIP}"
echo -e "Domain        : ${domain}"
echo -e "Port TLS      : ${tls}"
echo -e "Port none TLS : ${none}"
echo -e "id            : ${uuid}"
echo -e "\033[0;34m------------------------------------\033[0m"
echo -e "Link TLS :"
echo -e '```'
echo -e "${vmesslink1}"
echo -e '```'
echo -e "\033[0;34m------------------------------------\033[0m"
echo -e "Link none TLS :"
echo -e '```'
echo -e "${vmesslink2}"
echo -e '```'
echo -e "\033[0;34m------------------------------------\033[0m"
echo -e "Link Yaml TLS :"
echo -e ""
echo -e "${vmessyamltls}"
echo -e ""
echo -e "\033[0;34m------------------------------------\033[0m"
echo -e "Link Yaml none TLS :"
echo -e ""
echo -e "${vmessyamlntls}"
echo -e ""
echo -e "\033[0;34m------------------------------------\033[0m"
echo -e "Created On    : $hariini"
echo -e "Expired On    : $exp"
echo -e "\033[0;34m------------------------------------\033[0m"
echo ""
read -n 1 -s -r -p "Press any key to back on menu"
menu
}

add-vmess() {
clear
tls="$(cat ~/log-install.txt | grep -w "XRAY Vmess WS TLS" | cut -d: -f2|sed 's/ //g')"
none="$(cat ~/log-install.txt | grep -w "XRAY Vmess WS None TLS" | cut -d: -f2|sed 's/ //g')"
source /var/lib/premium-script/ipvps.conf
if [[ "$IP" = "" ]]; then
domain=$(cat /etc/xray/domain)
else
domain=$IP
fi

until [[ $user =~ ^[a-zA-Z0-9_]+$ && ${CLIENT_EXISTS} == '0' ]]; do
echo -e "\033[0;34m-------------------------------\033[0m"
echo -e "\E[44;1;39m     Add Xray Vmess Account    \E[0m"
echo -e "\033[0;34m-------------------------------\033[0m"
		read -rp "User: " -e user
		CLIENT_EXISTS=$(grep -w $user /usr/local/etc/xray/vmess.json | wc -l)

		if [[ ${CLIENT_EXISTS} == '1' ]]; then
clear
	    echo -e "\033[0;34m-------------------------------\033[0m"
	    echo -e "\E[44;1;39m     Add Xray Vmess Account    \E[0m"
	    echo -e "\033[0;34m-------------------------------\033[0m"
			echo ""
			echo "A client with the specified name was already created, please choose another name."
			echo ""
			echo -e "\033[0;34m------------------------------------\033[0m"
			read -n 1 -s -r -p "Press any key to back on menu"
			menu_xray
		fi
	done

uuid=$(cat /proc/sys/kernel/random/uuid)
add_data
read -p "Expired (days): " masaaktif
hariini=`date -d "0 days" +"%Y-%m-%d"`
exp=`date -d "$masaaktif days" +"%Y-%m-%d"`
sed -i '/#vmess$/a\### '"$user $exp"'\
},{"id": "'""$uuid""'","alterId": '"0"',"email": "'""$user""'"' /usr/local/etc/xray/vmess.json
asu=`cat<<EOF
      {
      "v": "2",
      "ps": "${user}",
      "add": "${wild}${domain}",
      "port": "${tls}",
      "id": "${uuid}",
      "aid": "0",
      "net": "ws",
      "path": "/vmessws",
      "type": "none",
      "host": "${BUG}",
      "tls": "tls"
}
EOF`
ask=`cat<<EOF
      {
      "v": "2",
      "ps": "${user}",
      "add": "${wild}${domain}",
      "port": "${none}",
      "id": "${uuid}",
      "aid": "0",
      "net": "ws",
      "path": "/vmessws",
      "type": "none",
      "host": "${BUG}",
      "tls": "none"
}
EOF`


vmess_base641=$( base64 -w 0 <<< $vmess_json1)
vmess_base642=$( base64 -w 0 <<< $vmess_json2)
vmesslink1="vmess://$(echo $asu | base64 -w 0)" 
vmesslink2="vmess://$(echo $ask | base64 -w 0)"

rm -rf /home/vps/public_html/${user}* > /dev/null 2>&1
vmess_yamltls
vmess_yamlntls
vmessyamltls=http://$MYIP:81/${user}_vmesstls.yaml
vmessyamlntls=http://$MYIP:81/${user}_vmessntls.yaml

service cron restart > /dev/null 2>&1
systemctl restart xray@vmess > /dev/null 2>&1

clear
echo -e "\033[0;34m------------------------------------\033[0m"
echo -e "\E[44;1;39m        User Xray Vmess Account     \E[0m"
echo -e "\033[0;34m------------------------------------\033[0m"
echo -e "Remarks       : ${user}"
echo -e "IP Address    : ${MYIP}"
echo -e "Domain        : ${domain}"
echo -e "Port TLS      : ${tls}"
echo -e "Port none TLS : ${none}"
echo -e "id            : ${uuid}"
echo -e "\033[0;34m------------------------------------\033[0m"
echo -e "Link TLS :"
echo -e '```'
echo -e "${vmesslink1}"
echo -e '```'
echo -e "\033[0;34m------------------------------------\033[0m"
echo -e "Link none TLS :"
echo -e '```'
echo -e "${vmesslink2}"
echo -e '```'
echo -e "\033[0;34m------------------------------------\033[0m"
echo -e "Link Yaml TLS :"
echo -e ""
echo -e "${vmessyamltls}"
echo -e ""
echo -e "\033[0;34m------------------------------------\033[0m"
echo -e "Link Yaml none TLS :"
echo -e ""
echo -e "${vmessyamlntls}"
echo -e ""
echo -e "\033[0;34m------------------------------------\033[0m"
echo -e "Created On    : $hariini"
echo -e "Expired On    : $exp"
echo -e "\033[0;34m------------------------------------\033[0m"
echo ""
read -n 1 -s -r -p "Press any key to back on menu"
menu
}

cek-vmess() {
clear
#echo -n /var/log/xray/access2.log
echo -n > /tmp/other.txt
data=( `cat /usr/local/etc/xray/vmess.json | grep '^###' | cut -d ' ' -f 2 | sort | uniq`);
echo -e "\033[0;34m-------------------------------\033[0m"
echo -e "\E[44;1;39m      XRAY Vmess User Login    \E[0m"
echo -e "\033[0;34m-------------------------------\033[0m"
for akun in "${data[@]}"
do
if [[ -z "$akun" ]]; then
akun="tidakada"
fi

echo -n > /tmp/ipvmess.txt
data2=( `cat /var/log/xray/access2.log | tail -n 500 | cut -d " " -f 3 | sed 's/tcp://g' | cut -d ":" -f 1 | sort | uniq`);
for ip in "${data2[@]}"
do

jum=$(cat /var/log/xray/access2.log | grep -w "$akun" | tail -n 500 | cut -d " " -f 3 | sed 's/tcp://g' | cut -d ":" -f 1 | grep -w "$ip" | sort | uniq)
if [[ "$jum" = "$ip" ]]; then
echo "$jum" >> /tmp/ipvmess.txt
else
echo "$ip" >> /tmp/other.txt
fi
jum2=$(cat /tmp/ipvmess.txt)
sed -i "/$jum2/d" /tmp/other.txt > /dev/null 2>&1
done

jum=$(cat /tmp/ipvmess.txt)
if [[ -z "$jum" ]]; then
echo > /dev/null
else
jum2=$(cat /tmp/ipvmess.txt | nl)
echo "user : $akun";
echo "$jum2";
echo -e "\033[0;34m------------------------------------\033[0m"
fi
rm -rf /tmp/ipvmess.txt
done

rm -rf /tmp/other.txt
echo ""
read -n 1 -s -r -p "Press any key to back on menu"
menu_xray
}

del-vmess() {
clear
rm -rf /root/usr_tmp.txt
(grep -E "^### " "/usr/local/etc/xray/vmess.json") | sort | uniq > usr_tmp.txt
grep -E "^### " "/root/usr_tmp.txt" | sort | uniq
NUMBER_OF_CLIENTS=$(grep -c -E "^### " "/usr/local/etc/xray/vmess.json")
	if [[ ${NUMBER_OF_CLIENTS} == '0' ]]; then
	echo -e "\033[0;34m-------------------------------\033[0m"
	echo -e "\E[44;1;39m      Delete Vmess Account     \E[0m"
	echo -e "\033[0;34m-------------------------------\033[0m"
	echo ""
	echo "You have no existing clients!"
	echo ""
	echo -e "\033[0;34m-------------------------------\033[0m"
	rm -rf /root/usr_tmp.txt
	read -n 1 -s -r -p "Press any key to back on menu"
	menu_xray
	fi
	clear
	echo -e "\033[0;34m-------------------------------\033[0m"
	echo -e "\E[44;1;39m      Delete Vmess Account     \E[0m"
	echo -e "\033[0;34m-------------------------------\033[0m"
	echo "  User       Expired  " 
	echo -e "\033[0;34m-------------------------------\033[0m"
	grep -E "^### " "/root/usr_tmp.txt" | cut -d ' ' -f 2-3 | sort | uniq | nl -s ') '
	echo ""
	until [[ ${CLIENT_NUMBER} -ge 1 && ${CLIENT_NUMBER} -le ${NUMBER_OF_CLIENTS} ]]; do
		if [[ ${CLIENT_NUMBER} == '1' ]]; then
			echo -e "\033[0;34m-------------------------------\033[0m"
			read -rp "Select one client [1]: " CLIENT_NUMBER
		else
			echo -e "\033[0;34m-------------------------------\033[0m"
			read -rp "Select one client [1-${NUMBER_OF_CLIENTS}]: " CLIENT_NUMBER
		fi
	done
    user=$(grep -E "^### " "/root/usr_tmp.txt" | cut -d ' ' -f 2 | awk '{print $1}' |sed -n "${CLIENT_NUMBER}"p)
    hariini=$(date +%Y-%m-%d)
    exp=$(grep -wE "^### $user" "/root/usr_tmp.txt" | cut -d ' ' -f 3 | sed -n "${CLIENT_NUMBER}"p)
    sed -i "/^### $user $exp/,/^},{/d" /usr/local/etc/xray/config.json
    sed -i "/^### $user $exp/,/^},{/d" /usr/local/etc/xray/config.json
    sed -i "/^### $user $exp/,/^},{/d" /usr/local/etc/xray/vmess.json
    sed -i "/^### $user $exp/,/^},{/d" /usr/local/etc/xray/trojan.json
    rm -rf /home/vps/public_html/${user}* > /dev/null 2>&1

    service cron restart > /dev/null 2>&1
    systemctl restart xray@vmess > /dev/null 2>&1

    clear
    echo -e "\033[0;34m-------------------------------\033[0m"
    echo -e "\E[44;1;39m      Delete Vmess Account     \E[0m"
    echo -e "\033[0;34m-------------------------------\033[0m"
    echo " Vmess Account Deleted Successfully"
    echo -e "\033[0;34m-------------------------------\033[0m"
    echo " Client Name : $user"
    echo " Deleted On  : $hariini"
    echo -e "\033[0;34m-------------------------------\033[0m"
    echo ""
    rm -rf /root/usr_tmp.txt
    read -n 1 -s -r -p "Press any key to back on menu" 
    menu
}

renew-vmess() {
clear
rm -rf /root/usr_tmp.txt
(grep -E "^### " "/usr/local/etc/xray/vmess.json") | sort | uniq > usr_tmp.txt
grep -E "^### " "/root/usr_tmp.txt" | sort | uniq
NUMBER_OF_CLIENTS=$(grep -c -E "^### " "/usr/local/etc/xray/vmess.json")
    if [[ ${NUMBER_OF_CLIENTS} == '0' ]]; then
    clear
    echo -e "\033[0;34m-------------------------------\033[0m"
    echo -e "\E[44;1;39m       Renew Vmess Account     \E[0m"
    echo -e "\033[0;34m-------------------------------\033[0m"
    echo ""
    echo "You have no existing clients!"
    echo ""
    echo -e "\033[0;34m-------------------------------\033[0m"
    rm -rf /root/usr_tmp.tx
    echo ""
    read -n 1 -s -r -p "Press any key to back on menu"
    menu_xray
    fi
    clear
    echo -e "\033[0;34m-------------------------------\033[0m"
    echo -e "\E[44;1;39m       Renew Vmess Account     \E[0m"
    echo -e "\033[0;34m-------------------------------\033[0m"
    echo ""
    grep -E "^### " "/root/usr_tmp.txt" | cut -d ' ' -f 2-3 | sort | uniq | nl -s ') '
	until [[ ${CLIENT_NUMBER} -ge 1 && ${CLIENT_NUMBER} -le ${NUMBER_OF_CLIENTS} ]]; do
		if [[ ${CLIENT_NUMBER} == '1' ]]; then
			echo -e "\033[0;34m-------------------------------\033[0m"
			read -rp "Select one client [1]: " CLIENT_NUMBER
		else
			echo -e "\033[0;34m-------------------------------\033[0m"
			read -rp "Select one client [1-${NUMBER_OF_CLIENTS}]: " CLIENT_NUMBER
		fi
	done
    echo -e "\033[0;34m-------------------------------\033[0m"
    read -p "Expired (days): " masaaktif
    user=$(grep -E "^### " "/root/usr_tmp.txt" | cut -d ' ' -f 2 | awk '{print $1}' |sed -n "${CLIENT_NUMBER}"p)
    exp=$(grep -wE "^### $user" "/usr/local/etc/xray/vmess.json" | cut -d ' ' -f 3 | sort | uniq)
    now=$(date +%Y-%m-%d)
    d1=$(date -d "$exp" +%s)
    d2=$(date -d "$now" +%s)
    exp2=$(( (d1 - d2) / 86400 ))
    exp3=$(($exp2 + $masaaktif))
    exp4=`date -d "$exp3 days" +"%Y-%m-%d"`
    sed -i "/### $user/c\### $user $exp4" /usr/local/etc/xray/vmess.json
    service cron restart > /dev/null 2>&1
    systemctl restart xray@vmess > /dev/null 2>&1

    clear
    echo -e "\033[0;34m-------------------------------\033[0m"
    echo -e "\E[44;1;39m       Renew Vmess Account     \E[0m"
    echo -e "\033[0;34m-------------------------------\033[0m"
    echo " VMESS Account Was Successfully Renewed"
    echo -e "\033[0;34m-------------------------------\033[0m"
    echo ""
    echo " Client Name : $user"
    echo " Expired On  : $exp4"
    echo ""
    echo -e "\033[0;34m-------------------------------\033[0m"
    echo ""
    rm -rf /root/usr_tmp.txt
    read -n 1 -s -r -p "Press any key to back on menu" 
    menu
}

recreate-vmess() {
rm -rf /root/user_tmp.txt
clear
source /var/lib/premium-script/ipvps.conf
if [[ "$IP" = "" ]]; then
domain=$(cat /etc/xray/domain)
else
domain=$IP
fi
domainn=$(cat /root/domain)
tls="$(cat ~/log-install.txt | grep -w "XRAY Vmess WS TLS" | cut -d: -f2|sed 's/ //g')"
none="$(cat ~/log-install.txt | grep -w "XRAY Vmess WS None TLS" | cut -d: -f2|sed 's/ //g')"
grep -E "^### " "/usr/local/etc/xray/vmess.json" | sort | uniq > /root/user_tmp.txt
NUMBER_OF_CLIENTS=$(grep -c -E "^### " "/root/user_tmp.txt" | sort | uniq)
	if [[ ${NUMBER_OF_CLIENTS} == '0' ]]; then
    echo -e "\033[0;34m-------------------------------\033[0m"
    echo -e "\E[44;1;39m    Recreate Vmess Account     \E[0m"
    echo -e "\033[0;34m-------------------------------\033[0m"
		echo ""
		echo "You have no existing clients!"
    echo ""
    echo -e "\033[0;34m-------------------------------\033[0m"    
		exit 1
	fi
	clear
    echo -e "\033[0;34m-------------------------------\033[0m"
    echo -e "\E[44;1;39m    Recreate Vmess Account     \E[0m"
    echo -e "\033[0;34m-------------------------------\033[0m"
	  echo "     No  User   Expired"
	grep -E "^### " "/root/user_tmp.txt" | cut -d ' ' -f 2-4 | sort | uniq | nl -s ') '
	until [[ ${CLIENT_NUMBER} -ge 1 && ${CLIENT_NUMBER} -le ${NUMBER_OF_CLIENTS} ]]; do
		if [[ ${CLIENT_NUMBER} == '1' ]]; then
			read -rp "Select one client [1]: " CLIENT_NUMBER
		else
			read -rp "Select one client [1-${NUMBER_OF_CLIENTS}]: " CLIENT_NUMBER
		fi
	done
add_data
user=$(grep -E "^### " "/root/user_tmp.txt" | cut -d ' ' -f 2 | sed -n "${CLIENT_NUMBER}"p)
exp=$(cat /root/user_tmp.txt | grep -w "$user" | awk '{print $3}')
hariini=$(date +%Y-%m-%d)
uuid=$(cat /usr/local/etc/xray/vmess.json | grep -w "$user" | grep "id" | cut -f 2 -d ':' | cut -f 2 -d '"' | sort | uniq)
asu=`cat<<EOF
      {
      "v": "2",
      "ps": "${user}",
      "add": "${wild}${domain}",
      "port": "443",
      "id": "${uuid}",
      "aid": "0",
      "net": "ws",
      "path": "/vmessws",
      "type": "none",
      "host": "${BUG}",
      "tls": "tls"
}
EOF`
ask=`cat<<EOF
      {
      "v": "2",
      "ps": "${user}",
      "add": "${wild}${domain}",
      "port": "80",
      "id": "${uuid}",
      "aid": "0",
      "net": "ws",
      "path": "/vmessws",
      "type": "none",
      "host": "${BUG}",
      "tls": "none"
}
EOF`

vmess_base641=$( base64 -w 0 <<< $vmess_json1)
vmess_base642=$( base64 -w 0 <<< $vmess_json2)

vmesslink1="vmess://$(echo $asu | base64 -w 0)"
vmesslink2="vmess://$(echo $ask | base64 -w 0)"

rm -rf /home/vps/public_html/${user}* > /dev/null 2>&1
vmess_yamltls
vmess_yamlntls
vmessyamltls=http://$MYIP:81/${user}_vmesstls.yaml
vmessyamlntls=http://$MYIP:81/${user}_vmessntls.yaml

service cron restart > /dev/null 2>&1
systemctl restart xray@vmess > /dev/null 2>&1

rm -rf /root/user_tmp.txt
clear
echo -e "\033[0;34m------------------------------------\033[0m"
echo -e "\E[44;1;39m        User Xray Vmess Account     \E[0m"
echo -e "\033[0;34m------------------------------------\033[0m"
echo -e "Remarks       : ${user}"
echo -e "IP Address    : ${MYIP}"
echo -e "Domain        : ${domain}"
echo -e "Port TLS      : ${tls}"
echo -e "Port none TLS : ${none}"
echo -e "id            : ${uuid}"
echo -e "\033[0;34m------------------------------------\033[0m"
echo -e "Link TLS :"
echo -e '```'
echo -e "${vmesslink1}"
echo -e '```'
echo -e "\033[0;34m------------------------------------\033[0m"
echo -e "Link none TLS :"
echo -e '```'
echo -e "${vmesslink2}"
echo -e '```'
echo -e "\033[0;34m------------------------------------\033[0m"
echo -e "Link Yaml TLS :"
echo -e ""
echo -e "${vmessyamltls}"
echo -e ""
echo -e "\033[0;34m------------------------------------\033[0m"
echo -e "Link Yaml none TLS :"
echo -e ""
echo -e "${vmessyamlntls}"
echo -e ""
echo -e "\033[0;34m------------------------------------\033[0m"
echo -e "Created On    : $hariini"
echo -e "Expired On    : $exp"
echo -e "\033[0;34m------------------------------------\033[0m"
echo ""
rm /etc/xray/$user-tls.json > /dev/null 2>&1
rm /etc/xray/$user-none.json > /dev/null 2>&1
read -n 1 -s -r -p "Press any key to back on menu"
menu
}

trial-vless() {
clear
xtls="$(cat ~/log-install.txt | grep -w "XRAY XTLS DIRECT" | cut -d: -f2|sed 's/ //g')"
tls="$(cat ~/log-install.txt | grep -w "XRAY Vless WS TLS" | cut -d: -f2|sed 's/ //g')"
none="$(cat ~/log-install.txt | grep -w "XRAY Vless WS None TLS" | cut -d: -f2|sed 's/ //g')"
source /var/lib/premium-script/ipvps.conf
if [[ "$IP" = "" ]]; then
domain=$(cat /etc/xray/domain)
else
domain=$IP
fi
domainn=$(cat /root/domain)

until [[ $user =~ ^[a-zA-Z0-9_]+$ && ${CLIENT_EXISTS} == '0' ]]; do
echo -e "\033[0;34m------------------------------------\033[0m"
echo -e "\E[44;1;39m       Trial Xray Vless Account     \E[0m"
echo -e "\033[0;34m------------------------------------\033[0m"
		user=VLESS`</dev/urandom tr -dc X-Z0-9 | head -c4`
		CLIENT_EXISTS=$(grep -w $user /usr/local/etc/xray/config.json | wc -l)

		if [[ ${CLIENT_EXISTS} == '1' ]]; then
clear
		echo -e "\033[0;34m------------------------------------\033[0m"
		echo -e "\E[44;1;39m       Trial Xray Vless Account     \E[0m"
		echo -e "\033[0;34m------------------------------------\033[0m"
			echo ""
			echo "A client with the specified name was already created, please choose another name."
			echo ""
			read -n 1 -s -r -p "Press any key to back on menu"
			menu_xray
		fi
	done
add_data
uuid=$(cat /proc/sys/kernel/random/uuid)
masaaktif=1
hariini=`date -d "0 days" +"%Y-%m-%d"`
exp=`date -d "$masaaktif days" +"%Y-%m-%d"`

#Input Json
sed -i '/#vless-xtls$/a\### '"$user $exp"'\
},{"id": "'""$uuid""'","flow": "xtls-rprx-direct","email": "'""$user""'"' /usr/local/etc/xray/config.json
sed -i '/#vless$/a\### '"$user $exp"'\
},{"id": "'""$uuid""'","email": "'""$user""'"' /usr/local/etc/xray/config.json
rm -rf /home/vps/public_html/${user}* > /dev/null 2>&1
vless_yamltls
vless_yamlntls
vlessyamltls=http://$MYIP:81/${user}_vlesstls.yaml
vlessyamlntls=http://$MYIP:81/${user}_vlessntls.yaml

#Link Configuration
vlesslink1="vless://${uuid}@${wild}${domain}:${xtls}?security=xtls&encryption=none&headerType=none&type=tcp&flow=xtls-rprx-direct&sni=${BUG}#$user"
vlesslink2="vless://${uuid}@${wild}${wild}${domain}:${xtls}?security=xtls&encryption=none&headerType=none&type=tcp&flow=xtls-rprx-splice&sni=${BUG}#$user"
vlesslink3="vless://${uuid}@${wild}${domain}:$tls?security=tls&encryption=none&type=tcp&sni=${BUG}#$user"
vlesslink4="vless://${uuid}@${wild}${domain}:$tls?path=/vlessws&security=tls&encryption=none&type=ws&sni=$BUG#$user"
vlesslink5="vless://${uuid}@${wild}${domain}:$none?path=/vlessws&encryption=none&type=ws&host=$BUG#$user"

#restart service
service cron restart > /dev/null 2>&1
systemctl restart xray > /dev/null 2>&1

multipath="$(systemctl show xray --no-page)"
multipathstat=$(echo "${multipath}" | grep 'Description=' | cut -f2 -d=)
if [[ $multipathstat == "Custom Xray-Vless_Multipath By VPN Legasi" ]]; then
    link_multipath
else
    link1
fi
}

add-vless() {
clear
xtls="$(cat ~/log-install.txt | grep -w "XRAY XTLS DIRECT" | cut -d: -f2|sed 's/ //g')"
tls="$(cat ~/log-install.txt | grep -w "XRAY Vless WS TLS" | cut -d: -f2|sed 's/ //g')"
none="$(cat ~/log-install.txt | grep -w "XRAY Vless WS None TLS" | cut -d: -f2|sed 's/ //g')"
source /var/lib/premium-script/ipvps.conf
if [[ "$IP" = "" ]]; then
domain=$(cat /etc/xray/domain)
else
domain=$IP
fi
domainn=$(cat /root/domain)

until [[ $user =~ ^[a-zA-Z0-9_]+$ && ${CLIENT_EXISTS} == '0' ]]; do
echo -e "\033[0;34m------------------------------------\033[0m"
echo -e "\E[44;1;39m        Add Xray Vless Account      \E[0m"
echo -e "\033[0;34m------------------------------------\033[0m"
		read -rp "User: " -e user
		CLIENT_EXISTS=$(grep -w $user /usr/local/etc/xray/config.json | wc -l)

		if [[ ${CLIENT_EXISTS} == '1' ]]; then
clear
		echo -e "\033[0;34m------------------------------------\033[0m"
		echo -e "\E[44;1;39m        Add Xray Vless Account      \E[0m"
		echo -e "\033[0;34m------------------------------------\033[0m"
			echo ""
			echo "A client with the specified name was already created, please choose another name."
			echo ""
			read -n 1 -s -r -p "Press any key to back on menu"
			menu_xray
		fi
	done
add_data
read -p "Expired (days): " masaaktif
uuid=$(cat /proc/sys/kernel/random/uuid)
hariini=`date -d "0 days" +"%Y-%m-%d"`
exp=`date -d "$masaaktif days" +"%Y-%m-%d"`

#Input Json
sed -i '/#vless-xtls$/a\### '"$user $exp"'\
},{"id": "'""$uuid""'","flow": "xtls-rprx-direct","email": "'""$user""'"' /usr/local/etc/xray/config.json
sed -i '/#vless$/a\### '"$user $exp"'\
},{"id": "'""$uuid""'","email": "'""$user""'"' /usr/local/etc/xray/config.json
rm -rf /home/vps/public_html/${user}* > /dev/null 2>&1
vless_yamltls
vless_yamlntls
vlessyamltls=http://$MYIP:81/${user}_vlesstls.yaml
vlessyamlntls=http://$MYIP:81/${user}_vlessntls.yaml

#Link Configuration
vlesslink1="vless://${uuid}@${wild}${domain}:${xtls}?security=xtls&encryption=none&headerType=none&type=tcp&flow=xtls-rprx-direct&sni=${BUG}#$user"
vlesslink2="vless://${uuid}@${wild}${wild}${domain}:${xtls}?security=xtls&encryption=none&headerType=none&type=tcp&flow=xtls-rprx-splice&sni=${BUG}#$user"
vlesslink3="vless://${uuid}@${wild}${domain}:$tls?security=tls&encryption=none&type=tcp&sni=${BUG}#$user"
vlesslink4="vless://${uuid}@${wild}${domain}:$tls?path=/vlessws&security=tls&encryption=none&type=ws&sni=$BUG#$user"
vlesslink5="vless://${uuid}@${wild}${domain}:$none?path=/vlessws&encryption=none&type=ws&host=$BUG#$user"

#restart service
service cron restart > /dev/null 2>&1
systemctl restart xray > /dev/null 2>&1

multipath="$(systemctl show xray --no-page)"
multipathstat=$(echo "${multipath}" | grep 'Description=' | cut -f2 -d=)
if [[ $multipathstat == "Custom Xray-Vless_Multipath By VPN Legasi" ]]; then
    link_multipath
else
    link1
fi
}

cek-vless() {
clear
#echo -n /var/log/xray/access.log
echo -n > /tmp/other.txt
data=( `cat /usr/local/etc/xray/config.json | grep '^###' | cut -d ' ' -f 2 | sort | uniq`);
echo -e "\033[0;34m-------------------------------\033[0m"
echo -e "\E[44;1;39m      XRAY Vless User Login    \E[0m"
echo -e "\033[0;34m-------------------------------\033[0m"
for akun in "${data[@]}"
do
if [[ -z "$akun" ]]; then
akun="tidakada"
fi

echo -n > /tmp/ipvmess.txt
data2=( `cat /var/log/xray/access.log | tail -n 500 | cut -d " " -f 3 | sed 's/tcp://g' | cut -d ":" -f 1 | sort | uniq`);
for ip in "${data2[@]}"
do

jum=$(cat /var/log/xray/access.log | grep -w "$akun" | tail -n 500 | cut -d " " -f 3 | sed 's/tcp://g' | cut -d ":" -f 1 | grep -w "$ip" | sort | uniq)
if [[ "$jum" = "$ip" ]]; then
echo "$jum" >> /tmp/ipvmess.txt
else
echo "$ip" >> /tmp/other.txt
fi
jum2=$(cat /tmp/ipvmess.txt)
sed -i "/$jum2/d" /tmp/other.txt > /dev/null 2>&1
done

jum=$(cat /tmp/ipvmess.txt)
if [[ -z "$jum" ]]; then
echo > /dev/null
else
jum2=$(cat /tmp/ipvmess.txt | nl)
echo "user : $akun";
echo "$jum2";
echo -e "\033[0;34m------------------------------------\033[0m"
fi
rm -rf /tmp/ipvmess.txt
done

rm -rf /tmp/other.txt
echo ""
read -n 1 -s -r -p "Press any key to back on menu"
menu_xray
}

del-vless() {
clear
rm -rf /root/usr_tmp.txt
(grep -E "^### " "/usr/local/etc/xray/config.json") | sort | uniq > usr_tmp.txt
NUMBER_OF_CLIENTS=$(grep -c -E "^### " "/root/usr_tmp.txt")
	if [[ ${NUMBER_OF_CLIENTS} == '0' ]]; then
	echo -e "\033[0;34m-------------------------------\033[0m"
	echo -e "\E[44;1;39m      Delete Vless Account     \E[0m"
	echo -e "\033[0;34m-------------------------------\033[0m"
	echo ""
	echo "You have no existing clients!"
	echo ""
	echo -e "\033[0;34m-------------------------------\033[0m"
	rm -rf /root/usr_tmp.txt
	read -n 1 -s -r -p "Press any key to back on menu"
	menu_xray
	fi
	clear
	echo -e "\033[0;34m-------------------------------\033[0m"
	echo -e "\E[44;1;39m      Delete Vless Account     \E[0m"
	echo -e "\033[0;34m-------------------------------\033[0m"
	echo "  User       Expired  " 
	echo -e "\033[0;34m-------------------------------\033[0m"
	grep -E "^### " "/root/usr_tmp.txt" | cut -d ' ' -f 2-3 | sort | uniq | nl -s ') '
	echo ""
	until [[ ${CLIENT_NUMBER} -ge 1 && ${CLIENT_NUMBER} -le ${NUMBER_OF_CLIENTS} ]]; do
		if [[ ${CLIENT_NUMBER} == '1' ]]; then
			echo -e "\033[0;34m-------------------------------\033[0m"
			read -rp "Select one client [1]: " CLIENT_NUMBER
		else
			echo -e "\033[0;34m-------------------------------\033[0m"
			read -rp "Select one client [1-${NUMBER_OF_CLIENTS}]: " CLIENT_NUMBER
		fi
	done
    user=$(grep -E "^### " "/root/usr_tmp.txt" | cut -d ' ' -f 2 | awk '{print $1}' |sed -n "${CLIENT_NUMBER}"p)
    exp=$(grep -wE "^### $user" "/root/usr_tmp.txt" | cut -d ' ' -f 3 | sed -n "${CLIENT_NUMBER}"p)
    hariini=$(date +%Y-%m-%d)
    sed -i "/^### $user $exp/,/^},{/d" /usr/local/etc/xray/config.json
    rm -rf /home/vps/public_html/${user}* > /dev/null 2>&1

    service cron restart > /dev/null 2>&1
    systemctl restart xray > /dev/null 2>&1

    clear
    echo -e "\033[0;34m-------------------------------\033[0m"
    echo -e "\E[44;1;39m      Delete Vless Account     \E[0m"
    echo -e "\033[0;34m-------------------------------\033[0m"
    echo " Vless Account Deleted Successfully"
    echo -e "\033[0;34m-------------------------------\033[0m"
    echo " Client Name : $user"
    echo " Deleted On  : $hariini"
    echo -e "\033[0;34m-------------------------------\033[0m"
    echo ""
    rm -rf /root/usr_tmp.txt
    read -n 1 -s -r -p "Press any key to back on menu" 
    menu
}

renew-vless() {
clear
rm -rf /root/usr_tmp.txt
(grep -E "^### " "/usr/local/etc/xray/config.json") | sort | uniq > usr_tmp.txt
NUMBER_OF_CLIENTS=$(grep -c -E "^### " "/root/usr_tmp.txt")
    if [[ ${NUMBER_OF_CLIENTS} == '0' ]]; then
    clear
    echo -e "\033[0;34m-------------------------------\033[0m"
    echo -e "\E[44;1;39m       Renew Vless Account     \E[0m"
    echo -e "\033[0;34m-------------------------------\033[0m"
    echo ""
    echo "You have no existing clients!"
    echo ""
    echo -e "\033[0;34m-------------------------------\033[0m"
    rm -rf /root/usr_tmp.tx
    echo ""
    read -n 1 -s -r -p "Press any key to back on menu"
    menu_xray
    fi
    clear
    echo -e "\033[0;34m-------------------------------\033[0m"
    echo -e "\E[44;1;39m       Renew Vless Account     \E[0m"
    echo -e "\033[0;34m-------------------------------\033[0m"
    echo ""
    grep -E "^### " "/root/usr_tmp.txt" | cut -d ' ' -f 2-3 | sort | uniq | nl -s ') '
	until [[ ${CLIENT_NUMBER} -ge 1 && ${CLIENT_NUMBER} -le ${NUMBER_OF_CLIENTS} ]]; do
		if [[ ${CLIENT_NUMBER} == '1' ]]; then
			echo -e "\033[0;34m-------------------------------\033[0m"
			read -rp "Select one client [1]: " CLIENT_NUMBER
		else
			echo -e "\033[0;34m-------------------------------\033[0m"
			read -rp "Select one client [1-${NUMBER_OF_CLIENTS}]: " CLIENT_NUMBER
		fi
	done
    echo -e "\033[0;34m-------------------------------\033[0m"
    read -p "Expired (days): " masaaktif
    user=$(grep -E "^### " "/root/usr_tmp.txt" | cut -d ' ' -f 2 | awk '{print $1}' |sed -n "${CLIENT_NUMBER}"p)
    exp=$(grep -wE "^### $user" "/usr/local/etc/xray/config.json" | cut -d ' ' -f 3 | sort | uniq)
    now=$(date +%Y-%m-%d)
    d1=$(date -d "$exp" +%s)
    d2=$(date -d "$now" +%s)
    exp2=$(( (d1 - d2) / 86400 ))
    exp3=$(($exp2 + $masaaktif))
    exp4=`date -d "$exp3 days" +"%Y-%m-%d"`
    sed -i "/### $user/c\### $user $exp4" /usr/local/etc/xray/config.json
    
    service cron restart > /dev/null 2>&1
    systemctl restart xray > /dev/null 2>&1

    clear
    echo -e "\033[0;34m-------------------------------\033[0m"
    echo -e "\E[44;1;39m       Renew Vless Account     \E[0m"
    echo -e "\033[0;34m-------------------------------\033[0m"
    echo " VLESS Account Was Successfully Renewed"
    echo -e "\033[0;34m-------------------------------\033[0m"
    echo ""
    echo " Client Name : $user"
    echo " Expired On  : $exp4"
    echo ""
    echo -e "\033[0;34m-------------------------------\033[0m"
    echo ""
    rm -rf /root/usr_tmp.txt
    read -n 1 -s -r -p "Press any key to back on menu" 
    menu
}

recreate-vless() {
clear
xtls="$(cat ~/log-install.txt | grep -w "XRAY XTLS DIRECT" | cut -d: -f2|sed 's/ //g')"
tls="$(cat ~/log-install.txt | grep -w "XRAY Vless WS TLS" | cut -d: -f2|sed 's/ //g')"
none="$(cat ~/log-install.txt | grep -w "XRAY Vless WS None TLS" | cut -d: -f2|sed 's/ //g')"
source /var/lib/premium-script/ipvps.conf
if [[ "$IP" = "" ]]; then
domain=$(cat /etc/xray/domain)
else
domain=$IP
fi
domainn=$(cat /root/domain)

grep -E "^### " "/usr/local/etc/xray/config.json" | sort | uniq > /root/user_tmp.txt
NUMBER_OF_CLIENTS=$(grep -c -E "^### " "/root/user_tmp.txt" | sort | uniq)
	if [[ ${NUMBER_OF_CLIENTS} == '0' ]]; then
    echo -e "\033[0;34m-------------------------------\033[0m"
    echo -e "\E[44;1;39m    Recreate Vless Account     \E[0m"
    echo -e "\033[0;34m-------------------------------\033[0m"
		echo ""
		echo "You have no existing clients!"
    echo ""
    echo -e "\033[0;34m-------------------------------\033[0m"    
		exit 1
	fi
	clear
    echo -e "\033[0;34m-------------------------------\033[0m"
    echo -e "\E[44;1;39m    Recreate Vless Account     \E[0m"
    echo -e "\033[0;34m-------------------------------\033[0m"
	  echo "     No  User   Expired"
	grep -E "^### " "/root/user_tmp.txt" | cut -d ' ' -f 2-4 | sort | uniq | nl -s ') '
	until [[ ${CLIENT_NUMBER} -ge 1 && ${CLIENT_NUMBER} -le ${NUMBER_OF_CLIENTS} ]]; do
		if [[ ${CLIENT_NUMBER} == '1' ]]; then
			read -rp "Select one client [1]: " CLIENT_NUMBER
		else
			read -rp "Select one client [1-${NUMBER_OF_CLIENTS}]: " CLIENT_NUMBER
		fi
	done
add_data
user=$(grep -E "^### " "/root/user_tmp.txt" | cut -d ' ' -f 2 | sed -n "${CLIENT_NUMBER}"p)
exp=$(cat /root/user_tmp.txt | grep -w "$user" | awk '{print $3}')
uuid=$(cat /usr/local/etc/xray/config.json | grep -w "$user" | grep "id" | cut -f 2 -d ':' | cut -f 2 -d '"' | sort | uniq)
hariini=$(date +%Y-%m-%d)

rm -rf  /root/user_tmp.txt
vless_yamltls
vless_yamlntls
vlessyamltls=http://$MYIP:81/${user}_vlesstls.yaml
vlessyamlntls=http://$MYIP:81/${user}_vlessntls.yaml

#Link Configuration
vlesslink1="vless://${uuid}@${wild}${domain}:${xtls}?security=xtls&encryption=none&headerType=none&type=tcp&flow=xtls-rprx-direct&sni=${BUG}#$user"
vlesslink2="vless://${uuid}@${wild}${wild}${domain}:${xtls}?security=xtls&encryption=none&headerType=none&type=tcp&flow=xtls-rprx-splice&sni=${BUG}#$user"
vlesslink3="vless://${uuid}@${wild}${domain}:$tls?security=tls&encryption=none&type=tcp&sni=${BUG}#$user"
vlesslink4="vless://${uuid}@${wild}${domain}:$tls?path=/vlessws&security=tls&encryption=none&type=ws&sni=$BUG#$user"
vlesslink5="vless://${uuid}@${wild}${domain}:$none?path=/vlessws&encryption=none&type=ws&host=$BUG#$user"

#restart service
service cron restart > /dev/null 2>&1
systemctl restart xray > /dev/null 2>&1

multipath="$(systemctl show xray --no-page)"
multipathstat=$(echo "${multipath}" | grep 'Description=' | cut -f2 -d=)
if [[ $multipathstat == "Custom Xray-Vless_Multipath By VPN Legasi" ]]; then
    link_multipath
else
    link1
fi
}

trial-trojan() {
clear
tcp="$(cat ~/log-install.txt | grep -w "XRAY Trojan TCP" | cut -d: -f2|sed 's/ //g')"
tls="$(cat ~/log-install.txt | grep -w "XRAY Trojan WS TLS" | cut -d: -f2|sed 's/ //g')"
none="$(cat ~/log-install.txt | grep -w "XRAY Trojan WS None TLS" | cut -d: -f2|sed 's/ //g')"
source /var/lib/premium-script/ipvps.conf
if [[ "$IP" = "" ]]; then
domain=$(cat /etc/xray/domain)
else
domain=$IP
fi
domainn=$(cat /root/domain)

until [[ $user =~ ^[a-zA-Z0-9_]+$ && ${user_EXISTS} == '0' ]]; do
echo -e "\033[0;34m------------------------------------\033[0m"
echo -e "\E[44;1;39m      Trial Xray Trojan Account     \E[0m"
echo -e "\033[0;34m------------------------------------\033[0m"
user=TROJAN`</dev/urandom tr -dc X-Z0-9 | head -c4`
user_EXISTS=$(grep -w $user /usr/local/etc/xray/trojan.json | wc -l)
  if [[ ${user_EXISTS} == '1' ]]; then
  clear
  echo -e "\033[0;34m------------------------------------\033[0m"
  echo -e "\E[44;1;39m      Trial Xray Trojan Account     \E[0m"
  echo -e "\033[0;34m------------------------------------\033[0m"
  echo ""
  echo "A client with the specified name was already created, please choose another name."
  echo ""
  echo -e "\033[0;34m------------------------------------\033[0m"
  read -n 1 -s -r -p "Press any key to back on menu"
  trojan-menu
  fi
done
add_data
uuid=$(cat /proc/sys/kernel/random/uuid)
masaaktif=1
hariini=`date -d "0 days" +"%Y-%m-%d"`
exp=`date -d "$masaaktif days" +"%Y-%m-%d"`

#input json
sed -i '/#trojan$/a\### '"$user $exp"'\
},{"password": "'""$uuid""'","email": "'""$user""'"' /usr/local/etc/xray/trojan.json
rm -rf /home/vps/public_html/${user}* > /dev/null 2>&1
trojan_yamltls
trojan_yamlntls
trojanyamltls=http://$MYIP:81/${user}_trojantls.yaml
trojanyamlntls=http://$MYIP:81/${user}_trojanntls.yaml

#Restart Service
service cron restart > /dev/null 2>&1
systemctl restart xray@trojan > /dev/null 2>&1

#Link Configuration
trojanlink="trojan://${uuid}@$wild${domain}:${tcp}?security=tls&type=tcp&sni=$BUG#${user}"
trojanlink1="trojan://${uuid}@$wild${domain}:${tcp}?security=tls&type=tcp&sni=$BUG&flow=xtls-rprx-splice#${user}"
trojanlink2="trojan://${uuid}@$wild${domain}:${tls}?security=tls&type=ws&headerType=none&path=/trojan-ws&sni=$BUG&host=$BUG#${user}"
trojanlink3="trojan://${uuid}@$wild${domain}:${none}?security=none&type=ws&headerType=none&path=/trojan-ws&host=$BUG#${user}"

clear
echo -e "\033[0;34m------------------------------------\033[0m"
echo -e "\E[44;1;39m      Trial Xray Trojan Account     \E[0m"
echo -e "\033[0;34m------------------------------------\033[0m"
echo -e "Remarks          : ${user}"
echo -e "IP Address       : ${MYIP}"
echo -e "Domain           : ${domainn}"
echo -e "Port TCP         : ${tcp}"
echo -e "Port WS TLS      : ${tls}"
echo -e "Port WS none TLS : ${none}"
echo -e "id               : ${uuid}"
echo -e "\033[0;34m------------------------------------\033[0m"
echo -e "Link TCP :"
echo -e '```'
echo -e "${trojanlink}"
echo -e '```'
echo -e "\033[0;34m------------------------------------\033[0m"
echo -e "Link TCP FLOW XTLS :"
echo -e '```'
echo -e "${trojanlink1}"
echo -e '```'
echo -e "\033[0;34m------------------------------------\033[0m"
echo -e "Link WS TLS :"
echo -e '```'
echo -e "${trojanlink2}"
echo -e '```'
echo -e "\033[0;34m------------------------------------\033[0m"
echo -e "Link WS None TLS :"
echo -e '```'
echo -e "${trojanlink3}"
echo -e '```'
echo -e "\033[0;34m------------------------------------\033[0m"
echo -e "Link Yaml TLS :"
echo -e ""
echo -e "${trojanyamltls}"
echo -e ""
echo -e "\033[0;34m------------------------------------\033[0m"
echo -e "Link Yaml none TLS :"
echo -e ""
echo -e "${trojanyamlntls}"
echo -e ""
echo -e "\033[0;34m------------------------------------\033[0m"
echo -e "Created On       : $hariini"
echo -e "Expired On       : $exp"
echo -e "\033[0;34m------------------------------------\033[0m"
echo ""
read -n 1 -s -r -p "Press any key to back on menu"
menu
}

add-trojan() {
clear
tcp="$(cat ~/log-install.txt | grep -w "XRAY Trojan TCP" | cut -d: -f2|sed 's/ //g')"
tls="$(cat ~/log-install.txt | grep -w "XRAY Trojan WS TLS" | cut -d: -f2|sed 's/ //g')"
none="$(cat ~/log-install.txt | grep -w "XRAY Trojan WS None TLS" | cut -d: -f2|sed 's/ //g')"
source /var/lib/premium-script/ipvps.conf
if [[ "$IP" = "" ]]; then
domain=$(cat /etc/xray/domain)
else
domain=$IP
fi
domainn=$(cat /root/domain)

until [[ $user =~ ^[a-zA-Z0-9_]+$ && ${user_EXISTS} == '0' ]]; do
echo -e "\033[0;34m------------------------------------\033[0m"
echo -e "\E[44;1;39m       ADD Xray Trojan Account      \E[0m"
echo -e "\033[0;34m------------------------------------\033[0m"
		read -rp "User: " -e user
		user_EXISTS=$(grep -w $user /usr/local/etc/xray/trojan.json | wc -l)

		if [[ ${user_EXISTS} == '1' ]]; then
clear
		echo -e "\033[0;34m------------------------------------\033[0m"
		echo -e "\E[44;1;39m       ADD Xray Trojan Account      \E[0m"
		echo -e "\033[0;34m------------------------------------\033[0m"
			echo ""
			echo "A client with the specified name was already created, please choose another name."
			echo ""
			echo -e "\033[0;34m-------------------------------\033[0m"
			read -n 1 -s -r -p "Press any key to back on menu"
			trojan-menu
		fi
	done
add_data
uuid=$(cat /proc/sys/kernel/random/uuid)
read -p "Expired (days): " masaaktif
hariini=`date -d "0 days" +"%Y-%m-%d"`
exp=`date -d "$masaaktif days" +"%Y-%m-%d"`
#input json
sed -i '/#trojan$/a\### '"$user $exp"'\
},{"password": "'""$uuid""'","email": "'""$user""'"' /usr/local/etc/xray/trojan.json
rm -rf /home/vps/public_html/${user}* > /dev/null 2>&1
trojan_yamltls
trojan_yamlntls
trojanyamltls=http://$MYIP:81/${user}_trojantls.yaml
trojanyamlntls=http://$MYIP:81/${user}_trojanntls.yaml

#Link Configuration
trojanlink="trojan://${uuid}@$wild${domain}:${tcp}?security=tls&type=tcp&sni=$BUG#${user}"
trojanlink1="trojan://${uuid}@$wild${domain}:${tcp}?security=tls&type=tcp&sni=$BUG&flow=xtls-rprx-splice#${user}"
trojanlink2="trojan://${uuid}@$wild${domain}:${tls}?security=tls&type=ws&headerType=none&path=/trojan-ws&sni=$BUG&host=$BUG#${user}"
trojanlink3="trojan://${uuid}@$wild${domain}:${none}?security=none&type=ws&headerType=none&path=/trojan-ws&host=$BUG#${user}"

#Restart Service
service cron restart > /dev/null 2>&1
systemctl restart xray@trojan > /dev/null 2>&1

clear
echo -e "\033[0;34m------------------------------------\033[0m"
echo -e "\E[44;1;39m       User Xray Trojan Account     \E[0m"
echo -e "\033[0;34m------------------------------------\033[0m"
echo -e "Remarks          : ${user}"
echo -e "IP Address       : ${MYIP}"
echo -e "Domain           : ${domainn}"
echo -e "Port TCP         : ${tcp}"
echo -e "Port WS TLS      : ${tls}"
echo -e "Port WS none TLS : ${none}"
echo -e "id               : ${uuid}"
echo -e "\033[0;34m------------------------------------\033[0m"
echo -e "Link TCP :"
echo -e '```'
echo -e "${trojanlink}"
echo -e '```'
echo -e "\033[0;34m------------------------------------\033[0m"
echo -e "Link TCP FLOW XTLS :"
echo -e '```'
echo -e "${trojanlink1}"
echo -e '```'
echo -e "\033[0;34m------------------------------------\033[0m"
echo -e "Link WS TLS :"
echo -e '```'
echo -e "${trojanlink2}"
echo -e '```'
echo -e "\033[0;34m------------------------------------\033[0m"
echo -e "Link WS None TLS :"
echo -e '```'
echo -e "${trojanlink3}"
echo -e '```'
echo -e "\033[0;34m------------------------------------\033[0m"
echo -e "Link Yaml TLS :"
echo -e ""
echo -e "${trojanyamltls}"
echo -e ""
echo -e "\033[0;34m------------------------------------\033[0m"
echo -e "Link Yaml none TLS :"
echo -e ""
echo -e "${trojanyamlntls}"
echo -e ""
echo -e "\033[0;34m------------------------------------\033[0m"
echo -e "Created On       : $hariini"
echo -e "Expired On       : $exp"
echo -e "\033[0;34m------------------------------------\033[0m"
echo ""
read -n 1 -s -r -p "Press any key to back on menu"
menu
}

cek-trojan() {
clear
#echo -n /var/log/xray/access1.log
echo -n > /tmp/other.txt
data=( `cat /usr/local/etc/xray/trojan.json | grep '^###' | cut -d ' ' -f 2 | sort | uniq`);
echo -e "\033[0;34m-------------------------------\033[0m"
echo -e "\E[44;1;39m     XRAY Trojan User Login    \E[0m"
echo -e "\033[0;34m-------------------------------\033[0m"
for akun in "${data[@]}"
do
if [[ -z "$akun" ]]; then
akun="tidakada"
fi

echo -n > /tmp/ipvmess.txt
data2=( `cat /var/log/xray/access1.log | tail -n 500 | cut -d " " -f 3 | sed 's/tcp://g' | cut -d ":" -f 1 | sort | uniq`);
for ip in "${data2[@]}"
do

jum=$(cat /var/log/xray/access1.log | grep -w "$akun" | tail -n 500 | cut -d " " -f 3 | sed 's/tcp://g' | cut -d ":" -f 1 | grep -w "$ip" | sort | uniq)
if [[ "$jum" = "$ip" ]]; then
echo "$jum" >> /tmp/ipvmess.txt
else
echo "$ip" >> /tmp/other.txt
fi
jum2=$(cat /tmp/ipvmess.txt)
sed -i "/$jum2/d" /tmp/other.txt > /dev/null 2>&1
done

jum=$(cat /tmp/ipvmess.txt)
if [[ -z "$jum" ]]; then
echo > /dev/null
else
jum2=$(cat /tmp/ipvmess.txt | nl)
echo "user : $akun";
echo "$jum2";
echo -e "\033[0;34m-------------------------------\033[0m"
fi
rm -rf /tmp/ipvmess.txt
done

rm -rf /tmp/other.txt
echo ""
read -n 1 -s -r -p "Press any key to back on menu"
menu_xray
}

del-trojan() {
clear
rm -rf /root/usr_tmp.txt
(grep -E "^### " "/usr/local/etc/xray/trojan.json") | sort | uniq > usr_tmp.txt
NUMBER_OF_CLIENTS=$(grep -c -E "^### " "/root/usr_tmp.txt")
	if [[ ${NUMBER_OF_CLIENTS} == '0' ]]; then
	echo -e "\033[0;34m-------------------------------\033[0m"
	echo -e "\E[44;1;39m     Delete Trojan Account     \E[0m"
	echo -e "\033[0;34m-------------------------------\033[0m"
	echo ""
	echo "You have no existing clients!"
	echo ""
	echo -e "\033[0;34m-------------------------------\033[0m"
	rm -rf /root/usr_tmp.txt
	read -n 1 -s -r -p "Press any key to back on menu"
	menu_xray
	fi
	clear
	echo -e "\033[0;34m-------------------------------\033[0m"
	echo -e "\E[44;1;39m     Delete Trojan Account     \E[0m"
	echo -e "\033[0;34m-------------------------------\033[0m"
	echo "  User       Expired  " 
	echo -e "\033[0;34m-------------------------------\033[0m"
	grep -E "^### " "/root/usr_tmp.txt" | cut -d ' ' -f 2-3 | sort | uniq | nl -s ') '
	echo ""
	until [[ ${CLIENT_NUMBER} -ge 1 && ${CLIENT_NUMBER} -le ${NUMBER_OF_CLIENTS} ]]; do
		if [[ ${CLIENT_NUMBER} == '1' ]]; then
			echo -e "\033[0;34m-------------------------------\033[0m"
			read -rp "Select one client [1]: " CLIENT_NUMBER
		else
			echo -e "\033[0;34m-------------------------------\033[0m"
			read -rp "Select one client [1-${NUMBER_OF_CLIENTS}]: " CLIENT_NUMBER
		fi
	done
    user=$(grep -E "^### " "/root/usr_tmp.txt" | cut -d ' ' -f 2 | awk '{print $1}' |sed -n "${CLIENT_NUMBER}"p)
    exp=$(grep -wE "^### $user" "/root/usr_tmp.txt" | cut -d ' ' -f 3 | sed -n "${CLIENT_NUMBER}"p)
    hariini=$(date +%Y-%m-%d)
    sed -i "/^### $user $exp/,/^},{/d" /usr/local/etc/xray/trojan.json
    rm -rf /home/vps/public_html/${user}* > /dev/null 2>&1

    #Restart Service
    service cron restart > /dev/null 2>&1
    systemctl restart xray@trojan > /dev/null 2>&1
    rm -rf /root/usr_tmp.txt
    
    clear
    echo -e "\033[0;34m-------------------------------\033[0m"
    echo -e "\E[44;1;39m     Delete Trojan Account     \E[0m"
    echo -e "\033[0;34m-------------------------------\033[0m"
    echo " Trojan Account Deleted Successfully"
    echo -e "\033[0;34m-------------------------------\033[0m"
    echo " Client Name : $user"
    echo " Deleted On  : $hariini"
    echo -e "\033[0;34m-------------------------------\033[0m"
    echo ""
    read -n 1 -s -r -p "Press any key to back on menu" 
    menu
}

renew-trojan() {
clear
rm -rf /root/usr_tmp.txt
(grep -E "^### " "/usr/local/etc/xray/trojan.json") | sort | uniq > usr_tmp.txt
NUMBER_OF_CLIENTS=$(grep -c -E "^### " "/root/usr_tmp.txt")
    if [[ ${NUMBER_OF_CLIENTS} == '0' ]]; then
    clear
    echo -e "\033[0;34m-------------------------------\033[0m"
    echo -e "\E[44;1;39m      Renew Trojan Account     \E[0m"
    echo -e "\033[0;34m-------------------------------\033[0m"
    echo ""
    echo "You have no existing clients!"
    echo ""
    echo -e "\033[0;34m-------------------------------\033[0m"
    rm -rf /root/usr_tmp.tx
    echo ""
    read -n 1 -s -r -p "Press any key to back on menu"
    menu_xray
    fi
    clear
    echo -e "\033[0;34m-------------------------------\033[0m"
    echo -e "\E[44;1;39m      Renew Trojan Account     \E[0m"
    echo -e "\033[0;34m-------------------------------\033[0m"
    echo ""
    grep -E "^### " "/root/usr_tmp.txt" | cut -d ' ' -f 2-3 | sort | uniq | nl -s ') '
	until [[ ${CLIENT_NUMBER} -ge 1 && ${CLIENT_NUMBER} -le ${NUMBER_OF_CLIENTS} ]]; do
		if [[ ${CLIENT_NUMBER} == '1' ]]; then
			echo -e "\033[0;34m-------------------------------\033[0m"
			read -rp "Select one client [1]: " CLIENT_NUMBER
		else
			echo -e "\033[0;34m-------------------------------\033[0m"
			read -rp "Select one client [1-${NUMBER_OF_CLIENTS}]: " CLIENT_NUMBER
		fi
	done
    echo -e "\033[0;34m-------------------------------\033[0m"
    read -p "Expired (days): " masaaktif
    user=$(grep -E "^### " "/root/usr_tmp.txt" | cut -d ' ' -f 2 | awk '{print $1}' |sed -n "${CLIENT_NUMBER}"p)
    exp=$(grep -wE "^### $user" "/usr/local/etc/xray/trojan.json" | cut -d ' ' -f 3 | sort | uniq)
    now=$(date +%Y-%m-%d)
    d1=$(date -d "$exp" +%s)
    d2=$(date -d "$now" +%s)
    exp2=$(( (d1 - d2) / 86400 ))
    exp3=$(($exp2 + $masaaktif))
    exp4=`date -d "$exp3 days" +"%Y-%m-%d"`
    sed -i "/### $user/c\### $user $exp4" /usr/local/etc/xray/trojan.json
    
    #Restart Service
    service cron restart > /dev/null 2>&1
    systemctl restart xray@trojan > /dev/null 2>&1

    clear
    echo -e "\033[0;34m-------------------------------\033[0m"
    echo -e "\E[44;1;39m      Renew Trojan Account     \E[0m"
    echo -e "\033[0;34m-------------------------------\033[0m"
    echo " Trojan Account Was Successfully Renewed"
    echo -e "\033[0;34m-------------------------------\033[0m"
    echo ""
    echo " Client Name : $user"
    echo " Expired On  : $exp4"
    echo ""
    echo -e "\033[0;34m-------------------------------\033[0m"
    echo ""
    rm -rf /root/usr_tmp.txt
    read -n 1 -s -r -p "Press any key to back on menu" 
    menu
}

recreate-trojan() {
clear
tcp="$(cat ~/log-install.txt | grep -w "XRAY Trojan TCP" | cut -d: -f2|sed 's/ //g')"
tls="$(cat ~/log-install.txt | grep -w "XRAY Trojan WS TLS" | cut -d: -f2|sed 's/ //g')"
none="$(cat ~/log-install.txt | grep -w "XRAY Trojan WS None TLS" | cut -d: -f2|sed 's/ //g')"
source /var/lib/premium-script/ipvps.conf
if [[ "$IP" = "" ]]; then
domain=$(cat /etc/xray/domain)
else
domain=$IP
fi
domainn=$(cat /root/domain)

grep -E "^### " "/usr/local/etc/xray/trojan.json" | sort | uniq > /root/user_tmp.txt
NUMBER_OF_CLIENTS=$(grep -c -E "^### " "/root/user_tmp.txt")
	if [[ ${NUMBER_OF_CLIENTS} == '0' ]]; then
    clear
    echo -e "\033[0;34m-------------------------------\033[0m"
    echo -e "\E[44;1;39m     Select Trojan Account     \E[0m"
    echo -e "\033[0;34m-------------------------------\033[0m"
		echo ""
		echo "You have no existing clients!"
    echo ""
    echo -e "\033[0;34m-------------------------------\033[0m"
		exit 1
	fi
	  clear
    echo -e "\033[0;34m-------------------------------\033[0m"
    echo -e "\E[44;1;39m     Select Trojan Account     \E[0m"
    echo -e "\033[0;34m-------------------------------\033[0m"
	  echo "     No  User   Expired"
	grep -E "^### " "/root/user_tmp.txt" | cut -d ' ' -f 2-4 | sort | uniq | nl -s ') '
	until [[ ${CLIENT_NUMBER} -ge 1 && ${CLIENT_NUMBER} -le ${NUMBER_OF_CLIENTS} ]]; do
		if [[ ${CLIENT_NUMBER} == '1' ]]; then
			read -rp "Select one client [1]: " CLIENT_NUMBER
		else
			read -rp "Select one client [1-${NUMBER_OF_CLIENTS}]: " CLIENT_NUMBER
		fi
	done
add_data
user=$(grep -E "^### " "/root/user_tmp.txt" | cut -d ' ' -f 2 | sed -n "${CLIENT_NUMBER}"p)
exp=$(cat /root/user_tmp.txt | grep -w "$user" | awk '{print $3}')
uuid=$(cat /usr/local/etc/xray/trojan.json | grep -w "$user" | grep "password" | cut -f 2 -d ':' | cut -f 2 -d '"' | sort | uniq)
hariini=$(date +%Y-%m-%d)
rm -rf /home/vps/public_html/${user}* > /dev/null 2>&1
trojan_yamltls
trojan_yamlntls
trojanyamltls=http://$MYIP:81/${user}_trojantls.yaml
trojanyamlntls=http://$MYIP:81/${user}_trojanntls.yaml

#Link Configuration
trojanlink="trojan://${uuid}@${wild}${domain}:${tcp}?security=tls&type=tcp&sni=$BUG#${user}"
trojanlink1="trojan://${uuid}@${wild}${domain}:${tcp}?security=tls&type=tcp&sni=$BUG&flow=xtls-rprx-splice#${user}"
trojanlink2="trojan://${uuid}@${wild}${domain}:${tls}?security=tls&type=ws&headerType=none&path=/trojan-ws&sni=$BUG&host=$BUG#${user}"
trojanlink3="trojan://${uuid}@${wild}${domain}:${none}?security=none&type=ws&headerType=none&path=/trojan-ws&host=$BUG#${user}"

#Restart Service
service cron restart > /dev/null 2>&1
systemctl restart xray@trojan > /dev/null 2>&1

rm -rf /root/user_tmp.txt
clear
echo -e "\033[0;34m------------------------------------\033[0m"
echo -e "\E[44;1;39m       User Xray Trojan Account     \E[0m"
echo -e "\033[0;34m------------------------------------\033[0m"
echo -e "Remarks          : ${user}"
echo -e "IP Address       : ${MYIP}"
echo -e "Domain           : ${domainn}"
echo -e "Port TCP         : ${tcp}"
echo -e "Port WS TLS      : ${tls}"
echo -e "Port WS none TLS : ${none}"
echo -e "id               : ${uuid}"
echo -e "\033[0;34m------------------------------------\033[0m"
echo -e "Link TCP :"
echo -e '```'
echo -e "${trojanlink}"
echo -e '```'
echo -e "\033[0;34m------------------------------------\033[0m"
echo -e "Link TCP FLOW XTLS :"
echo -e '```'
echo -e "${trojanlink1}"
echo -e '```'
echo -e "\033[0;34m------------------------------------\033[0m"
echo -e "Link WS TLS :"
echo -e '```'
echo -e "${trojanlink2}"
echo -e '```'
echo -e "\033[0;34m------------------------------------\033[0m"
echo -e "Link WS None TLS :"
echo -e '```'
echo -e "${trojanlink3}"
echo -e '```'
echo -e "\033[0;34m------------------------------------\033[0m"
echo -e "Link Yaml TLS :"
echo -e ""
echo -e "${trojanyamltls}"
echo -e ""
echo -e "\033[0;34m------------------------------------\033[0m"
echo -e "Link Yaml none TLS :"
echo -e ""
echo -e "${trojanyamlntls}"
echo -e ""
echo -e "\033[0;34m------------------------------------\033[0m"
echo -e "Recreate On   : $hariini"
echo -e "Expired On    : $exp"
echo -e "\033[0;34m------------------------------------\033[0m"
echo ""
read -n 1 -s -r -p "Press any key to back on menu"
menu
}

check_port() {
echo -e "\033[0;34m------------------------------------------------------------\033[0m"
echo -e "\E[44;1;39m                        INFO SCRIPTS INSTALL                \E[0m"
echo -e "\033[0;34m------------------------------------------------------------\033[0m"
cat /root/log-install.txt
echo -e "\033[0;34m------------------------------------------------------------\033[0m"
read -n 1 -s -r -p "Press any key to back on menu"
menu
}

trial-shadowsocks() {
clear
tls="$(cat ~/log-install.txt | grep -w "XRAY Shadowsocks TLS" | cut -d: -f2|sed 's/ //g')"
none="$(cat ~/log-install.txt | grep -w "XRAY Shadowsocks None TLS" | cut -d: -f2|sed 's/ //g')"
source /var/lib/premium-script/ipvps.conf
if [[ "$IP" = "" ]]; then
domain=$(cat /etc/xray/domain)
else
domain=$IP
fi
domainn=$(cat /root/domain)

until [[ $user =~ ^[a-zA-Z0-9_]+$ && ${user_EXISTS} == '0' ]]; do
  echo -e "\033[0;34m------------------------------------\033[0m"
  echo -e "\E[44;1;39m    Trial Xray Shadowsocks Account  \E[0m"
  echo -e "\033[0;34m------------------------------------\033[0m"
  user=SHADOWSOCKS`</dev/urandom tr -dc X-Z0-9 | head -c4`
  user_EXISTS=$(grep -w $user /usr/local/etc/xray/shadowsocks.json | wc -l)
  if [[ ${user_EXISTS} == '1' ]]; then
  clear
  echo -e "\033[0;34m------------------------------------\033[0m"
  echo -e "\E[44;1;39m    Trial Xray Shadowsocks Account  \E[0m"
  echo -e "\033[0;34m------------------------------------\033[0m"
  echo ""
  echo "A client with the specified name was already created, please choose another name."
  echo ""
  echo -e "\033[0;34m------------------------------------\033[0m"
  read -n 1 -s -r -p "Press any key to back on menu"
  trojan-menu
  fi
done
add_data
masaaktif=1
cipher="aes-128-gcm"
uuid=$(cat /proc/sys/kernel/random/uuid)
hariini=`date -d "0 days" +"%Y-%m-%d"`
exp=`date -d "$masaaktif days" +"%Y-%m-%d"`
sed -i '/#shadowsocks$/a\### '"$user $exp"'\
},{"password": "'""$uuid""'","method": "'""$cipher""'","email": "'""$user""'"' /usr/local/etc/xray/shadowsocks.json
echo $cipher:$uuid > /tmp/log
shadowsocks_base64=$(cat /tmp/log)
echo -n "${shadowsocks_base64}" | base64 > /tmp/log1
shadowsocks_base64e=$(cat /tmp/log1)
shadowsockslink="ss://${shadowsocks_base64e}@$domain:$tls?plugin=obfs-local;mux=0;path=/shadowsocks;host=$domain;tls#${user}"
shadowsockslink1="ss://${shadowsocks_base64e}@$domain:$none?plugin=xray-plugin;mux=0;path=/shadowsocks;host=$domain;http#${user}"
rm -rf /home/vps/public_html/${user}*
rm -rf /tmp/log
rm -rf /tmp/log1
sodosok_ntls
sodosok_tls
link="http://${MYIP}:81/${user}-TLS"
link1="http://${MYIP}:81/${user}-NTLS"
service cron restart > /dev/null 2>&1
systemctl restart xray@shadowsocks > /dev/null 2>&1
clear
echo -e "\033[0;34m------------------------------------\033[0m"
echo -e "\E[44;1;39m    Trial Xray Shadowsocks Account  \E[0m"
echo -e "\033[0;34m------------------------------------\033[0m"
echo -e "Remarks       : ${user}"
echo -e "IP Address    : ${MYIP}"
echo -e "Domain        : ${domain}"
echo -e "Port None TLS : ${none}"
echo -e "Port TLS      : ${tls}"
echo -e "Password      : ${uuid}"
echo -e "Cipers        : aes-128-gcm"
echo -e "\033[0;34m------------------------------------\033[0m"
echo -e "Link TLS :"
echo -e ""
echo -e "${link}"
echo -e ""
echo -e "\033[0;34m------------------------------------\033[0m"
echo -e "Link none TLS :"
echo -e ""
echo -e "${link1}"
echo -e ""
echo -e "\033[0;34m------------------------------------\033[0m"
echo -e "Created On    : $hariini"
echo -e "Expired On    : $exp"
echo -e "\033[0;34m------------------------------------\033[0m"
echo ""
echo "DOWNLOAD FILE,OPEN WITH TEXT DOCUMENT,COPY & PASTE DI v2rayNG
Custom Config"
echo ""
echo -e "\033[0;34m------------------------------------\033[0m"
echo ""
read -n 1 -s -r -p "Press any key to back on menu"
menu
}

add-shadowsocks() {
clear
source /var/lib/premium-script/ipvps.conf
if [[ "$IP" = "" ]]; then
domain=$(cat /etc/xray/domain)
else
domain=$IP
fi
tls="$(cat ~/log-install.txt | grep -w "XRAY Shadowsocks TLS" | cut -d: -f2|sed 's/ //g')"
none="$(cat ~/log-install.txt | grep -w "XRAY Shadowsocks None TLS" | cut -d: -f2|sed 's/ //g')"
until [[ $user =~ ^[a-zA-Z0-9_]+$ && ${CLIENT_EXISTS} == '0' ]]; do
echo -e "\033[0;34m------------------------------------\033[0m"
echo -e "\E[44;1;39m         Add Shadowsocks Account    \E[0m"
echo -e "\033[0;34m------------------------------------\033[0m"
		read -rp "User: " -e user
		CLIENT_EXISTS=$(grep -w $user /usr/local/etc/xray/shadowsocks.json | wc -l)

		if [[ ${CLIENT_EXISTS} == '1' ]]; then
clear
		echo -e "\033[0;34m------------------------------------\033[0m"
		echo -e "\E[44;1;39m         Add Shadowsocks Account    \E[0m"
		echo -e "\033[0;34m------------------------------------\033[0m"
			echo ""
			echo "A client with the specified name was already created, please choose another name."
			echo ""
			echo -e "\033[0;34m------------------------------------\033[0m"
			read -n 1 -s -r -p "Press any key to back on menu"
			menu
		fi
	done
add_data
read -p "Expired (days): " masaaktif
cipher="aes-128-gcm"
uuid=$(cat /proc/sys/kernel/random/uuid)
hariini=`date -d "0 days" +"%Y-%m-%d"`
exp=`date -d "$masaaktif days" +"%Y-%m-%d"`
sed -i '/#shadowsocks$/a\### '"$user $exp"'\
},{"password": "'""$uuid""'","method": "'""$cipher""'","email": "'""$user""'"' /usr/local/etc/xray/shadowsocks.json
echo $cipher:$uuid > /tmp/log
shadowsocks_base64=$(cat /tmp/log)
echo -n "${shadowsocks_base64}" | base64 > /tmp/log1
shadowsocks_base64e=$(cat /tmp/log1)
shadowsockslink="ss://${shadowsocks_base64e}@$domain:$tls?plugin=obfs-local;mux=0;path=/shadowsocks;host=$domain;tls#${user}"
shadowsockslink1="ss://${shadowsocks_base64e}@$domain:$none?plugin=xray-plugin;mux=0;path=/shadowsocks;host=$domain;http#${user}"
rm -rf /home/vps/public_html/${user}*
rm -rf /tmp/log
rm -rf /tmp/log1
sodosok_ntls
sodosok_tls
link="http://${MYIP}:81/${user}-TLS"
link1="http://${MYIP}:81/${user}-NTLS"
service cron restart > /dev/null 2>&1
systemctl restart xray@shadowsocks > /dev/null 2>&1
clear
echo -e "\033[0;34m------------------------------------\033[0m"
echo -e "\E[44;1;39m       User Shadowsocks Account     \E[0m"
echo -e "\033[0;34m------------------------------------\033[0m"
echo -e "Remarks       : ${user}"
echo -e "IP Address    : ${MYIP}"
echo -e "Domain        : ${domain}"
echo -e "Port None TLS : ${none}"
echo -e "Port TLS      : ${tls}"
echo -e "Password      : ${uuid}"
echo -e "Cipers        : aes-128-gcm"
echo -e "\033[0;34m------------------------------------\033[0m"
echo -e "Link TLS :"
echo -e ""
echo -e "${link}"
echo -e ""
echo -e "\033[0;34m------------------------------------\033[0m"
echo -e "Link none TLS :"
echo -e ""
echo -e "${link1}"
echo -e ""
echo -e "\033[0;34m------------------------------------\033[0m"
echo -e "Created On    : $hariini"
echo -e "Expired On    : $exp"
echo -e "\033[0;34m------------------------------------\033[0m"
echo ""
echo "DOWNLOAD FILE,OPEN WITH TEXT DOCUMENT,COPY & PASTE DI v2rayNG
Custom Config"
echo ""
echo -e "\033[0;34m------------------------------------\033[0m"
read -n 1 -s -r -p "Press any key to back on menu"
menu
}

del-shadowsocks() {
clear
rm -rf /root/usr_tmp.txt > /dev/null 2>&1
(grep -E "^### " "/usr/local/etc/xray/shadowsocks.json") | sort | uniq > usr_tmp.txt
NUMBER_OF_CLIENTS=$(grep -c -E "^### " "/root/usr_tmp.txt")
	if [[ ${NUMBER_OF_CLIENTS} == '0' ]]; then
        echo -e "\033[0;34m-------------------------------\033[0m"
        echo -e "\E[44;1;39m   Delete Shadowsocks Account  \E[0m"
        echo -e "\033[0;34m-------------------------------\033[0m"
	echo ""
	echo "You have no existing clients!"
	echo ""
	echo -e "\033[0;34m-------------------------------\033[0m"
	rm -rf /root/usr_tmp.txt
	read -n 1 -s -r -p "Press any key to back on menu"
	menu_xray
	fi
	clear
        echo -e "\033[0;34m-------------------------------\033[0m"
        echo -e "\E[44;1;39m   Delete Shadowsocks Account  \E[0m"
        echo -e "\033[0;34m-------------------------------\033[0m"
	echo "  User       Expired  " 
	echo -e "\033[0;34m-------------------------------\033[0m"
	grep -E "^### " "/root/usr_tmp.txt" | cut -d ' ' -f 2-3 | sort | uniq | nl -s ') '
	echo ""
	until [[ ${CLIENT_NUMBER} -ge 1 && ${CLIENT_NUMBER} -le ${NUMBER_OF_CLIENTS} ]]; do
		if [[ ${CLIENT_NUMBER} == '1' ]]; then
			echo -e "\033[0;34m-------------------------------\033[0m"
			read -rp "Select one client [1]: " CLIENT_NUMBER
		else
			echo -e "\033[0;34m-------------------------------\033[0m"
			read -rp "Select one client [1-${NUMBER_OF_CLIENTS}]: " CLIENT_NUMBER
		fi
	done
    user=$(grep -E "^### " "/root/usr_tmp.txt" | cut -d ' ' -f 2 | awk '{print $1}' |sed -n "${CLIENT_NUMBER}"p)
    exp=$(grep -wE "^### $user" "/root/usr_tmp.txt" | cut -d ' ' -f 3 | sed -n "${CLIENT_NUMBER}"p)
    hariini=$(date +%Y-%m-%d)
    sed -i "/^### $user $exp/,/^},{/d" /usr/local/etc/xray/shadowsocks.json
    rm -rf /home/vps/public_html/${user}* > /dev/null 2>&1

    #Restart Service
    service cron restart > /dev/null 2>&1
    systemctl restart xray@shadowsocks > /dev/null 2>&1
    rm -rf /root/usr_tmp.txt > /dev/null 2>&1
    
    clear
    echo -e "\033[0;34m-------------------------------\033[0m"
    echo -e "\E[44;1;39m   Delete Shadowsocks Account  \E[0m"
    echo -e "\033[0;34m-------------------------------\033[0m"
    echo " Shadowsocks Account Deleted Successfully"
    echo -e "\033[0;34m-------------------------------\033[0m"
    echo " Client Name : $user"
    echo " Deleted On  : $hariini"
    echo -e "\033[0;34m-------------------------------\033[0m"
    echo ""
    read -n 1 -s -r -p "Press any key to back on menu" 
    menu
}

renew-shadowsocks() {
clear
rm -rf /root/usr_tmp.txt
(grep -E "^### " "/usr/local/etc/xray/shadowsocks.json") | sort | uniq > usr_tmp.txt
NUMBER_OF_CLIENTS=$(grep -c -E "^### " "/root/usr_tmp.txt")
    if [[ ${NUMBER_OF_CLIENTS} == '0' ]]; then
    clear
    echo -e "\033[0;34m-------------------------------\033[0m"
    echo -e "\E[44;1;39m    Renew Shadowsocks Account  \E[0m"
    echo -e "\033[0;34m-------------------------------\033[0m"
    echo ""
    echo "You have no existing clients!"
    echo ""
    echo -e "\033[0;34m-------------------------------\033[0m"
    rm -rf /root/usr_tmp.tx
    echo ""
    read -n 1 -s -r -p "Press any key to back on menu"
    menu_xray
    fi
    clear
    echo -e "\033[0;34m-------------------------------\033[0m"
    echo -e "\E[44;1;39m    Renew Shadowsocks Account  \E[0m"
    echo -e "\033[0;34m-------------------------------\033[0m"
    echo ""
    grep -E "^### " "/root/usr_tmp.txt" | cut -d ' ' -f 2-3 | sort | uniq | nl -s ') '
	until [[ ${CLIENT_NUMBER} -ge 1 && ${CLIENT_NUMBER} -le ${NUMBER_OF_CLIENTS} ]]; do
		if [[ ${CLIENT_NUMBER} == '1' ]]; then
			echo -e "\033[0;34m-------------------------------\033[0m"
			read -rp "Select one client [1]: " CLIENT_NUMBER
		else
			echo -e "\033[0;34m-------------------------------\033[0m"
			read -rp "Select one client [1-${NUMBER_OF_CLIENTS}]: " CLIENT_NUMBER
		fi
	done
    echo -e "\033[0;34m-------------------------------\033[0m"
    read -p "Expired (days): " masaaktif
    user=$(grep -E "^### " "/root/usr_tmp.txt" | cut -d ' ' -f 2 | awk '{print $1}' |sed -n "${CLIENT_NUMBER}"p)
    exp=$(grep -wE "^### $user" "/usr/local/etc/xray/shadowsocks.json" | cut -d ' ' -f 3 | sort | uniq)
    now=$(date +%Y-%m-%d)
    d1=$(date -d "$exp" +%s)
    d2=$(date -d "$now" +%s)
    exp2=$(( (d1 - d2) / 86400 ))
    exp3=$(($exp2 + $masaaktif))
    exp4=`date -d "$exp3 days" +"%Y-%m-%d"`
    sed -i "/### $user/c\### $user $exp4" /usr/local/etc/xray/shadowsocks.json
   
    #Restart Service
    service cron restart > /dev/null 2>&1
    systemctl restart xray@shadowsocks > /dev/null 2>&1

    clear
    echo -e "\033[0;34m-------------------------------\033[0m"
    echo -e "\E[44;1;39m    Renew Shadowsocks Account  \E[0m"
    echo -e "\033[0;34m-------------------------------\033[0m"
    echo " Shadowsocks Account Was Successfully Renewed"
    echo -e "\033[0;34m-------------------------------\033[0m"
    echo ""
    echo " Client Name : $user"
    echo " Expired On  : $exp4"
    echo ""
    echo -e "\033[0;34m-------------------------------\033[0m"
    echo ""
    rm -rf /root/usr_tmp.txt
    read -n 1 -s -r -p "Press any key to back on menu" 
    menu
}

cek-shadowsocks() {
clear
#echo -n /var/log/xray/access3.log
echo -n > /tmp/other.txt
data=( `cat /usr/local/etc/xray/shadowsocks.json | grep '^###' | cut -d ' ' -f 2 | sort | uniq`);
echo -e "\033[0;34m-------------------------------\033[0m"
echo -e "\E[44;1;39m  XRAY Shadowsocks User Login  \E[0m"
echo -e "\033[0;34m-------------------------------\033[0m"
for akun in "${data[@]}"
do
if [[ -z "$akun" ]]; then
akun="tidakada"
fi

echo -n > /tmp/ipvmess.txt
data2=( `cat /var/log/xray/access3.log | tail -n 500 | cut -d " " -f 3 | sed 's/tcp://g' | cut -d ":" -f 1 | sort | uniq`);
for ip in "${data2[@]}"
do

jum=$(cat /var/log/xray/access3.log | grep -w "$akun" | tail -n 500 | cut -d " " -f 3 | sed 's/tcp://g' | cut -d ":" -f 1 | grep -w "$ip" | sort | uniq)
if [[ "$jum" = "$ip" ]]; then
echo "$jum" >> /tmp/ipvmess.txt
else
echo "$ip" >> /tmp/other.txt
fi
jum2=$(cat /tmp/ipvmess.txt)
sed -i "/$jum2/d" /tmp/other.txt > /dev/null 2>&1
done

jum=$(cat /tmp/ipvmess.txt)
if [[ -z "$jum" ]]; then
echo > /dev/null
else
jum2=$(cat /tmp/ipvmess.txt | nl)
echo "user : $akun";
echo "$jum2";
echo -e "\033[0;34m-------------------------------\033[0m"
fi
rm -rf /tmp/ipvmess.txt
done

rm -rf /tmp/other.txt
echo ""
read -n 1 -s -r -p "Press any key to back on menu"
menu_xray
}

recreate-shadowsocks() {
clear
tls="$(cat ~/log-install.txt | grep -w "XRAY Shadowsocks TLS" | cut -d: -f2|sed 's/ //g')"
none="$(cat ~/log-install.txt | grep -w "XRAY Shadowsocks None TLS" | cut -d: -f2|sed 's/ //g')"
source /var/lib/premium-script/ipvps.conf
if [[ "$IP" = "" ]]; then
domain=$(cat /etc/xray/domain)
else
domain=$IP
fi
domainn=$(cat /root/domain)
grep -E "^### " "/usr/local/etc/xray/shadowsocks.json" | sort | uniq > /root/user_tmp.txt
NUMBER_OF_CLIENTS=$(grep -c -E "^### " "/root/user_tmp.txt")
	if [[ ${NUMBER_OF_CLIENTS} == '0' ]]; then
    clear
    echo -e "\033[0;34m-------------------------------\033[0m"
    echo -e "\E[44;1;39m   Select Shadowsocks Account  \E[0m"
    echo -e "\033[0;34m-------------------------------\033[0m"
		echo ""
		echo "You have no existing clients!"
    echo ""
    echo -e "\033[0;34m-------------------------------\033[0m"
	sleep 3
	menu_xray
	fi
	clear
    echo -e "\033[0;34m-------------------------------\033[0m"
    echo -e "\E[44;1;39m   Select Shadowsocks Account  \E[0m"
    echo -e "\033[0;34m-------------------------------\033[0m"
	  echo "     No  User   Expired"
	grep -E "^### " "/root/user_tmp.txt" | cut -d ' ' -f 2-4 | sort | uniq | nl -s ') '
	until [[ ${CLIENT_NUMBER} -ge 1 && ${CLIENT_NUMBER} -le ${NUMBER_OF_CLIENTS} ]]; do
		if [[ ${CLIENT_NUMBER} == '1' ]]; then
			read -rp "Select one client [1]: " CLIENT_NUMBER
		else
			read -rp "Select one client [1-${NUMBER_OF_CLIENTS}]: " CLIENT_NUMBER
		fi
	done
add_data
user=$(grep -E "^### " "/root/user_tmp.txt" | cut -d ' ' -f 2 | sed -n "${CLIENT_NUMBER}"p)
exp=$(cat /root/user_tmp.txt | grep -w "$user" | awk '{print $3}')
uuid=$(cat /usr/local/etc/xray/shadowsocks.json | grep -w "$user" | grep "password" | cut -f 2 -d ':' | cut -f 2 -d '"' | sort | uniq)
hariini=$(date +%Y-%m-%d)
echo $cipher:$uuid > /tmp/log
shadowsocks_base64=$(cat /tmp/log)
echo -n "${shadowsocks_base64}" | base64 > /tmp/log1
shadowsocks_base64e=$(cat /tmp/log1)
shadowsockslink="ss://${shadowsocks_base64e}@$domain:$tls?plugin=obfs-local;mux=0;path=/shadowsocks;host=$domain;tls#${user}"
shadowsockslink1="ss://${shadowsocks_base64e}@$domain:$none?plugin=xray-plugin;mux=0;path=/shadowsocks;host=$domain;http#${user}"
rm -rf /home/vps/public_html/${user}*
rm -rf /tmp/log
rm -rf /tmp/log1
sodosok_ntls
sodosok_tls
link="http://${MYIP}:81/${user}-TLS"
link1="http://${MYIP}:81/${user}-NTLS"
service cron restart > /dev/null 2>&1
systemctl restart xray@shadowsocks > /dev/null 2>&1
clear

rm -rf /root/user_tmp.txt
clear
echo -e "\033[0;34m------------------------------------\033[0m"
echo -e "\E[44;1;39m    User Xray Shadowsocks Account   \E[0m"
echo -e "\033[0;34m------------------------------------\033[0m"
echo -e "Remarks          : ${user}"
echo -e "IP Address       : ${MYIP}"
echo -e "Domain           : ${domainn}"
echo -e "Port WS TLS      : ${tls}"
echo -e "Port WS none TLS : ${none}"
echo -e "id               : ${uuid}"
echo -e "\033[0;34m------------------------------------\033[0m"
echo -e "Remarks       : ${user}"
echo -e "IP Address    : ${MYIP}"
echo -e "Domain        : ${domain}"
echo -e "Port None TLS : ${none}"
echo -e "Port TLS      : ${tls}"
echo -e "Password      : ${uuid}"
echo -e "Cipers        : aes-128-gcm"
echo -e "\033[0;34m------------------------------------\033[0m"
echo -e "Link TLS :"
echo -e ""
echo -e "${link}"
echo -e ""
echo -e "\033[0;34m------------------------------------\033[0m"
echo -e "Link none TLS :"
echo -e ""
echo -e "${link1}"
echo -e ""
echo -e "\033[0;34m------------------------------------\033[0m"
echo -e "Recreate On   : $hariini"
echo -e "Expired On    : $exp"
echo -e "\033[0;34m------------------------------------\033[0m"
echo ""
echo "DOWNLOAD FILE,OPEN WITH TEXT DOCUMENT,COPY & PASTE DI
v2rayNG Custom Config"
echo ""
echo -e "\033[0;34m------------------------------------\033[0m"
echo ""
read -n 1 -s -r -p "Press any key to back on menu"
menu
}

trial_all() {
clear
xtls="$(cat ~/log-install.txt | grep -w "XRAY XTLS DIRECT" | cut -d: -f2|sed 's/ //g')"
tcp="$(cat ~/log-install.txt | grep -w "XRAY Trojan TCP" | cut -d: -f2|sed 's/ //g')"
tls="$(cat ~/log-install.txt | grep -w "XRAY Vmess WS TLS" | cut -d: -f2|sed 's/ //g')"
none="$(cat ~/log-install.txt | grep -w "XRAY Vmess WS None TLS" | cut -d: -f2|sed 's/ //g')"
source /var/lib/premium-script/ipvps.conf
if [[ "$IP" = "" ]]; then
domain=$(cat /etc/xray/domain)
else
domain=$IP
fi

echo -e "\033[0;34m-------------------------------\033[0m"
echo -e "\E[44;1;39m    Trial All Xray Account     \E[0m"
echo -e "\033[0;34m-------------------------------\033[0m"
echo -e "1) Create Trial User"
echo -e "2) Add User"
echo -e "\033[0;34m-------------------------------\033[0m"
read -rp "Please Input Your Option " -e ans
if [ "$ans" = "1" ]; then
	clear
	until [[ $user =~ ^[a-zA-Z0-9_]+$ && ${CLIENT_EXISTS} == '0' ]]; do
		echo -e "\033[0;34m-------------------------------\033[0m"
		echo -e "\E[44;1;39m    Trial All Xray Account     \E[0m"
		echo -e "\033[0;34m-------------------------------\033[0m"
		user=XRAY`</dev/urandom tr -dc X-Z0-9 | head -c4`
		masaaktif=1
		add_data
		CLIENT_EXISTS=$(grep -w $user /usr/local/etc/xray/config.json | wc -l)
		if [[ ${CLIENT_EXISTS} == '1' ]]; then
		clear
		echo -e "\033[0;34m-------------------------------\033[0m"
		echo -e "\E[44;1;39m    Trial All Xray Account     \E[0m"
		echo -e "\033[0;34m-------------------------------\033[0m"
		echo ""
		echo "A client with the specified name was already created, please choose another name."
		echo ""
		echo -e "\033[0;34m-------------------------------\033[0m"
		read -n 1 -s -r -p "Press any key to back on menu"
		menu_xray
		fi
	done
elif [ "$ans" = "2" ]; then
	clear
	until [[ $user =~ ^[a-zA-Z0-9_]+$ && ${CLIENT_EXISTS} == '0' ]]; do
		echo -e "\033[0;34m-------------------------------\033[0m"
		echo -e "\E[44;1;39m    Trial All Xray Account     \E[0m"
		echo -e "\033[0;34m-------------------------------\033[0m"
		read -rp "User: " -e user
		read -p "Expired (days): " masaaktif
		add_data
		CLIENT_EXISTS=$(grep -w $user /usr/local/etc/xray/config.json | wc -l)
		if [[ ${CLIENT_EXISTS} == '1' ]]; then
		clear
		echo -e "\033[0;34m-------------------------------\033[0m"
		echo -e "\E[44;1;39m    Trial All Xray Account     \E[0m"
		echo -e "\033[0;34m-------------------------------\033[0m"
		echo ""
		echo "A client with the specified name was already created, please choose another name."
		echo ""
		echo -e "\033[0;34m-------------------------------\033[0m"
		read -n 1 -s -r -p "Press any key to back on menu"
		menu_xray
		fi
	done
else
	echo -e "INPUT YOUR OPTION NUMBER!!!"
	sleep 3
	clear
	trial_all
fi

cipher="aes-128-gcm"
uuid=$(cat /proc/sys/kernel/random/uuid)
hariini=`date -d "0 days" +"%Y-%m-%d"`
exp=`date -d "$masaaktif days" +"%Y-%m-%d"`

#Input Json Vmess
sed -i '/#vmess$/a\### '"$user $exp"'\
},{"id": "'""$uuid""'","alterId": '"0"',"email": "'""$user""'"' /usr/local/etc/xray/vmess.json

#Input Json Vless
sed -i '/#vless-xtls$/a\### '"$user $exp"'\
},{"id": "'""$uuid""'","flow": "xtls-rprx-direct","email": "'""$user""'"' /usr/local/etc/xray/config.json
sed -i '/#vless$/a\### '"$user $exp"'\
},{"id": "'""$uuid""'","email": "'""$user""'"' /usr/local/etc/xray/config.json

#Input Json Trojan
sed -i '/#trojan$/a\### '"$user $exp"'\
},{"password": "'""$uuid""'","email": "'""$user""'"' /usr/local/etc/xray/trojan.json

#Input Json Shadowsocks
sed -i '/#shadowsocks$/a\### '"$user $exp"'\
},{"password": "'""$uuid""'","method": "'""$cipher""'","email": "'""$user""'"' /usr/local/etc/xray/shadowsocks.json
echo $cipher:$uuid > /tmp/log
shadowsocks_base64=$(cat /tmp/log)
echo -n "${shadowsocks_base64}" | base64 > /tmp/log1
shadowsocks_base64e=$(cat /tmp/log1)

#Clean User
rm -rf /home/vps/public_html/${user}* > /dev/null 2>&1
rm -rf /tmp/log
rm -rf /tmp/log1

asu=`cat<<EOF
      {
      "v": "2",
      "ps": "${user}",
      "add": "${domain}",
      "port": "${tls}",
      "id": "${uuid}",
      "aid": "0",
      "net": "ws",
      "path": "/vmessws",
      "type": "none",
      "host": "${BUG}",
      "tls": "tls"
}
EOF`
ask=`cat<<EOF
      {
      "v": "2",
      "ps": "${user}",
      "add": "${domain}",
      "port": "${none}",
      "id": "${uuid}",
      "aid": "0",
      "net": "ws",
      "path": "/vmessws",
      "type": "none",
      "host": "${BUG}",
      "tls": "none"
}
EOF`

#Vmess Configuration
vmess_base641=$( base64 -w 0 <<< $vmess_json1)
vmess_base642=$( base64 -w 0 <<< $vmess_json2)
vmesslink1="vmess://$(echo $asu | base64 -w 0)"
vmesslink2="vmess://$(echo $ask | base64 -w 0)"

#Vless Configuration
vlesslink1="vless://${uuid}@${wild}${domain}:${xtls}?security=xtls&encryption=none&headerType=none&type=tcp&flow=xtls-rprx-direct&sni=${BUG}#$user"
vlesslink2="vless://${uuid}@${wild}${wild}${domain}:${xtls}?security=xtls&encryption=none&headerType=none&type=tcp&flow=xtls-rprx-splice&sni=${BUG}#$user"
vlesslink3="vless://${uuid}@${wild}${domain}:$tls?security=tls&encryption=none&type=tcp&sni=${BUG}#$user"
vlesslink4="vless://${uuid}@${wild}${domain}:$tls?path=/vlessws&security=tls&encryption=none&type=ws&sni=$BUG#$user"
vlesslink5="vless://${uuid}@${wild}${domain}:$none?path=/vlessws&encryption=none&type=ws&host=$BUG#$user"

#Trojan Configuration
trojanlink="trojan://${uuid}@${wild}${domain}:${tcp}?security=tls&type=tcp&sni=$BUG#${user}"
trojanlink1="trojan://${uuid}@${wild}${domain}:${tcp}?security=tls&type=tcp&sni=$BUG&flow=xtls-rprx-splice#${user}"
trojanlink2="trojan://${uuid}@${wild}${domain}:${tls}?security=tls&type=ws&headerType=none&path=/trojan-ws&sni=$BUG&host=$BUG#${user}"
trojanlink3="trojan://${uuid}@${wild}${domain}:${none}?security=none&type=ws&headerType=none&path=/trojan-ws&host=$BUG#${user}"

#Shadowsocks Configuration
shadowsockslink="ss://${shadowsocks_base64e}@$domain:$tls?plugin=obfs-local;mux=0;path=/shadowsocks;host=$domain;tls#${user}"
shadowsockslink1="ss://${shadowsocks_base64e}@$domain:$none?plugin=xray-plugin;mux=0;path=/shadowsocks;host=$domain;http#${user}"

vmess_yamltls
vmess_yamlntls
vless_yamltls
vless_yamlntls
trojan_yamltls
trojan_yamlntls
sodosok_ntls
sodosok_tls
trojanyamltls=http://$MYIP:81/${user}_trojantls.yaml
trojanyamlntls=http://$MYIP:81/${user}_trojanntls.yaml
vlessyamltls=http://$MYIP:81/${user}_vlesstls.yaml
vlessyamlntls=http://$MYIP:81/${user}_vlessntls.yaml
vmessyamltls=http://$MYIP:81/${user}_vmesstls.yaml
vmessyamlntls=http://$MYIP:81/${user}_vmessntls.yaml
link="http://${MYIP}:81/${user}-TLS"
link1="http://${MYIP}:81/${user}-NTLS"

#Restart Service
service cron restart > /dev/null 2>&1
systemctl restart xray > /dev/null 2>&1
systemctl restart xray@vmess > /dev/null 2>&1
systemctl restart xray@trojan > /dev/null 2>&1
systemctl restart xray@shadowsocks > /dev/null 2>&1

link() {
clear
echo -e "\033[0;34m-------------------------------\033[0m"
echo -e "\E[44;1;39m    Trial All Xray Account     \E[0m"
echo -e "\033[0;34m-------------------------------\033[0m"
echo -e "Remarks       : ${user}"
echo -e "IP Address    : ${MYIP}"
echo -e "Domain        : ${domain}"
echo -e "Port XTLS     : ${xtls}"
echo -e "Port TCP      : ${tcp}"
echo -e "Port TLS      : ${tls}"
echo -e "Port none TLS : ${none}"
echo -e "Path Vless WS : ${path}"
echo -e "id            : ${uuid}"
echo -e "\033[0;34m-------------------------------\033[0m"
echo -e "Link Vmess TLS :"
echo -e '```'
echo -e "${vmesslink1}"
echo -e '```'
echo -e "\033[0;34m------------------------------------\033[0m"
echo -e "Link Vmess none TLS :"
echo -e '```'
echo -e "${vmesslink2}"
echo -e '```'
echo -e "\033[0;34m-------------------------------\033[0m"
echo -e "Link Vless XTLS DIRECT :"
echo -e '```'
echo -e "${vlesslink1}"
echo -e '```'
echo -e "\033[0;34m------------------------------------\033[0m"
echo -e "Link Vless XTLS SPLICE :"
echo -e '```'
echo -e "${vlesslink2}"
echo -e '```'
echo -e "\033[0;34m------------------------------------\033[0m"
echo -e "Link Vless TCP TLS :"
echo -e '```'
echo -e "${vlesslink3}"
echo -e '```'
echo -e "\033[0;34m------------------------------------\033[0m"
echo -e "Link Vless WS TLS :"
echo -e '```'
echo -e "${vlesslink4}"
echo -e '```'
echo -e "\033[0;34m------------------------------------\033[0m"
echo -e "Link Vless WS none TLS :"
echo -e '```'
echo -e "${vlesslink5}"
echo -e '```'
echo -e "\033[0;34m-------------------------------\033[0m"
echo -e "Link Trojan TCP :"
echo -e '```'
echo -e "${trojanlink}"
echo -e '```'
echo -e "\033[0;34m------------------------------------\033[0m"
echo -e "Link Trojan TCP FLOW XTLS :"
echo -e '```'
echo -e "${trojanlink1}"
echo -e '```'
echo -e "\033[0;34m------------------------------------\033[0m"
echo -e "Link WS TLS :"
echo -e '```'
echo -e "${trojanlink2}"
echo -e '```'
echo -e "\033[0;34m------------------------------------\033[0m"
echo -e "Link WS None TLS :"
echo -e '```'
echo -e "${trojanlink3}"
echo -e '```'
echo -e "\033[0;34m-------------------------------\033[0m"
echo -e "Link Yaml Vmess TLS :"
echo -e ""
echo -e "${vmessyamltls}"
echo -e ""
echo -e "\033[0;34m------------------------------------\033[0m"
echo -e "Link Yaml Vmess none TLS :"
echo -e ""
echo -e "${vmessyamlntls}"
echo -e ""
echo -e "\033[0;34m------------------------------------\033[0m"
echo -e "Link Yaml Vless TLS :"
echo -e ""
echo -e "${vlessyamltls}"
echo -e ""
echo -e "\033[0;34m------------------------------------\033[0m"
echo -e "Link Yaml Vless none TLS :"
echo -e ""
echo -e "${vlessyamlntls}"
echo -e ""
echo -e "\033[0;34m------------------------------------\033[0m"
echo -e "Link Yaml Trojan TLS :"
echo -e ""
echo -e "${trojanyamltls}"
echo -e ""
echo -e "\033[0;34m------------------------------------\033[0m"
echo -e "Link Yaml Trojan none TLS :"
echo -e ""
echo -e "${trojanyamlntls}"
echo -e ""
echo -e "\033[0;34m-------------------------------\033[0m"
echo -e "Link Xray Shadowsocks TLS :"
echo -e ""
echo -e "${link}"
echo -e ""
echo -e "\033[0;34m------------------------------------\033[0m"
echo -e "Link Xray Shadowsocks none TLS :"
echo -e ""
echo -e "${link1}"
echo -e ""
echo -e "\033[0;34m------------------------------------\033[0m"
echo -e "Created On    : $hariini"
echo -e "Expired On    : $exp"
echo -e "\033[0;34m-------------------------------\033[0m"
echo ""
echo "XRAY SODOSOK SILA DOWNLOAD FILE,OPEN WITH TEXT DOCUMENT,COPY 
& PASTE DI IMPORT CUSTOM CONFIG v2rayNG"
echo ""
echo -e "\033[0;34m-------------------------------\033[0m"
rm /etc/xray/$user-tls.json > /dev/null 2>&1
rm /etc/xray/$user-none.json > /dev/null 2>&1
read -n 1 -s -r -p "Press any key to back on menu"
menu
}

multipath="$(systemctl show xray --no-page)"
multipathstat=$(echo "${multipath}" | grep 'Description=' | cut -f2 -d=)
if [[ $multipathstat == "Custom Xray-Vless_Multipath By VPN Legasi" ]]; then
    path="/vlessws or anypath"
    link
else
    path="Xray not support custom Path,use default path"
    link
fi
}

cek-all() {
clear
#echo -n /var/log/xray/access.log
echo -n > /tmp/other.txt
data=( `cat /usr/local/etc/xray/config.json | grep '^###' | cut -d ' ' -f 2 | sort | uniq`);
echo -e "\033[0;34m-------------------------------\033[0m"
echo -e "\E[44;1;39m      XRAY Vless User Login    \E[0m"
echo -e "\033[0;34m-------------------------------\033[0m"
for akun in "${data[@]}"
do
if [[ -z "$akun" ]]; then
akun="tidakada"
fi

echo -n > /tmp/ipvmess.txt
data2=( `cat /var/log/xray/access.log | tail -n 500 | cut -d " " -f 3 | sed 's/tcp://g' | cut -d ":" -f 1 | sort | uniq`);
for ip in "${data2[@]}"
do

jum=$(cat /var/log/xray/access.log | grep -w "$akun" | tail -n 500 | cut -d " " -f 3 | sed 's/tcp://g' | cut -d ":" -f 1 | grep -w "$ip" | sort | uniq)
if [[ "$jum" = "$ip" ]]; then
echo "$jum" >> /tmp/ipvmess.txt
else
echo "$ip" >> /tmp/other.txt
fi
jum2=$(cat /tmp/ipvmess.txt)
sed -i "/$jum2/d" /tmp/other.txt > /dev/null 2>&1
done

jum=$(cat /tmp/ipvmess.txt)
if [[ -z "$jum" ]]; then
echo > /dev/null
else
jum2=$(cat /tmp/ipvmess.txt | nl)
echo "user : $akun";
echo "$jum2";
fi
rm -rf /tmp/ipvmess.txt
done

#echo -n /var/log/xray/access2.log
echo -n > /tmp/other.txt
data=( `cat /usr/local/etc/xray/vmess.json | grep '^###' | cut -d ' ' -f 2 | sort | uniq`);
echo -e "\033[0;34m-------------------------------\033[0m"
echo -e "\E[44;1;39m      XRAY Vmess User Login    \E[0m"
echo -e "\033[0;34m-------------------------------\033[0m"
for akun in "${data[@]}"
do
if [[ -z "$akun" ]]; then
akun="tidakada"
fi

echo -n > /tmp/ipvmess.txt
data2=( `cat /var/log/xray/access2.log | tail -n 500 | cut -d " " -f 3 | sed 's/tcp://g' | cut -d ":" -f 1 | sort | uniq`);
for ip in "${data2[@]}"
do

jum=$(cat /var/log/xray/access2.log | grep -w "$akun" | tail -n 500 | cut -d " " -f 3 | sed 's/tcp://g' | cut -d ":" -f 1 | grep -w "$ip" | sort | uniq)
if [[ "$jum" = "$ip" ]]; then
echo "$jum" >> /tmp/ipvmess.txt
else
echo "$ip" >> /tmp/other.txt
fi
jum2=$(cat /tmp/ipvmess.txt)
sed -i "/$jum2/d" /tmp/other.txt > /dev/null 2>&1
done

jum=$(cat /tmp/ipvmess.txt)
if [[ -z "$jum" ]]; then
echo > /dev/null
else
jum2=$(cat /tmp/ipvmess.txt | nl)
echo "user : $akun";
echo "$jum2";
fi
rm -rf /tmp/ipvmess.txt
done

#echo -n /var/log/xray/access1.log
echo -n > /tmp/other.txt
data=( `cat /usr/local/etc/xray/trojan.json | grep '^###' | cut -d ' ' -f 2 | sort | uniq`);
echo -e "\033[0;34m-------------------------------\033[0m"
echo -e "\E[44;1;39m     XRAY Trojan User Login    \E[0m"
echo -e "\033[0;34m-------------------------------\033[0m"
for akun in "${data[@]}"
do
if [[ -z "$akun" ]]; then
akun="tidakada"
fi

echo -n > /tmp/ipvmess.txt
data2=( `cat /var/log/xray/access1.log | tail -n 500 | cut -d " " -f 3 | sed 's/tcp://g' | cut -d ":" -f 1 | sort | uniq`);
for ip in "${data2[@]}"
do

jum=$(cat /var/log/xray/access1.log | grep -w "$akun" | tail -n 500 | cut -d " " -f 3 | sed 's/tcp://g' | cut -d ":" -f 1 | grep -w "$ip" | sort | uniq)
if [[ "$jum" = "$ip" ]]; then
echo "$jum" >> /tmp/ipvmess.txt
else
echo "$ip" >> /tmp/other.txt
fi
jum2=$(cat /tmp/ipvmess.txt)
sed -i "/$jum2/d" /tmp/other.txt > /dev/null 2>&1
done

jum=$(cat /tmp/ipvmess.txt)
if [[ -z "$jum" ]]; then
echo > /dev/null
else
jum2=$(cat /tmp/ipvmess.txt | nl)
echo "user : $akun";
echo "$jum2";
fi
rm -rf /tmp/ipvmess.txt
done
#echo -n /var/log/xray/access3.log
echo -n > /tmp/other.txt
data=( `cat /usr/local/etc/xray/shadowsocks.json | grep '^###' | cut -d ' ' -f 2 | sort | uniq`);
echo -e "\033[0;34m-------------------------------\033[0m"
echo -e "\E[44;1;39m  XRAY shadowsocks User Login  \E[0m"
echo -e "\033[0;34m-------------------------------\033[0m"
for akun in "${data[@]}"
do
if [[ -z "$akun" ]]; then
akun="tidakada"
fi

echo -n > /tmp/ipvmess.txt
data2=( `cat /var/log/xray/access3.log | tail -n 500 | cut -d " " -f 3 | sed 's/tcp://g' | cut -d ":" -f 1 | sort | uniq`);
for ip in "${data2[@]}"
do

jum=$(cat /var/log/xray/access3.log | grep -w "$akun" | tail -n 500 | cut -d " " -f 3 | sed 's/tcp://g' | cut -d ":" -f 1 | grep -w "$ip" | sort | uniq)
if [[ "$jum" = "$ip" ]]; then
echo "$jum" >> /tmp/ipvmess.txt
else
echo "$ip" >> /tmp/other.txt
fi
jum2=$(cat /tmp/ipvmess.txt)
sed -i "/$jum2/d" /tmp/other.txt > /dev/null 2>&1
done

jum=$(cat /tmp/ipvmess.txt)
if [[ -z "$jum" ]]; then
echo > /dev/null
else
jum2=$(cat /tmp/ipvmess.txt | nl)
echo "user : $akun";
echo "$jum2";
fi
rm -rf /tmp/ipvmess.txt
done

rm -rf /tmp/other.txt
echo -e "\033[0;34m-------------------------------\033[0m"
echo ""
read -n 1 -s -r -p "Press any key to back on menu"
menu_xray
}

running_1() {
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
echo -e "\033[0;34m-------------------------------\033[0m"
echo -e ""
read -n 1 -s -r -p "Press any key to back on menu"
menu_xray
}

clear
echo -e "\033[0;34m------------------------------------\033[0m"
echo -e "\E[44;1;39m         XRAY MULTIPORT MENU        \E[0m"
echo -e "\033[0;34m------------------------------------\033[0m"
echo ""
echo -e " [\e[36m 01 \e[0m] Trial XRay VMess WS"
echo -e " [\e[36m 02 \e[0m] Add XRay VMess WS"
echo -e " [\e[36m 03 \e[0m] Delete XRay VMess WS"
echo -e " [\e[36m 04 \e[0m] Renew XRay VMess WS"
echo -e " [\e[36m 05 \e[0m] Check User Login XRay VMess WS"
echo ""
echo -e " [\e[36m 06 \e[0m] Trial XRay VLess XTLS & WS"
echo -e " [\e[36m 07 \e[0m] Add XRay VLess XTLS & WS"
echo -e " [\e[36m 08 \e[0m] Delete XRay VLess XTLS & WS"
echo -e " [\e[36m 09 \e[0m] Renew XRay VLess XTLS & WS"
echo -e " [\e[36m 10 \e[0m] Check User Login XRay VLess XTLS & WS"
echo ""
echo -e " [\e[36m 11 \e[0m] Trial XRay Trojan TCP & WS"
echo -e " [\e[36m 12 \e[0m] Add XRay Trojan TCP & WS"
echo -e " [\e[36m 13 \e[0m] Delete XRay Trojan TCP & WS"
echo -e " [\e[36m 14 \e[0m] Renew XRay Trojan TCP & WS"
echo -e " [\e[36m 15 \e[0m] Check User XRay Trojan TCP & WS"
echo ""
echo -e " [\e[36m 16 \e[0m] Trial XRay Shadowsocks WS"
echo -e " [\e[36m 17 \e[0m] Add XRay Shadowsocks WS"
echo -e " [\e[36m 18 \e[0m] Delete XRay Shadowsocks WS"
echo -e " [\e[36m 19 \e[0m] Renew XRay Shadowsocks WS"
echo -e " [\e[36m 20 \e[0m] Check XRay Shadowsocks WS"
echo ""
echo -e " [\e[36m 21 \e[0m] Trial All Xray Protocol"
echo -e " [\e[36m 22 \e[0m] Renew Cert Xray "
echo -e " [\e[36m 23 \e[0m] Check Port Info "
echo -e " [\e[36m 24 \e[0m] Check Running Service "
echo -e " [\e[36m 25 \e[0m] Check Multilogin All Protocol Xray User "
echo -e " [\e[36m 26 \e[0m] Recall Id Vless User "
echo -e " [\e[36m 27 \e[0m] Recall Id Trojan User "
echo -e " [\e[36m 28 \e[0m] Recall Id Vmess User "
echo -e " [\e[36m 29 \e[0m] Recall Id Shadowsocks User "
echo -e " [\e[36m 30 \e[0m] Change Core Xray "
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
    trial-vmess
    ;;
2)
    clear
    add-vmess
    ;;
3)
    clear
    del-vmess
    ;;
4)
    clear
    renew-vmess
    ;;
5)
    clear
    cek-vmess
    ;;
6)
    clear
    trial-vless
    ;;
7)
    clear
    add-vless
    ;;
8)
    clear
    del-vless
    ;;
9)
    clear
    renew-vless
    ;;
10)
    clear
    cek-vless
    ;;
11)
    clear
    trial-trojan
    ;;
12)
    clear
    add-trojan
    ;;
13)
    clear
    del-trojan
    ;;
14)
    clear
    renew-trojan
    ;;
15)
    clear
    cek-trojan
    ;;
16)
    clear
    trial-shadowsocks
    ;;
17)
    clear
    add-shadowsocks
    ;;
18)
    clear
    del-shadowsocks
    ;;
19)
    clear
    renew-shadowsocks
    ;;
20)
    clear
    cek-shadowsocks
    ;;
21)
    clear
    trial_all
    ;;
22)
    clear
    certv2ray
    ;; 

23)
    clear
    check_port
    ;; 
24)
    clear
    running_1
    ;; 
25)
    clear
    cek-all
    ;; 
26)
    clear
    recreate-vless
    ;;
27)
    clear
    recreate-trojan
    ;;
28)
    clear
    recreate-vmess
    ;;
29)
    clear
    recreate-shadowsocks
    ;;  
30)
    clear
    core_xray
    ;;  
x)  clear
    menu
    ;;
*)
    clear
    echo -e ""
    echo "Sila Pilih Semula"
    sleep 1
    menu_xray
    ;;
esac
