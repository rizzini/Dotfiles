#!/bin/bash
/usr/bin/killall -9 pqiv
if test -f /tmp/c_diablo_xb_macro_off.pid.tmp; then
    /usr/bin/rm /tmp/c_diablo_xb_macro_off.pid.tmp
fi
if test -f /tmp/c_diablo_xb_macro_on.pid.tmp; then
    /usr/bin/rm /tmp/c_diablo_xb_macro_on.pid.tmp
fi
/usr/bin/sleep 10 &&
while [ -n "$(/usr/bin/pgrep Diablo)" ]; do    
    if [ $(/usr/bin/xdotool getwindowfocus) -eq $(/usr/bin/xdotool search --sync --name 'Default - Wine desktop') ]; then       
        if [ -f "/tmp/c_diablo_xb_macro_on.pid.tmp" ]; then
            /home/lucas/Documentos/scripts/macro_d3_wiz.sh &
            aberto=0
        else 
            if [ -n "$(/usr/bin/pgrep macro_d3_wiz.sh)" ]; then
                aberto=1
            else
                aberto=0
            fi   
        fi    
        if [ -z "$(/usr/bin/pgrep xbindkeys)" ]; then
            /usr/bin/xbindkeys
        fi
    if [ $aberto -eq 1 ]; then        
        if [[ -n "$(/usr/bin/ps -aux | /usr/bin/grep macro_off| /usr/bin/grep wine_d3 | /usr/bin/awk '{print $2;}')" && $(/usr/bin/xdotool getwindowfocus) -eq $(/usr/bin/xdotool search --sync --name 'Default - Wine desktop') ]]; then
            /usr/bin/killall -9 pqiv
            /usr/bin/pqiv --click-through --keep-above --transparent-background --hide-info-box '/home/lucas/.wine_d3/macro_on.png' &
        fi
    fi    
    if [ $aberto -eq 0 ]; then
        if [[ -z "$(/usr/bin/ps -aux | /usr/bin/grep macro_off| /usr/bin/grep wine_d3 | /usr/bin/awk '{print $2;}')" && $(/usr/bin/xdotool getwindowfocus) -eq $(/usr/bin/xdotool search --sync --name 'Default - Wine desktop') ]]; then
            /usr/bin/killall -9 pqiv
            /usr/bin/pqiv --click-through --keep-above --transparent-background --hide-info-box '/home/lucas/.wine_d3/macro_off.png' &
        fi
    fi
        if test -f /tmp/c_diablo_xb_macro_off.pid.tmp; then
            /usr/bin/rm /tmp/c_diablo_xb_macro_off.pid.tmp
        fi
        if test -f /tmp/c_diablo_xb_macro_on.pid.tmp; then
            /usr/bin/rm /tmp/c_diablo_xb_macro_on.pid.tmp
        fi
    else 
        if [ -n "$(/usr/bin/ps -aux | /usr/bin/grep macro_on | /usr/bin/grep wine_d3 | /usr/bin/awk '{print $2;}')" ]; then
            /usr/bin/touch /tmp/c_diablo_xb_macro_on.pid.tmp
        elif [ -n "$(/usr/bin/ps -aux | /usr/bin/grep macro_off | /usr/bin/grep wine_d3 | /usr/bin/awk '{print $2;}')" ]; then
            /usr/bin/touch /tmp/c_diablo_xb_macro_off.pid.tmp
        fi
        /usr/bin/killall -9 macro_d3_wiz.sh xdotool xbindkeys pqiv
    fi
    /usr/bin/sleep 4
done
