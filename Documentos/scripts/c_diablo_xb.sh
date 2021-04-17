#!/bin/bash
# bash -c 'sleep 20 && /home/lucas/Documentos/scripts/c_diablo_xb_overlay.sh' &
# sleep 10 &&
killall -9 pqiv
rm /tmp/c_diablo_xb_macro_off.pid.tmp  /tmp/c_diablo_xb_macro_on.pid.tmp
while [ -n "$(pgrep Diablo)" ]; do
    aberto=0       
    if [ -n "$(pgrep macro_d3_wiz.sh)" ]; then
        aberto=1
    else
        aberto=0
    fi   
    
    if [ $(xdotool getwindowfocus) -eq $(xdotool search --sync --name 'Diablo III') ]; then   
        if [ -z "$(pgrep xbindkeys)" ]; then
            xbindkeys
        fi
        if [ $aberto -eq 1 ]; then        
            if [[ -n "$(ps -aux | grep macro_off| grep wine_d3 | awk '{print $2;}')" && $(xdotool getwindowfocus) -eq $(xdotool search --sync --name 'Diablo III') ]]; then
            killall -9 pqiv
            pqiv --click-through --keep-above --transparent-background --hide-info-box '/home/lucas/.wine_d3/macro_on.png' &
        fi

    fi    
    if [ $aberto -eq 0 ]; then
        if [[ -z "$(ps -aux | grep macro_off| grep wine_d3 | awk '{print $2;}')" && $(xdotool getwindowfocus) -eq $(xdotool search --sync --name 'Diablo III') ]]; then
            killall -9 pqiv
            pqiv --click-through --keep-above --transparent-background --hide-info-box '/home/lucas/.wine_d3/macro_off.png' &
        fi
    fi
        
        rm /tmp/c_diablo_xb_macro_off.pid.tmp  /tmp/c_diablo_xb_macro_on.pid.tmp
    else 
        if [ -n "$(ps -aux | grep macro_on | grep wine_d3 | awk '{print $2;}')" ]; then
            touch /tmp/c_diablo_xb_macro_on.pid.tmp
        elif [ -n "$(ps -aux | grep macro_off | grep wine_d3 | awk '{print $2;}')" ]; then
            touch /tmp/c_diablo_xb_macro_off.pid.tmp
        fi
        killall -9 macro_d3_wiz.sh xdotool xbindkeys pqiv
    fi
    sleep 1
done
