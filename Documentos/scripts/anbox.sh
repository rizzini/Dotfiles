#!/bin/bash
export XDG_RUNTIME_DIR=/run/user/1000;
export DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus;
export DISPLAY=:0;
if [ -n "$1" ];then
    /usr/bin/sleep 1;
    /usr/bin/anbox session-manager --single-window --window-size=600,526 &
    while [ "$(pgrep anbox)" ];do
        /usr/bin/sleep 2;
    done
fi

if [[ -z "$1" &&  "$(/usr/bin/systemctl is-active anbox.service)" == 'active' ]];then
    /usr/bin/sudo /usr/bin/systemctl stop anbox.service;
    /usr/bin/sudo /usr/bin/systemctl stop anbox-container-manager.service;

elif [[ -z "$1" &&  "$(/usr/bin/systemctl is-active anbox.service)" == 'inactive' || "$(/usr/bin/systemctl is-active anbox.service)" == 'failed' ]];then
    /usr/bin/sudo /usr/bin/systemctl start anbox-container-manager.service;
    /usr/bin/sleep 1;
    /usr/bin/sudo /usr/bin/systemctl start anbox.service;

fi
