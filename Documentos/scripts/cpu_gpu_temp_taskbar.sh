#!/bin/bash
clean_space_emergency(){
    if [ $(df -B MB  /dev/sda2 --output=avail | tail -1 | tr -d 'MB') -le 600 ];then
        sudo /home/lucas/Documentos/scripts/clean_space_emergency.sh &
        sleep 20;
    fi
}

/usr/bin/grep 'ENABLED=no' /etc/ufw/ufw.conf &> /dev/null
if [ $? -eq 0 ];then
    /usr/bin/echo 'Firewall desativado';
    clean_space_emergency;
    exit 0
fi
/usr/bin/printf "CPU: ""$(/usr/bin/echo $(/usr/bin/sensors | /usr/bin/grep 'Package id 0:' | /usr/bin/tail -1 | /usr/bin/cut -c 17-18))""ºc";
clean_space_emergency;
