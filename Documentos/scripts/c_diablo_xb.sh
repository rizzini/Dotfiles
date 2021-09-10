#!/bin/bash
killall -9 pqiv
if test -f /tmp/c_diablo_xb_macro_off.pid.tmp; then
    rm /tmp/c_diablo_xb_macro_off.pid.tmp
fi
if test -f /tmp/c_diablo_xb_macro_on.pid.tmp; then
    rm /tmp/c_diablo_xb_macro_on.pid.tmp
fi
sleep 10 &&
while [ -n "$(pgrep Diablo)" ]; do    
    if [ $(xdotool getwindowfocus) -eq $(xdotool search --sync --name 'Default - Wine desktop') ]; then       
        if [ -f "/tmp/c_diablo_xb_macro_on.pid.tmp" ]; then
            /home/lucas/Documentos/scripts/macro_d3_wiz.sh &
            aberto=0
        else 
            if [ -n "$(pgrep macro_d3_wiz.sh)" ]; then
                aberto=1
            else
                aberto=0
            fi   
        fi    
        if [ -z "$(pgrep xbindkeys)" ]; then
            xbindkeys
        fi
    if [ $aberto -eq 1 ]; then        
        if [[ -n "$(ps -aux | grep macro_off| grep wine_d3 | awk '{print $2;}')" && $(xdotool getwindowfocus) -eq $(xdotool search --sync --name 'Default - Wine desktop') ]]; then
            killall -9 pqiv
            pqiv --click-through --keep-above --transparent-background --hide-info-box '/home/lucas/.wine_d3/macro_on.png' &
        fi
    fi    
    if [ $aberto -eq 0 ]; then
        if [[ -z "$(ps -aux | grep macro_off| grep wine_d3 | awk '{print $2;}')" && $(xdotool getwindowfocus) -eq $(xdotool search --sync --name 'Default - Wine desktop') ]]; then
            killall -9 pqiv
            pqiv --click-through --keep-above --transparent-background --hide-info-box '/home/lucas/.wine_d3/macro_off.png' &
        fi
    fi
        if test -f /tmp/c_diablo_xb_macro_off.pid.tmp; then
            rm /tmp/c_diablo_xb_macro_off.pid.tmp
        fi
        if test -f /tmp/c_diablo_xb_macro_on.pid.tmp; then
            rm /tmp/c_diablo_xb_macro_on.pid.tmp
        fi
    else 
        if [ -n "$(ps -aux | grep macro_on | grep wine_d3 | awk '{print $2;}')" ]; then
            touch /tmp/c_diablo_xb_macro_on.pid.tmp
        elif [ -n "$(ps -aux | grep macro_off | grep wine_d3 | awk '{print $2;}')" ]; then
            touch /tmp/c_diablo_xb_macro_off.pid.tmp
        fi
        killall -9 macro_d3_wiz.sh xdotool xbindkeys pqiv
    fi
    sleep 4
done
