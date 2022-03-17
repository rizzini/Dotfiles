#!/bin/bash
/usr/bin/grep 'ENABLED=no' /etc/ufw/ufw.conf &> /dev/null
if [ $? -eq 0 ];then
    /usr/bin/echo 'Firewall desativado';
    exit 0
fi
/usr/bin/printf "CPU: ""$(/usr/bin/echo $(/usr/bin/sensors | /usr/bin/grep 'Package id 0:' | /usr/bin/tail -1 | /usr/bin/cut -c 17-18))""ºc"
