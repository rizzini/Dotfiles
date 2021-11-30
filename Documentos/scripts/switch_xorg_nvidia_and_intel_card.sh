#!/bin/bash
if [ "$1" == 'nvidia' ];then 
    if [ -z "$(grep nvidia /etc/X11/xorg.conf)" ];then
        cp /etc/X11/nvidia/xorg.conf /etc/X11/xorg.conf;
        systemctl restart sddm;
    else
        /usr/bin/sudo -u lucas XDG_RUNTIME_DIR=/run/user/1000 DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus notify-send 'Você já usando NVIDIA.'
    fi
elif [ "$1" == 'intel' ];then 
    if [ -n "$(grep nvidia /etc/X11/xorg.conf)" ];then
        cp /etc/X11/intel/xorg.conf /etc/X11/xorg.conf;
        systemctl restart sddm
    else
        /usr/bin/sudo -u lucas XDG_RUNTIME_DIR=/run/user/1000 DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus notify-send 'Você já usando Intel.'
    fi
fi
