#!/bin/bash
disable_file='/tmp/mod_cpu_governor_when_having_fullscreen_app.disable'
if ! test -f "$disable_file" && [ "$1" == 'disable' ]; then
    /usr/bin/echo '{PlasmoidIconStart}/home/lucas/Documentos/scripts/mod_cpu_governor_when_having_fullscreen_app_disabled.svg{PlasmoidIconEnd}';
    /usr/bin/touch "$disable_file";
    exit
elif test -f "$disable_file" && [ "$1" == 'disable' ]; then
    /usr/bin/echo '{PlasmoidIconStart}/home/lucas/Documentos/scripts/mod_cpu_governor_when_having_fullscreen_app_enabled.svg{PlasmoidIconEnd}';
    /usr/bin/rm -f "$disable_file";
    exit
fi

/usr/bin/sleep 10
mp3='/home/lucas/Documentos/scripts/mod_cpu_governor_when_having_fullscreen_app.mp3'
while :; do
    if ! test -f "$disable_file"; then
        if [ -n "$(pgrep mpv)" ] || wmctrl -l | /usr/bin/grep -q "Netflix"; [[ "$(/usr/bin/xdotool getactivewindow getwindowgeometry | /usr/bin/grep 'Geometry:' | /usr/bin/awk '{print $2}')" == '1920x1080' && "$(/usr/bin/xdotool getactivewindow getwindowclassname)" != 'plasmashell' && -z "$(/usr/bin/pgrep wine)" && -z "$(/usr/bin/pgrep makepkg)"  ]]; then
            change_governor=1;
            sleep=1;
        else
            change_governor=0;
            sleep=300;
        fi
        if [ $change_governor == 1 ] && ! /usr/bin/grep -q "ondemand" /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor; then
#             /usr/bin/mpv --no-terminal "$mp3"; #Remove after stating the script is reliable.
            /usr/bin/echo -n 'ondemand' | /usr/bin/sudo /usr/bin/tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor;
        elif [ $change_governor == 0 ] && ! /usr/bin/grep -q 'performance' /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor; then
            /usr/bin/echo -n 'performance' | /usr/bin/sudo /usr/bin/tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor;
#             /usr/bin/mpv --no-terminal "$mp3"; #Remove after stating the script is reliable and.
        fi
    else
        sleep=1;
    fi
    /usr/bin/sleep $sleep;
done
