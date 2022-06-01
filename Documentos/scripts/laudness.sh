#!/bin/bash

if [[ -n "$(pgrep easyeffects)" && "$(pgrep easyeffects | wc -l)" -lt 2 ]];then
    killall easyeffects;
else
    easyeffects --gapplication-service &> /dev/null & disown $last_pid
fi
