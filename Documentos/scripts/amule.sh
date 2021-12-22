#!/bin/bash
while [ ! $(df | grep sda2 | head -1 | awk '{print $5}' | tr -d '%') -lt 2 ];do
    if [ -z "$(/usr/bin/pgrep -x amule)" ];then
        /usr/bin/sleep 1
        /usr/bin/amule &> /dev/null &
        /usr/bin/sleep 5
    fi
    /usr/bin/sleep 2
done
killall -9 amule
