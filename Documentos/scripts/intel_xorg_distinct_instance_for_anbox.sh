#!/bin/bash
if [ -z "$(lspci | grep '00:02.0 Display controller')" ];then
    sudo -u lucas XDG_RUNTIME_DIR=/run/user/1000 DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus notify-send  'iGPU desabilitada..'
    exit 1
fi
if [ "$(systemctl is-active intel_display.service)" == "active" ];then
    sudo -u lucas XDG_RUNTIME_DIR=/run/user/1000 DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus notify-send  'Anbox encerrado..'
    systemctl stop intel_display.service 
    systemctl stop anbox-container-manager.service
elif [[ "$(systemctl is-active intel_display.service)" == "inactive" || "$(systemctl is-active intel_display.service)" == "failed" ]];then
    sudo -u lucas XDG_RUNTIME_DIR=/run/user/1000 DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus notify-send  'Anbox iniciado..'
    systemctl restart anbox-container-manager.service
    systemctl restart intel_display.service 
    while [ -z "$(adb shell ps | grep whatsapp)" ];do
        sleep 1
    done
    sudo -u lucas XDG_RUNTIME_DIR=/run/user/1000 DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus notify-send  'WhatsApp inciado..'
fi
