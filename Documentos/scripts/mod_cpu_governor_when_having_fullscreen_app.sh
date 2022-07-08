#!/bin/bash
/usr/bin/sleep 10
while :; do
    if [[ "$(/usr/bin/xdotool getactivewindow getwindowgeometry | /usr/bin/grep 'Geometry:' | /usr/bin/awk '{print $2}')" == '1920x1080' && "$(/usr/bin/xdotool getactivewindow getwindowclassname)" != 'plasmashell' ]]; then
        fullscreen=1;
        sleep=1;
    else
        fullscreen=0;
        sleep=300;
        exit
    fi
    if [ $fullscreen == 1 ] && ! /usr/bin/grep -q 'powersave' /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor; then
        /usr/bin/echo -n 'powersave' | /usr/bin/sudo /usr/bin/tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor;
        /usr/bin/mpv --no-terminal /home/lucas/Documentos/scripts/mod_cpu_governor_when_having_fullscreen_app.mp3;
    elif [ $fullscreen == 0 ] && ! /usr/bin/grep -q 'performance' /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor; then
        /usr/bin/echo -n 'performance' | /usr/bin/sudo /usr/bin/tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor;
        /usr/bin/mpv --no-terminal /home/lucas/Documentos/scripts/mod_cpu_governor_when_having_fullscreen_app.mp3;
    fi
    /usr/bin/sleep $sleep;
done
