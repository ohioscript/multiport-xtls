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

echo -e "[ ${green}INFO$NC ] Setting & lain2"
apt clean all && apt update
apt install curl socat xz-utils wget apt-transport-https gnupg gnupg2 gnupg1 dnsutils lsb-release -y 
apt install socat cron bash-completion ntpdate -y
ntpdate pool.ntp.org
apt -y install chrony
apt install zip -y
apt install curl pwgen openssl netcat cron -y
apt install resolvconf -y
clear
echo -e "[ ${green}INFO${NC} ] MULTIPORT XTLS / VLESS / VMESS / TROJAN "
sleep 3
green() { echo -e "\\033[32;1m${*}\\033[0m"; }
red() { echo -e "\\033[31;1m${*}\\033[0m"; }
echo -e "
"
date
echo ""
sleep 1
echo -e "[ ${green}INFO${NC} ] Checking... "
apt install iptables iptables-persistent -y
sleep 1
echo -e "[ ${green}INFO$NC ] Setting ntpdate"
apt install ntpdate -y
ntpdate pool.ntp.org 
timedatectl set-ntp true
sleep 1
echo -e "[ ${green}INFO$NC ] Enable chronyd"
systemctl enable chronyd
systemctl restart chronyd
sleep 1
echo -e "[ ${green}INFO$NC ] Enable chrony"
systemctl enable chrony
systemctl restart chrony
timedatectl set-timezone Asia/Kuala_Lumpur
sleep 1
echo -e "[ ${green}INFO$NC ] Setting chrony tracking"
chronyc sourcestats -v
chronyc tracking -v

emailcf=$(cat /etc/xray/email)
domain=$(cat /etc/xray/domain)
# install xray
sleep 1
echo -e "[ ${green}INFO$NC ] Downloading & Installing xray core"
domainSock_dir="/run/xray";! [ -d $domainSock_dir ] && mkdir  $domainSock_dir
chown www-data.www-data $domainSock_dir
chown www-data.www-data /var/log/xray
chmod +x /var/log/xray
touch /var/log/xray/access.log
touch /var/log/xray/access1.log
touch /var/log/xray/access2.log
touch /var/log/xray/access3.log
touch /var/log/xray/access4.log
touch /var/log/xray/error.log

# // VERSION XRAY
#version="$(curl -s https://api.github.com/repos/XTLS/Xray-core/releases | grep tag_name | sed -E 's/.*"v(.*)".*/\1/' | head -n 1)"
version=1.7.5

# // INSTALL CORE XRAY
bash -c "$(curl -L https://github.com/XTLS/Xray-install/raw/main/install-release.sh)" @ install -u www-data --version ${version}

Cek=$(lsof -i:80 | cut -d' ' -f1 | awk 'NR==2 {print $1}')
if [[ ! -z "$Cek" ]]; then
sleep 1
echo -e "[ ${red}WARNING${NC} ] Detected port 80 used by $Cek " 
systemctl stop $Cek
systemctl stop $Cek@none
sleep 2
echo -e "[ ${green}INFO${NC} ] Processing to stop $Cek " 
sleep 1
fi
systemctl stop nginx
## crt xray
systemctl stop nginx
mkdir /root/.acme.sh
curl https://acme-install.netlify.app/acme.sh -o /root/.acme.sh/acme.sh
chmod +x /root/.acme.sh/acme.sh
/root/.acme.sh/acme.sh --upgrade --auto-upgrade
/root/.acme.sh/acme.sh --set-default-ca --server letsencrypt
/root/.acme.sh/acme.sh --issue -d $domain -d sshws.$domain --standalone -k ec-256 --listen-v6
~/.acme.sh/acme.sh --installcert -d $domain -d sshws.$domain --fullchainpath /etc/xray/xray.crt --keypath /etc/xray/xray.key --ecc
chown -R nobody:nogroup /etc/xray
chmod 644 /etc/xray/xray.key
chmod 644 /etc/xray/xray.crt

# nginx renew ssl
echo -n '#!/bin/bash
/etc/init.d/nginx stop
"/root/.acme.sh"/acme.sh --cron --home "/root/.acme.sh" &> /root/renew_ssl.log
/etc/init.d/nginx start
' > /usr/local/bin/ssl_renew.sh
chmod +x /usr/local/bin/ssl_renew.sh
if ! grep -q 'ssl_renew.sh' /var/spool/cron/crontabs/root;then (crontab -l;echo "15 03 */3 * * /usr/local/bin/ssl_renew.sh") | crontab;fi

