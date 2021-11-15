#!/bin/bash
if [ $(/usr/bin/pgrep macro_d3_wiz.sh | /usr/bin/wc -l) -lt 3 ]; then
    while :;
    do
#         if [ $(xdotool search --sync --name 'Diablo III') -eq $(xdotool getwindowfocus) ]; then 
#             xdotool key 5;        
#             sleep 2;
#         else
#             sleep 2;
#         fi
        /usr/bin/xdotool key 5;
        /usr/bin/sleep 1
    done
else
        /usr/bin/killall -9 macro_d3_wiz.sh
fi
