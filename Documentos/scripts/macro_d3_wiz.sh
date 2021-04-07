#!/bin/bash
set -x
if [ $(pgrep macro_d3_wiz.sh | wc -l) -lt 3 ]; then
    while :;
    do
        xdotool key 5;        
        sleep 0.4;
    done
else
        killall -9 macro_d3_wiz.sh
fi



