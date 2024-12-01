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

# By VPN Legasi
#
# ==================================================

# initializing var
export DEBIAN_FRONTEND=noninteractive
MYIP=$(wget -qO- ipinfo.io/ip);
MYIP2="s/xxxxxxxxx/$MYIP/g";
name="@vpnlegasi"
name2="s/xxxx12xxxxx/$name/g"
NET=$(ip -o $ANU -4 route show to default | awk '{print $5}');
source /etc/os-release
ver=$VERSION_ID

#detail nama perusahaan
country=MY
state=Malaysia
locality=Malaysia
organization=${host}
organizationalunit=${host}
commonname=${host}
email=$( cat /root/xray/email)

# simple password minimal
wget -O /etc/pam.d/common-password "${gitlink}/${resourses}/password"
chmod +x /etc/pam.d/common-password

# go to root
cd

# Edit file /etc/systemd/system/rc-local.service
cat > /etc/systemd/system/rc-local.service <<-END
[Unit]
Description=/etc/rc.local
ConditionPathExists=/etc/rc.local
[Service]
Type=forking
ExecStart=/etc/rc.local start
TimeoutSec=0
StandardOutput=tty
RemainAfterExit=yes
SysVStartPriority=99
[Install]
WantedBy=multi-user.target
END

# nano /etc/rc.local
cat > /etc/rc.local <<-END
#!/bin/sh -e
# rc.local
# By default this script does nothing.
exit 0
END

# Ubah izin akses
chmod +x /etc/rc.local

# enable rc local
systemctl enable rc-local
systemctl start rc-local.service

# disable ipv6
echo 1 > /proc/sys/net/ipv6/conf/all/disable_ipv6
sed -i '$ i\echo 1 > /proc/sys/net/ipv6/conf/all/disable_ipv6' /etc/rc.local

#update
apt update -y
apt upgrade -y
apt dist-upgrade -y
apt-get remove --purge ufw firewalld -y
apt-get remove --purge exim4 -y

# install wget and curl
apt -y install wget curl

# set time GMT +7
ln -fs /usr/share/zoneinfo/Asia/Kuala_Lumpur /etc/localtime

# set locale
sed -i 's/AcceptEnv/#AcceptEnv/g' /etc/ssh/sshd_config

# install
apt-get --reinstall --fix-missing install -y linux-headers-cloud-amd64 bzip2 gzip coreutils wget screen rsyslog iftop htop net-tools zip unzip wget net-tools curl nano sed screen gnupg gnupg1 bc apt-transport-https build-essential dirmngr libxml-parser-perl neofetch git lsof


# install webserver
apt -y install nginx
cd
mkdir /etc/systemd/system/nginx.service.d
printf "[Service]\nExecStartPost=/bin/sleep 0.1\n" | tee /etc/systemd/system/nginx.service.d/override.conf
rm /etc/nginx/sites-enabled/default
rm /etc/nginx/sites-available/default
rm /etc/nginx/nginx.conf
cat << EOF >> /etc/nginx/nginx.conf
user www-data;

worker_processes 1;
pid /var/run/nginx.pid;

events {
	multi_accept on;
  worker_connections 1024;
}

