#!/bin/bash
export XDG_RUNTIME_DIR=/run/user/1000;
export DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus;
export DISPLAY=:0;
if [[ -n "$1" && -n "$(DISPLAY=:0 /usr/bin/wmctrl -l | /usr/bin/grep  'Prime Video')"  ]];then
    /usr/bin/killall -9 anbox;
    /usr/bin/anbox session-manager --single-window --window-size=600,506 &
    /usr/bin/sleep 1;
    /usr/bin/wmctrl -r 'Anbox - Android in a Box' -e 0,961,543,-1,-1;
    while [ "$(pgrep anbox)" ];do
        /usr/bin/sleep 2;
    done

elif [[ -n "$1" && -z "$(DISPLAY=:0 /usr/bin/wmctrl -l | /usr/bin/grep  'Prime Video')"  ]];then
    /usr/bin/killall -9 anbox;
    /usr/bin/anbox session-manager --single-window --window-size=600,524 &
    /usr/bin/sleep 1;
    /usr/bin/wmctrl -r 'Anbox - Android in a Box' -e 0,961,525,-1,-1;
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
