#!/bin/bash

if [ "$(/usr/bin/systemctl is-active anbox.service)" == active ];
then

    /usr/bin/kill -9 $(pgrep WhatsApp)
    /usr/bin/systemctl stop anbox.service;

elif [ "$(/usr/bin/systemctl is-active anbox.service )" != active ];
then

    /usr/bin/systemctl start anbox &
    sleep 5 &&
    /usr/bin/sudo -u lucas DISPLAY=:0 XDG_RUNTIME_DIR=/run/user/1000 /opt/whatsapp-nativefier-dark/WhatsApp &
    
fi
