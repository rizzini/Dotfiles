#!/bin/bash
sleep 10 &&
while [ -n "$(pgrep Diablo)" ]; do

    if [ $(xdotool getwindowfocus) -eq $(xdotool search --sync --name 'Diablo III') ]; then   
        if [ -z "$(pgrep xbindkeys)" ]; then
            xbindkeys
        fi
    else
        killall -9 macro_d3_wiz.sh
        killall -9 xbindkeys
    fi
    sleep 1
done
        
