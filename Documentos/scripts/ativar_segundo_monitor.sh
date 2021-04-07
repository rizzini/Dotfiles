#!/bin/bash


if [ ! $(xrandr | grep -w connected |  sed 's/ .*//' | wc -l) -eq 2 ]; then
    notify-send "Somente uma porta HDMI detectada."
    exit
fi

if [ $(xrandr --listactivemonitors | head -1 | cut -c 11-11) -eq 1 ]; then
    xrandr --output HDMI-0 --auto --output HDMI-1-1 --same-as HDMI-0 --mode 1920x1080  
    notify-send "Segunda saída HDMI ativada"
elif [ $(xrandr --listactivemonitors | head -1 | cut -c 11-11) -eq 2 ]; then
    xrandr --output HDMI-0 --auto --output HDMI-1-1 --off  
    notify-send "Segunda saída HDMI desativada."
fi

