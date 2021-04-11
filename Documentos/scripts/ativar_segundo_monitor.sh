#!/bin/bash


if [ ! $(xrandr | grep -w connected |  sed 's/ .*//' | wc -l) -eq 2 ]; then
    notify-send "Somente uma porta HDMI detectada."
    exit
fi

if [ $(xrandr --listactivemonitors | head -1 | cut -c 11-11) -eq 1 ]; then
    xrandr --output HDMI-0 --auto --output HDMI-1-1 --same-as HDMI-0 --mode 1920x1080  
#     sleep 1
#     pacmd set-default-sink 1
#     sleep 1
#     pactl -- set-sink-volume 0 100%
#     sleep 1
#     pactl -- set-sink-volume 1 50%    
    notify-send "Segunda saída HDMI ativada"
elif [ $(xrandr --listactivemonitors | head -1 | cut -c 11-11) -eq 2 ]; then
#     pacmd set-default-sink 0
#     sleep 1
#     pactl -- set-sink-volume 0 50%
#     sleep 1
    xrandr --output HDMI-0 --auto --output HDMI-1-1 --off      
    notify-send "Segunda saída HDMI desativada."
fi

