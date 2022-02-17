#!/bin/bash
step=3
if [ -n "$1" ];then
    if [ $1 == "increase" ];then
        pactl -- set-sink-volume $(pactl get-default-sink) +$step%
    elif [ $1 == "decrease" ];then
        pactl -- set-sink-volume $(pactl get-default-sink) -$step%
    fi
fi
