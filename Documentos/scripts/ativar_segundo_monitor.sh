#!/bin/bash
startup=0
if [ "$1" == "startup" ]; then
#     sleep 2
    startup=1
fi


if [ ! $(xrandr | grep -w connected |  sed 's/ .*//' | wc -l) -eq 2 ]; then
    notify-send "Somente uma porta HDMI detectada."
    exit
fi

if [ -n "$(xrandr --listactivemonitors | grep 'HDMI-0')" ]; then
    xrandr --output HDMI-0 --off --output HDMI-1-1 --mode 1920x1080  
#     sleep 1
#     pacmd set-default-sink 1
#     sleep 1
#     pactl -- set-sink-volume 0 100%
#     sleep 1
#     pactl -- set-sink-volume 1 50%    
#     notify-send "Segunda saída HDMI ativada"
elif [ -n "$(xrandr --listactivemonitors | grep 'HDMI-1-1')" ]; then
#     pacmd set-default-sink 0
#     sleep 1
#     pactl -- set-sink-volume 0 50%
#     sleep 1
    xrandr --output HDMI-0 --auto --output HDMI-1-1 --off      
#     notify-send "Segunda saída HDMI desativada."
fi
if [ $startup -eq 1 ]; then
    /home/lucas/Documentos/scripts/ativar_segundo_monitor.sh &
fi