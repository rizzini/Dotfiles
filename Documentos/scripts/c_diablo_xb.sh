#!/bin/bash
bash -c 'sleep 20 && /home/lucas/Documentos/scripts/c_diablo_xb_overlay.sh' &
sleep 10 &&
while [ -n "$(pgrep Diablo)" ]; do

    if [ $(xdotool getwindowfocus) -eq $(xdotool search --sync --name 'Diablo III') ]; then   
        if [ -z "$(pgrep xbindkeys)" ]; then
            xbindkeys
        fi
    else 
        killall -9 macro_d3_wiz.sh xdotool xbindkeys pqiv
    fi
    sleep 1
done
        
