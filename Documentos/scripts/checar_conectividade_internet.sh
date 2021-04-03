#!/bin/bash

while :; 
do
    ping -c 1 -w 5  8.8.8.8
    if [ $? == '0' ]; then
        while :;
        do
            mpv /mnt/archlinux/ROOT/usr/share/sounds/alsa/Noise.wav;
            sleep 2
        done
    fi
    sleep 1
done
