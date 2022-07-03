#!/bin/bash

if [ -n "$(pgrep easyeffects)" ];then
    killall easyeffects;
else
    easyeffects --gapplication-service &> /dev/null &
    sleep 1
    easyeffects -l 'LoudnessEqualizer' &> /dev/null &
fi
