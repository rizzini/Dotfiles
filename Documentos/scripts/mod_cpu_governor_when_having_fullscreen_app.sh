#!/bin/bash
counter=0
while :; do
    gRoot=$(/usr/bin/xdotool search --maxdepth 0 '.*' getwindowgeometry | /usr/bin/grep 'Geometry:')
    gActive=$(/usr/bin/xdotool getactivewindow getwindowgeometry | /usr/bin/grep 'Geometry:')
    if [ "$gRoot" = "$gActive" ]; then
        fullscreen=1
        counter=$((counter + 1))
        sleep=1
    else
        fullscreen=0
        counter=0
        sleep=300
    fi
    if [ $fullscreen == 1 ] && ! /usr/bin/grep -q 'powersave' /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor; then
        /usr/bin/echo -n 'powersave' | /usr/bin/sudo /usr/bin/tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
    elif [ $fullscreen == 0 ] && ! /usr/bin/grep -q 'performance' /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor; then
        /usr/bin/echo -n 'performance' | /usr/bin/sudo /usr/bin/tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
    fi
    /usr/bin/sleep $sleep
done
