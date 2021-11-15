#!/bin/bash
while :;do
    if [ -z "$(/usr/bin/pgrep -x amule)" ];then
        /usr/bin/sleep 1
        /usr/bin/amule &> /dev/null &
        /usr/bin/sleep 5
    fi
    /usr/bin/sleep 2
done
