#!/bin/bash
if [ -z $(pgrep hl2_linux) ];then
    crow & sleep 0.8;
    while [ $(wmctrl -l | grep 'Crow Translate' | wc -l) -ge 2 ];do
        wmctrl -ic $(wmctrl -l | grep 'Crow Translate' | tail -1 | awk '{print $1}');
    done
fi
