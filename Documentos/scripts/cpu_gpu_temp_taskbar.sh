#!/bin/bash
if /usr/bin/grep -q 'ENABLED=no' /etc/ufw/ufw.conf
then
    /usr/bin/echo 'Firewall desativado';
elif [ -n "$(pgrep easyeffects)" ];then
    /usr/bin/echo 'EasyEffects ligado'
else
    if [ "$(/usr/bin/sensors | /usr/bin/grep 'Package id 0:' | /usr/bin/tail -1 | /usr/bin/cut -c 17-18)" -ge 65 ];then
        /usr/bin/printf "CPU: ""$(/usr/bin/echo "$(/usr/bin/sensors | /usr/bin/grep 'Package id 0:' | /usr/bin/tail -1 | /usr/bin/cut -c 17-18)")""ºc";
    elif [ "$(/usr/bin/sensors | /usr/bin/grep 'Package id 0:' | /usr/bin/tail -1 | /usr/bin/cut -c 17-18)" == '00' ];then
        /usr/bin/printf "CPU: ""$(/usr/bin/sensors | /usr/bin/grep 'Package id 0:' | /usr/bin/tail -1 | /usr/bin/cut -c 17-18)""ºc";
    fi
fi
