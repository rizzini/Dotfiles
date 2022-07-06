#!/bin/bash
if [ -n "$(/usr/bin/pgrep easyeffects)" ];then
    /usr/bin/killall easyeffects;
else
    /usr/bin/easyeffects --gapplication-service &> /dev/null &
    /usr/bin/sleep 1
    /usr/bin/easyeffects -l 'LoudnessEqualizer' &> /dev/null &
fi
