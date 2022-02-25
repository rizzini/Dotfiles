#!/bin/bash
step=3
if [ -n "$1" ];then
    if [ $1 == "increase" ];then
        /usr/bin/pactl -- set-sink-volume $(/usr/bin/pactl get-default-sink) +$step% &
    elif [ $1 == "decrease" ];then
        /usr/bin/pactl -- set-sink-volume $(/usr/bin/pactl get-default-sink) -$step% &
    fi
    if [ -z "$(/usr/bin/pgrep spotify)" ];then
        /usr/bin/mpv --really-quiet /usr/share/sounds/freedesktop/stereo/audio-volume-change.oga
    fi
fi