http {
	gzip on;
	gzip_vary on;
	gzip_comp_level 5;
	gzip_types    text/plain application/x-javascript text/xml text/css;

	autoindex on;
  sendfile on;
  tcp_nopush on;
  tcp_nodelay on;
  keepalive_timeout 65;
  types_hash_max_size 2048;
  server_tokens off;
  include /etc/nginx/mime.types;
  default_type application/octet-stream;
  access_log /var/log/nginx/access.log;
  error_log /var/log/nginx/error.log;
  client_max_body_size 32M;
	client_header_buffer_size 8m;
	large_client_header_buffers 8 8m;

	fastcgi_buffer_size 8m;
	fastcgi_buffers 8 8m;

	fastcgi_read_timeout 600;

	set_real_ip_from 204.93.240.0/24;
	set_real_ip_from 204.93.177.0/24;
	set_real_ip_from 199.27.128.0/21;
	set_real_ip_from 173.245.48.0/20;
	set_real_ip_from 103.21.244.0/22;
	set_real_ip_from 103.22.200.0/22;
	set_real_ip_from 103.31.4.0/22;
	set_real_ip_from 141.101.64.0/18;
	set_real_ip_from 108.162.192.0/18;
	set_real_ip_from 190.93.240.0/20;
	set_real_ip_from 188.114.96.0/20;
	set_real_ip_from 197.234.240.0/22;
	set_real_ip_from 198.41.128.0/17;
	real_ip_header     CF-Connecting-IP;

  include /etc/nginx/conf.d/*.conf;
}
EOF

mkdir -p /home/vps/public_html
rm /etc/nginx/conf.d/vps.conf
cat << EOF >> /etc/nginx/conf.d/vps.conf
server {
  listen       81;
  server_name  127.0.0.1 localhost;
  access_log /var/log/nginx/vps-access.log;
  error_log /var/log/nginx/vps-error.log error;
  root   /home/vps/public_html;

  location / {
    index  index.html index.htm index.php;
    try_files AAA AAA/ /index.php?BBB;
  }

  location ~ \.CCC {
    include /etc/nginx/fastcgi_params;
    fastcgi_pass  127.0.0.1:9000;
    fastcgi_index index.php;
    fastcgi_param SCRIPT_FILENAME DDD;
  }
}

server
{
        listen 127.0.0.1:60000 proxy_protocol;
        listen 127.0.0.1:60001 http2 proxy_protocol;
        server_name 127.0.0.1 localhost;
        index index.html index.htm index.php default.php default.htm default.html;
        root /home/vps/public_html;
        add_header Strict-Transport-Security "max-age=63072000" always;

        location ~ .*\.(gif|jpg|jpeg|png|bmp|swf)FFF
        {
                expires   30d;
                error_log off;
        }

        location ~ .*\.(js|css)?FFF
        {
                expires   12h;
                error_log off;
        }
}
EOF
sed -i 's/AAA/$uri/g' /etc/nginx/conf.d/vps.conf
sed -i 's/BBB/$args/g' /etc/nginx/conf.d/vps.conf
sed -i 's/CCC/php$/g' /etc/nginx/conf.d/vps.conf
sed -i 's/DDD/$document_root$fastcgi_script_name/g' /etc/nginx/conf.d/vps.conf
sed -i 's/FFF/$/g' /etc/nginx/conf.d/vps.conf
/etc/init.d/nginx restart

# install badvpn
cd
wget -O /usr/bin/badvpn-udpgw "${resourses}/badvpn-udpgw64"
chmod +x /usr/bin/badvpn-udpgw
sed -i '$ i\screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7100 --max-clients 500' /etc/rc.local
sed -i '$ i\screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7200 --max-clients 500' /etc/rc.local
sed -i '$ i\screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7300 --max-clients 500' /etc/rc.local
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7100 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7200 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7300 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7400 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7500 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7600 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7700 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7800 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7900 --max-clients 500

# // setting port ssh
cd
apt-get -y update
sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g'

# /etc/ssh/sshd_config
sed -i '/Port 22/a Port 500' /etc/ssh/sshd_config
sed -i '/Port 22/a Port 40000' /etc/ssh/sshd_config
sed -i '/Port 22/a Port 51443' /etc/ssh/sshd_config
sed -i '/Port 22/a Port 58080' /etc/ssh/sshd_config
sed -i '/Port 22/a Port 200' /etc/ssh/sshd_config
sed -i 's/#Port 22/Port 22/g' /etc/ssh/sshd_config
/etc/init.d/ssh restart

# install dropbear
apt -y install dropbear
sed -i 's/NO_START=1/NO_START=0/g' /etc/default/dropbear
sed -i 's/DROPBEAR_PORT=22/DROPBEAR_PORT=143/g' /etc/default/dropbear
sed -i 's/DROPBEAR_EXTRA_ARGS=/DROPBEAR_EXTRA_ARGS="-p 50000 -p 109 -p 68 -p 69 -p 110"/g' /etc/default/dropbear
echo "/bin/false" >> /etc/shells
echo "/usr/sbin/nologin" >> /etc/shells
/etc/init.d/dropbear restart

# install squid
cd
apt -y install squid3
apt -y install squid
rm /etc/squid/squid.conf
cat << EOF >> /etc/squid/squid.conf
acl manager proto cache_object
acl localhost src 127.0.0.1/32 ::1
acl to_localhost dst 127.0.0.0/8 0.0.0.0/32 ::1
acl SSL_ports port 442
acl Safe_ports port 80
acl Safe_ports port 21
acl Safe_ports port 443
acl Safe_ports port 70
acl Safe_ports port 210
acl Safe_ports port 1025-65535
acl Safe_ports port 280
acl Safe_ports port 488
acl Safe_ports port 591
acl Safe_ports port 777
acl Safe_ports port 888
acl Safe_ports port 222
acl CONNECT method CONNECT
acl SSH dst xxxxxxxxx
http_access allow SSH
http_access allow manager localhost
http_access deny manager
http_access allow localhost
http_access deny all
http_port 8080
http_port 3128
dns_v4_first on
coredump_dir /var/spool/squid3
refresh_pattern ^ftp: 1440 20% 10080
refresh_pattern ^gopher: 1440 0% 1440
refresh_pattern -i (/cgi-bin/|\?) 0 0% 0
refresh_pattern . 0 20% 4320
visible_hostname vpnlegasi
EOF
sed -i $MYIP2 /etc/squid/squid.conf

# setting vnstat
apt -y install vnstat
/etc/init.d/vnstat restart
apt -y install libsqlite3-dev
wget https://humdi.net/vnstat/vnstat-2.6.tar.gz
tar zxvf vnstat-2.6.tar.gz
cd vnstat-2.6
./configure --prefix=/usr --sysconfdir=/etc && make && make install
cd
vnstat -u -i $NET
sed -i 's/Interface "'""eth0""'"/Interface "'""$NET""'"/g' /etc/vnstat.conf
chown vnstat:vnstat /var/lib/vnstat -R
systemctl enable vnstat
/etc/init.d/vnstat restart
rm -f /root/vnstat-2.6.tar.gz
rm -rf /root/vnstat-2.6

# install stunnel
apt install stunnel4 -y
cat > /etc/stunnel/stunnel.conf <<-END
cert = /etc/stunnel/stunnel.pem
client = no
socket = a:SO_REUSEADDR=1
socket = l:TCP_NODELAY=1
socket = r:TCP_NODELAY=1

[dropbear]
accept = 777
connect = 127.0.0.1:22

[dropbear]
accept = 888
connect = 127.0.0.1:109

[openvpn]
accept = 442
connect = 127.0.0.1:1194

[vpnlegasi-stunnel]
accept = 2096
connect = 127.0.0.1:2091

END

# make a certificate
openssl genrsa -out key.pem 2048
openssl req -new -x509 -key key.pem -out cert.pem -days 1095 \
-subj "/C=$country/ST=$state/L=$locality/O=$organization/OU=$organizationalunit/CN=$commonname/emailAddress=$email"
cat key.pem cert.pem >> /etc/stunnel/stunnel.pem

# konfigurasi stunnel
sed -i 's/ENABLED=0/ENABLED=1/g' /etc/default/stunnel4
/lib/systemd/systemd-sysv-install enable stunnel4
/etc/init.d/stunnel4 restart

#OpenVPN
wget ${host}/script/${sc}/vpn.sh && chmod +x vpn.sh && ./vpn.sh

# install fail2ban
apt -y install fail2ban

# Instal DDOS Flate
if [ -d '/usr/local/ddos' ]; then
	echo; echo; echo "Please un-install the previous version first"
	exit 0
else
	mkdir /usr/local/ddos
fi
clear
echo; echo 'Installing DOS-Deflate 0.6'; echo
echo; echo -n 'Downloading source files...'
apt install -y dnsutils tcpdump dsniff grepcidr
wget -qO ddos.zip "${gitlink}/${resourses}/ddos-deflate.zip"
unzip ddos.zip
cd ddos-deflate
chmod +x install.sh
./install.sh
cd
rm -rf ddos.zip ddos-deflate
echo '...done'
echo; echo 'Installation has completed.'
echo 'Config file is at /usr/local/ddos/ddos.conf'
echo 'Please send in your comments and/or suggestions to https://t.me/vpnlegasi'

# banner /etc/issue.net
cat << EOF >> /etc/issue.net
<p style="text-align:center">
</font><font color="#ffa500"></b>===========================================<br>
</font><font color="red"><u><b> Server By xxxx12xxxxx </u></b></font><br>
</font><font color='#32CD32'><b> AUTOSCRIPT BY VPN LEGASI </b></br</font>
<br><font color='#860000'>NO SPAM !!!</br></font>
<br><font color='#1E90FF'>NO DDOS !!!</br></font>
<br><font color='#FF0000'>NO HACKING !!!</br></font>
<br><font color='#008080'>NO CARDING !!!</br></font>
<br><font color='#BA55D3'>NO TORRENT !!!</br></font>
<br><font color='#32CD32'>NO MULTI-LOGIN !!!</br></font>
<br><font color='#32CD32'>GUNA DENGAN BIJAK !!!</br></font>
<br></font><font color="red"><u><b>MELANGGAR PERATURAN AKAN DI BANNED </u></b></font><br>
</font><font color="#ffa500">===========================================<br>
EOF

sed -i $name2 /etc/issue.net
echo "Banner /etc/issue.net" >>/etc/ssh/sshd_config
sed -i 's@DROPBEAR_BANNER=""@DROPBEAR_BANNER="/etc/issue.net"@g' /etc/default/dropbear

# blockir torrent
iptables -A FORWARD -m string --string "get_peers" --algo bm -j DROP
iptables -A FORWARD -m string --string "announce_peer" --algo bm -j DROP
iptables -A FORWARD -m string --string "find_node" --algo bm -j DROP
iptables -A FORWARD -m string --algo bm --string "BitTorrent" -j DROP
iptables -A FORWARD -m string --algo bm --string "BitTorrent protocol" -j DROP
iptables -A FORWARD -m string --algo bm --string "peer_id=" -j DROP
iptables -A FORWARD -m string --algo bm --string ".torrent" -j DROP
iptables -A FORWARD -m string --algo bm --string "announce.php?passkey=" -j DROP
iptables -A FORWARD -m string --algo bm --string "torrent" -j DROP
iptables -A FORWARD -m string --algo bm --string "announce" -j DROP
iptables -A FORWARD -m string --algo bm --string "info_hash" -j DROP
iptables-save > /etc/iptables.up.rules
iptables-restore -t < /etc/iptables.up.rules
netfilter-persistent save
netfilter-persistent reload

# download script
cd /usr/bin
# menu
wget -O menu "${host}/script/${sc}/menu.sh"

# menu xray
wget -O menu_xray "${host}/script/${sc}/menu_xray.sh"

# menu ssh-ovpn
wget -O menu_ssh "${host}/script/${sc}/menu_ssh.sh"
wget -O ceklim "${host}/script/${sc}/ceklim.sh"
wget -O tendang "${host}/script/${sc}/tendang.sh"

# menu ssr
wget -O m-ssr "${host}/script/${sc}/m-ssr.sh"

# menu system
wget -O m-system "${host}/script/${sc}/m-system.sh"
wget -O autoupdate-sc "${host}/script/${sc}/autoupdate-sc.sh"

# menu system
wget -O ram "${gitlink}/${resourses}/ram.sh"
wget -O speedtest "${gitlink}/${resourses}/speedtest_cli.py"
wget -O webmin "${host}/script/${sc}/webmin.sh"
wget -O running "${host}/script/${sc}/running.sh"
wget -O bbr "${host}/script/${sc}/bbr.sh"
wget -O clear-log "${host}/script/${sc}/clear-log.sh"
wget -O kernel-update "${host}/script/${sc}/kernel-update.sh"
wget -O tweak "${host}/script/${sc}/tweak-tcp.sh"
wget -O tcp "${host}/script/${sc}/tcp.sh"
wget -O core_xray "${host}/script/${sc}/core_xray.sh"

# uNLOCATED
wget -O xp "${host}/script/${sc}/xp.sh"

chmod +x menu
chmod +x menu_xray
chmod +x menu_ssh
chmod +x ceklim
chmod +x tendang
chmod +x m-ssr
chmod +x m-system
chmod +x autoupdate-sc
chmod +x webmin
chmod +x running
chmod +x ram
chmod +x speedtest
chmod +x bbr
chmod +x clear-log
chmod +x xp
chmod +x kernel-update
chmod +x tweak
chmod +x tcp
chmod +x core_xray

echo "0 0 * * * root /sbin/hwclock -w   # synchronize hardware & system clock each day at 00:00 am" >> /etc/crontab
echo "0 */2 * * * root /usr/bin/clear-log # clear log every  two hours" >> /etc/crontab
echo "1 0 * * * root /usr/bin/xp # delete expired user" >> /etc/crontab
echo "2 0 * * * root /usr/bin/autoupdate-sc # check update sc" >> /etc/crontab

# remove unnecessary files
cd
apt autoclean -y
apt -y remove --purge unscd
apt-get -y --purge remove samba*;
apt-get -y --purge remove apache2*;
apt-get -y --purge remove bind9*;
apt-get -y remove sendmail*
apt autoremove -y
# finishing
cd
chown -R www-data:www-data /home/vps/public_html

squid_custom() {
rm -rf /lib/systemd/system/squid.service
cat << EOF >> /lib/systemd/system/squid.service
[Unit]
Description=Custom Squid Proxy By VPN Legasi
Documentation=https://t.me/vpnlegasi $host
After=network.target network-online.target nss-lookup.target

[Service]
Type=forking
PIDFile=/var/run/squid.pid
ExecStartPre=/usr/sbin/squid --foreground -z
Restart=on-failure
RestartPreventExitStatus=42
ExecStart=/usr/sbin/squid -sYC
ExecReload=/bin/kill -HUP AAA
KillMode=mixed

[Install]
WantedBy=multi-user.target
EOF
sed -i 's/AAA/$MAINPID/g' /lib/systemd/system/squid.service
}

os="$(cat /etc/os-release | grep 'ID=ubuntu' | cut -f2 -d=)"
if [[ $os == "ubuntu" ]]; then
  systemctl daemon-reload
  /etc/init.d/nginx restart
  /etc/init.d/openvpn restart
  /etc/init.d/cron restart
  /etc/init.d/ssh restart
  /etc/init.d/dropbear restart
  /etc/init.d/fail2ban restart
  /etc/init.d/stunnel4 restart
  /etc/init.d/vnstat restart
  /etc/init.d/squid restart
  screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7300 --max-clients 500
  history -c
  echo "unset HISTFILE" >> /etc/profile
else
  squid_custom
  systemctl daemon-reload
  /etc/init.d/nginx restart
  /etc/init.d/openvpn restart
  /etc/init.d/cron restart
  /etc/init.d/ssh restart
  /etc/init.d/dropbear restart
  /etc/init.d/fail2ban restart
  /etc/init.d/stunnel4 restart
  /etc/init.d/vnstat restart
  /etc/init.d/squid restart
  screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7300 --max-clients 500
  history -c
  echo "unset HISTFILE" >> /etc/profile
fi

cd
rm -f /root/key.pem
rm -f /root/cert.pem
rm -f /root/ssh-vpn.sh

# finihsing
clear
