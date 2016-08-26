#!/bin/bash
# zabbix redis monitor with discovery multi port
# cz20160826

VERSION=0.0.1

set -e
[[ "$DEBUG" ]] && set -x

[[ $UID -ne 0 ]] && {
    echo "must ne root to initialize work."
    exit 1
}

ZABBIX_DIR="/etc/zabbix/zabbix_agentd.d"
[[ ! -e $ZABBIX_DIR ]] && {
   echo "/etc/zabbix/zabbix_agentd.d not exists."
   exit 1
}

cp -a /usr/local/zabbix_redis/templates/userparameter_discovery_redis.conf $ZABBIX_DIR/
echo "1) # cp -a /usr/local/zabbix_redis/templates/userparameter_discovery_redis.conf $ZABBIX_DIR/"
echo
chmod +x /usr/local/zabbix_redis/bin/*.{sh}
echo "2) # chmod +x /usr/local/zabbix_redis/bin/*.{sh}"
echo
chmod +s /bin/netstat
echo "4) # chmod +s /bin/netstat"
echo
echo "Following command executed:"
echo "# chmod +s /bin/netstat "
echo "to avoid the error:"
echo "(Not all processes could be identified, non-owned process info"
echo " will not be shown, you would have to be root to see it all.)"
echo
SEL=`sestatus | grep 'SELinux status' | awk  '{print $3}'`
if [ "$SEL" = "enabled" ]; then
   setenforce 0
   echo "5) # setenforce 0"
   echo
fi
echo "install ok, restart zabbix_agent service manually."
echo 
