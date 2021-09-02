#!/bin/bash
while :;do
    if [ -z "$(pgrep amule)" ];then
        sleep 1
        /usr/bin/amule &> /dev/null &
        sleep 5
    fi
    sleep 2
done
