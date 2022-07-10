#!/bin/bash
#For when watching movies and such..
/usr/bin/sleep 10;
while :; do
    if [ -n "$(pgrep mpv)" ] || wmctrl -l | /usr/bin/grep -q Netflix; [[ "$(/usr/bin/xdotool getactivewindow getwindowgeometry | /usr/bin/grep 'Geometry:' | /usr/bin/awk '{print $2}')" == '1920x1080' && "$(/usr/bin/xdotool getactivewindow getwindowclassname)" != 'plasmashell' && -z "$(pgrep wine)" && -z "$(pgrep makepkg)"  ]]; then
        fullscreen=1;
        sleep=1;
    else
        fullscreen=0;
        sleep=300;
    fi
    if [ $fullscreen == 1 ] && ! /usr/bin/grep -Eq "powersave|ondemand" /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor; then
        if wmctrl -l | /usr/bin/grep -q Netflix; then #Netflix is too hungry and my iGPU doesn't support HW acceleration with the codec it uses. powersave can't handle it
            /usr/bin/echo -n 'ondemand' | /usr/bin/sudo /usr/bin/tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor;
            /usr/bin/mpv --no-terminal /home/lucas/Documentos/scripts/mod_cpu_governor_when_having_fullscreen_app.mp3; #Remove after stating the script is reliable.
        else
            /usr/bin/echo -n 'powersave' | /usr/bin/sudo /usr/bin/tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor;
            /usr/bin/mpv --no-terminal /home/lucas/Documentos/scripts/mod_cpu_governor_when_having_fullscreen_app.mp3; #Remove after stating the script is reliable.
        fi
    elif [ $fullscreen == 0 ] && ! /usr/bin/grep -q 'performance' /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor; then
        /usr/bin/echo -n 'performance' | /usr/bin/sudo /usr/bin/tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor;
        /usr/bin/mpv --no-terminal /home/lucas/Documentos/scripts/mod_cpu_governor_when_having_fullscreen_app.mp3; #Remove after stating the script is reliable.
    fi
    /usr/bin/sleep $sleep;
done
