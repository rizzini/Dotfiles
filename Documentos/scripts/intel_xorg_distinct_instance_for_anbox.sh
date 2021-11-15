#!/bin/bash
if [ -z "$(/usr/bin/lspci | /usr/bin/grep '00:02.0 Display controller')" ];then
    /usr/bin/sudo -u lucas XDG_RUNTIME_DIR=/run/user/1000 DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus /usr/bin/notify-send  'iGPU desabilitada..'
    exit 1
fi
if [ "$(/usr/bin/systemctl is-active intel_display.service)" == "active" ];then
    /usr/bin/sudo -u lucas XDG_RUNTIME_DIR=/run/user/1000 DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus /usr/bin/notify-send  'Anbox encerrado..'
    /usr/bin/systemctl stop intel_display.service 
    /usr/bin/systemctl stop anbox-container-manager.service
elif [[ "$(/usr/bin/systemctl is-active intel_display.service)" == "inactive" || "$(/usr/bin/systemctl is-active intel_display.service)" == "failed" ]];then
    /usr/bin/sudo -u lucas XDG_RUNTIME_DIR=/run/user/1000 DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus /usr/bin/notify-send  'Anbox iniciado..'
    /usr/bin/systemctl restart anbox-container-manager.service
    /usr/bin/systemctl restart intel_display.service 
    while [ -z "$(/usr/bin/adb shell ps | /usr/bin/grep whatsapp)" ];do
        /usr/bin/sleep 1
    done
    /usr/bin/sudo -u lucas XDG_RUNTIME_DIR=/run/user/1000 DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus /usr/bin/notify-send  'WhatsApp inciado..'
fi
