#!/bin/bash
step=3
if [ -n "$1" ];then
    if [ $1 == "increase" ];then
        pactl -- set-sink-volume 0 +$step%
    elif [ $1 == "decrease" ];then
        pactl -- set-sink-volume 0 -$step%
    fi
fi
