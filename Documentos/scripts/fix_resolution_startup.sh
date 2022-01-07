#!/bin/bash
if [[ "$(xrandr | grep 1080i)" =~ "*" ]];then
    xrandr --output HDMI1 --mode 1920x1080 --rate 60
fi
    
