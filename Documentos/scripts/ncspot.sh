#!/bin/bash
set -x
if [ -z "$(pgrep spotifyd)" ];then
    /usr/bin/gpg --decrypt-files  ~/.config/spotifyd.gpg
    /usr/bin/sleep 0.5
    /usr/bin/spotifyd &> /dev/null &
    /usr/bin/sleep 1
    /usr/bin/rm ~/.config/spotifyd 
elif [ -n "$(pgrep spotifyd)" ];then
    killall -9 spotifyd
fi
    