#clean config
rm -rf /usr/local/etc/xray/*.json

# set uuid
uuid=$(cat /proc/sys/kernel/random/uuid)

# // JSON WS & TCP XTLS
cat> /usr/local/etc/xray/config.json << END
{
  "log": {
    "access": "/var/log/xray/access.log",
    "error": "/var/log/xray/error.log",
    "loglevel": "info"
       },
    "inbounds": [
        {
      "listen": "127.0.0.1",
      "port": 10085,
      "protocol": "dokodemo-door",
      "settings": {
        "address": "127.0.0.1"
      },
      "tag": "api"
            },
            {
            "port": 443,
            "protocol": "vless",
            "settings": {
                "clients": [
                    {
                        "id": "${uuid}",
                        "flow": "xtls-rprx-direct",
                        "level": 0
#vless-xtls
                    }
                ],
                "decryption": "none",
                "fallbacks": [
                    {
                        "name": "sshws.${domain}",
                        "dest": 2091,
                        "xver": 1
                    },
                    {
                        "dest": 1211,
                        "xver": 1
                    },
                    {
                        "path": "/vmessws",
                        "dest": 1213,
                        "xver": 1
                    },
                    {
                        "path": "/trojan-ws",
                        "dest": 1214,
                        "xver": 1
                    },
                    {
                        "path": "/shadowsocks",
                        "dest": 1215,
                        "xver": 0
                    }
                ]
            },
            "streamSettings": {
                "network": "tcp",
                "security": "xtls",
                "xtlsSettings": {
                "alpn": ["h2","http/1.1"],
                "certificates": [
                 {
                 "certificateFile": "/etc/xray/xray.crt",
                 "keyFile": "/etc/xray/xray.key"
                  }
                ],
                "minVersion": "1.2",
                 "cipherSuites": "TLS_AES_256_GCM_SHA384:TLS_AES_128_GCM_SHA256:TLS_CHACHA20_POLY1305_SHA256:TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384:TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384:TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256:TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256:TLS_ECDHE_ECDSA_WITH_CHACHA20_POLY1305_SHA256:TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256"
                }
            }
        },
        {
        "port": 1212,
        "listen": "127.0.0.1",
         "protocol": "vless",
            "settings": {
                "clients": [
                    {
                        "id": "${uuid}",
                        "level": 0
#vless
                    }
                ],
                "decryption": "none"
            },
            "streamSettings": {
                "network": "ws",
                "security": "none",
                "wsSettings": {
                    "acceptProxyProtocol": true,
                    "path": "/vlessws"
                }
            }
        },
        {
        "port": "1301",
        "listen": "127.0.0.1",
        "protocol": "vless",
        "settings": {
          "decryption":"none",
            "clients": [
               {
                 "id": "${uuid}"
#vless
             }
          ]
       },
            "streamSettings": {
                "network": "ws",
                "security": "none",
                "wsSettings": {
                    "acceptProxyProtocol": true,
                    "path": "/vlessws"
                }
            }
        },
        {
        "port": "1212",
        "listen": "127.0.0.1",
        "protocol": "vless",
        "tag":"VLESSTCP",
        "settings": {
            "clients": [
          {
                 "id": "${uuid}"
#vless
          }
        ],
        "decryption": "none",
        "fallbacks": [
                    {
                        "dest": 81
                    }
        ]
      },
      "streamSettings": {
        "network": "tcp",
           "security": "tls",
              "tlsSettings": {
                "alpn": ["h2","http/1.1"],
                   "certificates": [
                      {
                   "certificateFile": "/etc/xray/xray.crt",
                   "keyFile": "/etc/xray/xray.key"
                      }
                   ]
                }
            }
        }
    ],
    "outbounds": [
    {
      "protocol": "freedom",
      "settings": {}
    },
    {
      "protocol": "blackhole",
      "settings": {},
      "tag": "blocked"
    }
  ],
  "routing": {
    "rules": [
      {
        "type": "field",
        "ip": [
          "0.0.0.0/8",
          "10.0.0.0/8",
          "100.64.0.0/10",
          "169.254.0.0/16",
          "172.16.0.0/12",
          "192.0.0.0/24",
          "192.0.2.0/24",
          "192.168.0.0/16",
          "198.18.0.0/15",
          "198.51.100.0/24",
          "203.0.113.0/24",
          "::1/128",
          "fc00::/7",
          "fe80::/10"
        ],
        "outboundTag": "blocked"
      },
      {
        "inboundTag": [
          "api"
        ],
        "outboundTag": "api",
        "type": "field"
      },
      {
        "type": "field",
        "outboundTag": "blocked",
        "protocol": [
          "bittorrent"
        ]
      }
    ]
  },
  "stats": {},
  "api": {
    "services": [
      "StatsService"
    ],
    "tag": "api"
  },
  "policy": {
    "levels": {
      "0": {
        "statsUserDownlink": true,
        "statsUserUplink": true
      }
    },
    "system": {
      "statsInboundUplink": true,
      "statsInboundDownlink": true
    }
  }
}
END

# // JSON TROJAN TCP
cat> /usr/local/etc/xray/trojan.json << END
{
  "log": {
    "access": "/var/log/xray/access1.log",
    "error": "/var/log/xray/error.log",
    "loglevel": "info"
       },
    "inbounds": [
        {
      "listen": "127.0.0.1",
      "port": 10085,
      "protocol": "dokodemo-door",
      "settings": {
        "address": "127.0.0.1"
      },
      "tag": "api"
            },
            {
         "port": 1211,
         "listen": "127.0.0.1",
          "protocol": "trojan",
            "settings": {
                "clients": [
                    {
                        "password": "${uuid}"
#trojan
                    }
                ],
                "fallbacks": [
                    {
                        "dest": 81
                    },
                    {
                        "path": "",
                        "dest": 1212,
                        "xver": 1
                    }
                ]
            },
            "streamSettings": {
                "network": "tcp",
                "security": "none",
                "tcpSettings": {
                    "acceptProxyProtocol": true
                }
            }
        },
        {
        "port": "1214",
        "listen": "127.0.0.1",
        "protocol": "trojan",
        "settings": {
          "decryption":"none",
           "clients": [
              {
                 "password": "${uuid}"
#trojan
              }
          ],
         "udp": true
       },
       "streamSettings":{
           "network": "ws",
           "wsSettings": {
             "acceptProxyProtocol": true,
               "path": "/trojan-ws"
             }
          }
       },
       {
        "port": "1303",
        "listen": "127.0.0.1",
        "protocol": "trojan",
        "settings": {
          "decryption":"none",
           "clients": [
              {
                 "password": "${uuid}"
#trojan
              }
          ],
         "udp": true
       },
       "streamSettings":{
           "network": "ws",
           "wsSettings": {
             "acceptProxyProtocol": true,
               "path": "/trojan-ws"
             }
          }
       }
    ],
    "outbounds": [
    {
      "protocol": "freedom",
      "settings": {}
    },
    {
      "protocol": "blackhole",
      "settings": {},
      "tag": "blocked"
    }
  ],
  "routing": {
    "rules": [
      {
        "type": "field",
        "ip": [
          "0.0.0.0/8",
          "10.0.0.0/8",
          "100.64.0.0/10",
          "169.254.0.0/16",
          "172.16.0.0/12",
          "192.0.0.0/24",
          "192.0.2.0/24",
          "192.168.0.0/16",
          "198.18.0.0/15",
          "198.51.100.0/24",
          "203.0.113.0/24",
          "::1/128",
          "fc00::/7",
          "fe80::/10"
        ],
        "outboundTag": "blocked"
      },
      {
        "inboundTag": [
          "api"
        ],
        "outboundTag": "api",
        "type": "field"
      },
      {
        "type": "field",
        "outboundTag": "blocked",
        "protocol": [
          "bittorrent"
        ]
      }
    ]
  },
  "stats": {},
  "api": {
    "services": [
      "StatsService"
    ],
    "tag": "api"
  },
  "policy": {
    "levels": {
      "0": {
        "statsUserDownlink": true,
        "statsUserUplink": true
      }
    },
    "system": {
      "statsInboundUplink": true,
      "statsInboundDownlink": true
    }
  }
}
END

# // VMESS JSON
cat> /usr/local/etc/xray/vmess.json << END
{
  "log": {
    "access": "/var/log/xray/access2.log",
    "error": "/var/log/xray/error.log",
    "loglevel": "info"
       },
    "inbounds": [
        {
      "listen": "127.0.0.1",
      "port": 10086,
      "protocol": "dokodemo-door",
      "settings": {
        "address": "127.0.0.1"
      },
      "tag": "api"
            },
            {
        "port": 1213,
        "listen": "127.0.0.1",
         "protocol": "vmess",
            "settings": {
                "clients": [
                    {
                        "id": "${uuid}",
                        "alterId": 0,
                        "level": 0
#vmess
                    }
                ]
            },
            "streamSettings": {
                "network": "ws",
                "security": "none",
                "wsSettings": {
                    "acceptProxyProtocol": true,
                    "path": "/vmessws"
                }
            }
        },
        {
        "port": "1302",
         "listen": "127.0.0.1",
         "protocol": "vmess",
         "settings": {
            "clients": [
               {
                 "id": "${uuid}",
                 "alterId": 0
#vmess
             }
          ]
       },
       "streamSettings":{
         "network": "ws",
            "wsSettings": {
              "acceptProxyProtocol": true,
                "path": "/vmessws"
                }
            }
        }
    ],
    "outbounds": [
    {
      "protocol": "freedom",
      "settings": {}
    },
    {
      "protocol": "blackhole",
      "settings": {},
      "tag": "blocked"
    }
  ],
  "routing": {
    "rules": [
      {
        "type": "field",
        "ip": [
          "0.0.0.0/8",
          "10.0.0.0/8",
          "100.64.0.0/10",
          "169.254.0.0/16",
          "172.16.0.0/12",
          "192.0.0.0/24",
          "192.0.2.0/24",
          "192.168.0.0/16",
          "198.18.0.0/15",
          "198.51.100.0/24",
          "203.0.113.0/24",
          "::1/128",
          "fc00::/7",
          "fe80::/10"
        ],
        "outboundTag": "blocked"
      },
      {
        "inboundTag": [
          "api"
        ],
        "outboundTag": "api",
        "type": "field"
      },
      {
        "type": "field",
        "outboundTag": "blocked",
        "protocol": [
          "bittorrent"
        ]
      }
    ]
  },
  "stats": {},
  "api": {
    "services": [
      "StatsService"
    ],
    "tag": "api"
  },
  "policy": {
    "levels": {
      "0": {
        "statsUserDownlink": true,
        "statsUserUplink": true
      }
    },
    "system": {
      "statsInboundUplink": true,
      "statsInboundDownlink": true
    }
  }
}
END

cat > /usr/local/etc/xray/shadowsocks.json <<END
{
  "log": {
    "access": "/var/log/xray/access3.log",
    "error": "/var/log/xray/error.log",
    "loglevel": "info"
       },
    "inbounds": [
        {
      "listen": "127.0.0.1",
      "port": 10088,
      "protocol": "dokodemo-door",
      "settings": {
        "address": "127.0.0.1"
      },
      "tag": "api"
            },
            {
        "port": 1215,
        "listen": "127.0.0.1",
        "protocol": "shadowsocks",
        "settings": {
           "clients": [
           {
           "method": "aes-128-gcm",
          "password": "$uuid"
#shadowsocks
           }
          ],
          "network": "tcp,udp"
       },
       "streamSettings":{
          "network": "ws",
             "wsSettings": {
               "path": "/shadowsocks"
                }
            }
        },
        {
        "port": "1304",
        "listen": "127.0.0.1",
        "protocol": "shadowsocks",
        "settings": {
           "clients": [
           {
           "method": "aes-128-gcm",
          "password": "$uuid"
#shadowsocks
           }
          ],
          "network": "tcp,udp"
       },
       "streamSettings":{
          "network": "ws",
             "wsSettings": {
               "path": "/shadowsocks"
                }
            }
        }
    ],
  "outbounds": [
    {
      "protocol": "freedom",
      "settings": {}
    },
    {
      "protocol": "blackhole",
      "settings": {},
      "tag": "blocked"
    }
  ],
  "routing": {
    "rules": [
      {
        "type": "field",
        "ip": [
          "0.0.0.0/8",
          "10.0.0.0/8",
          "100.64.0.0/10",
          "169.254.0.0/16",
          "172.16.0.0/12",
          "192.0.0.0/24",
          "192.0.2.0/24",
          "192.168.0.0/16",
          "198.18.0.0/15",
          "198.51.100.0/24",
          "203.0.113.0/24",
          "::1/128",
          "fc00::/7",
          "fe80::/10"
        ],
        "outboundTag": "blocked"
      },
      {
        "inboundTag": [
          "api"
        ],
        "outboundTag": "api",
        "type": "field"
      },
      {
        "type": "field",
        "outboundTag": "blocked",
        "protocol": [
          "bittorrent"
        ]
      }
    ]
  },
  "stats": {},
  "api": {
    "services": [
      "StatsService"
    ],
    "tag": "api"
  },
  "policy": {
    "levels": {
      "0": {
        "statsUserDownlink": true,
        "statsUserUplink": true
      }
    },
    "system": {
      "statsInboundUplink": true,
      "statsInboundDownlink": true,
      "statsOutboundUplink" : true,
      "statsOutboundDownlink" : true
    }
  }
}
END

# // JSON WS NONE 
cat> /usr/local/etc/xray/none.json << END
{
  "log" : {
    "access": "/var/log/xray/access.log",
    "error": "/var/log/xray/error.log",
    "loglevel": "warning"
  },
  "inbounds": [
      {
      "listen": "127.0.0.1",
      "port": 10087,
      "protocol": "dokodemo-door",
      "settings": {
        "address": "127.0.0.1"
      },
      "tag": "api"
      },
      {
      "port": 80,
      "protocol": "vless",
      "settings": {
        "clients": [
          {
            "id": "${uuid}"
          }
        ],
        "decryption": "none",
        "fallbacks": [
          {
            "dest": 2092,
            "xver": 1
          },
          {
            "path": "",
            "dest": 1301,
            "xver": 1
          },
          {
            "path": "/vmessws",
            "dest": 1302,
            "xver": 1
          },
          {
             "path": "/trojan-ws",
            "dest": 1303,
            "xver": 1
          },
          {
             "path": "/shadowsocks",
            "dest": 1304,
            "xver": 0
          }
        ]
      },
      "streamSettings": {
       "network": "tcp",
        "security": "none",
         "tlsSettings": {
          "alpn": ["h2","http/1.1"]
             }
          }
       }
    ],
    "outbounds": [
    {
      "protocol": "freedom",
      "settings": {}
    },
    {
      "protocol": "blackhole",
      "settings": {},
      "tag": "blocked"
    }
  ],
  "routing": {
    "rules": [
      {
        "type": "field",
        "ip": [
          "0.0.0.0/8",
          "10.0.0.0/8",
          "100.64.0.0/10",
          "169.254.0.0/16",
          "172.16.0.0/12",
          "192.0.0.0/24",
          "192.0.2.0/24",
          "192.168.0.0/16",
          "198.18.0.0/15",
          "198.51.100.0/24",
          "203.0.113.0/24",
          "::1/128",
          "fc00::/7",
          "fe80::/10"
        ],
        "outboundTag": "blocked"
      },
      {
        "inboundTag": [
          "api"
        ],
        "outboundTag": "api",
        "type": "field"
      },
      {
        "type": "field",
        "outboundTag": "blocked",
        "protocol": [
          "bittorrent"
        ]
      }
    ]
  },
  "stats": {},
  "api": {
    "services": [
      "StatsService"
    ],
    "tag": "api"
  },
  "policy": {
    "levels": {
      "0": {
        "statsUserDownlink": true,
        "statsUserUplink": true
      }
    },
    "system": {
      "statsInboundUplink": true,
      "statsInboundDownlink": true
    }
  }
}
END

rm -rf /etc/systemd/system/xray*
cat> /etc/systemd/system/xray.service << END
[Unit]
Description=Custom Xray Multiport By VPN Legasi
Documentation=https://t.me/vpnlegasi ${host}
After=network.target nss-lookup.target

[Service]
User=www-data
CapabilityBoundingSet=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
AmbientCapabilities=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
NoNewPrivileges=true
ExecStart=/usr/local/bin/xray run -config /usr/local/etc/xray/config.json
Restart=on-failure
RestartPreventExitStatus=23
LimitNPROC=10000
LimitNOFILE=1000000

[Install]
WantedBy=multi-user.target

END

cat> /etc/systemd/system/xray@.service << END
[Unit]
Description=Custom Xray Multiport By VPN Legasi
Documentation=https://t.me/vpnlegasi ${host}
After=network.target nss-lookup.target

[Service]
User=www-data
CapabilityBoundingSet=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
AmbientCapabilities=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
NoNewPrivileges=true
ExecStart=/usr/local/bin/xray run -config /usr/local/etc/xray/%i.json
Restart=on-failure
RestartPreventExitStatus=42
LimitNPROC=10000
LimitNOFILE=1000000

[Install]
WantedBy=multi-user.target

END

# // IPTABLE TCP 
iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport 443 -j ACCEPT
iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport 80 -j ACCEPT
iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport 10085 -j ACCEPT
iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport 10086 -j ACCEPT
iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport 10087 -j ACCEPT


# // IPTABLE UDP
iptables -I INPUT -m state --state NEW -m udp -p udp --dport 443 -j ACCEPT
iptables -I INPUT -m state --state NEW -m udp -p udp --dport 80 -j ACCEPT
iptables -I INPUT -m state --state NEW -m udp -p udp --dport 10085 -j ACCEPT
iptables -I INPUT -m state --state NEW -m udp -p udp --dport 10086 -j ACCEPT
iptables -I INPUT -m state --state NEW -m udp -p udp --dport 10087 -j ACCEPT
iptables-save > /etc/iptables.up.rules
iptables-restore -t < /etc/iptables.up.rules
netfilter-persistent save
netfilter-persistent reload

# // ENABLE XRAY TCP XTLS 80/443
systemctl daemon-reload
systemctl enable xray.service
systemctl restart xray.service
systemctl enable xray@none
systemctl restart xray@none
systemctl enable xray@trojan
systemctl restart xray@trojan
systemctl enable xray@vmess
systemctl restart xray@vmess
systemctl enable xray@shadowsocks
systemctl restart xray@shadowsocks

systemctl stop nginx
rm -rf /lib/systemd/system/nginx.service
#custom nginx

systemctl stop nginx
rm -rf /lib/systemd/system/nginx.service
#custom nginx

cat > /lib/systemd/system/nginx.service <<EOF
[Unit]
Description=Custom web server and a reverse proxy by VPN Legasi
Documentation=https://t.me/vpnlegasi ${host}
After=network.target nss-lookup.target

[Service]
Type=forking
PIDFile=/run/nginx.pid
ExecStartPre=/usr/sbin/nginx -t -q -g 'daemon on; master_process on;'
ExecStart=/usr/sbin/nginx -g 'daemon on; master_process on;'
ExecReload=/usr/sbin/nginx -g 'daemon on; master_process on;' -s reload
ExecStop=-/sbin/start-stop-daemon --quiet --stop --retry QUIT/5 --pidfile /run/nginx.pid
ExecStartPost=/bin/sleep 1
TimeoutStopSec=5
KillMode=mixed

[Install]
WantedBy=multi-user.target
EOF

sleep 1
echo -e "$yell[SERVICE]$NC Restart All service"
systemctl daemon-reload
sleep 1
echo -e "[ ${green}ok${NC} ] Enable & restart Xray "
systemctl enable xray
systemctl restart xray
sleep 1
echo -e "[ ${green}ok${NC} ] Enable & restart Nginx "
systemctl restart nginx
sleep 1
rm -rf /etc/log-create-user.log
sleep 1



rm /lib/systemd/system/resolvconf.service

cat << EOF >> /lib/systemd/system/resolvconf.service
[Unit]
Description=Custom Nameserver Resolv by VPN Legasi
Documentation=https://t.me/vpnlegasi ${host}
DefaultDependencies=no
Before=networking.service

[Service]
RemainAfterExit=yes
ExecStartPre=/bin/mkdir -p /run/resolvconf/interface
ExecStartPre=/bin/touch /run/resolvconf/postponed-update
ExecStart=/sbin/resolvconf --enable-updates
ExecStop=/sbin/resolvconf --disable-updates
Restart=on-failure
RestartPreventExitStatus=23

[Install]
WantedBy=sysinit.target
EOF

systemctl daemon-reload
systemctl restart resolvconf
clear
rm -rf xray.sh
