#!/bin/bash
while [ -n "$(pgrep Diablo)" ]; do
    aberto=0       
    if [ -n "$(pgrep macro_d3_wiz.sh)" ]; then
        aberto=1
    else
        aberto=0
    fi    
    if [ $aberto -eq 1 ]; then        
        if [ -n "$(ps -aux | grep macro_off| grep wine_d3 | awk '{print $2;}')" ]; then
            killall -9 pqiv
            pqiv --click-through --keep-above --transparent-background --hide-info-box '/home/lucas/.wine_d3/macro_on.png' &
        fi

    fi    
    if [ $aberto -eq 0 ]; then
        if [ -z "$(ps -aux | grep macro_off| grep wine_d3 | awk '{print $2;}')" ]; then
            killall -9 pqiv
            pqiv --click-through --keep-above --transparent-background --hide-info-box '/home/lucas/.wine_d3/macro_off.png' &
        fi
    fi
    sleep 0.5
done
killall -9 pqiv
