#!/bin/bash

if [[ -n "$(pgrep easyeffects)" && "$(pgrep easyeffects | wc -l)" -lt 2 ]];then
    killall easyeffects;
else
    easyeffects --gapplication-service &> /dev/null &
    easyeffects -l 'LoudnessEqualizer' &> /dev/null &
fi
