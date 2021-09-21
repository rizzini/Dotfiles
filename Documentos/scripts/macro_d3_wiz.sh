#!/bin/bash
if [ $(pgrep macro_d3_wiz.sh | wc -l) -lt 3 ]; then
    while :;
    do
#         if [ $(xdotool search --sync --name 'Diablo III') -eq $(xdotool getwindowfocus) ]; then 
#             xdotool key 5;        
#             sleep 0.4;
#         else
#             sleep 0.4;
#         fi
        xdotool key 5;
        sleep 0.4
    done
else
        killall -9 macro_d3_wiz.sh
fi
