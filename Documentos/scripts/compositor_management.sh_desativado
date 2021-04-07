#!/bin/bash
contador=0
while :;
do
#     WINDOW=$(echo $(xwininfo -id $(xdotool getactivewindow) -stats | egrep '(Width|Height):' | awk '{print $NF}') | sed -e 's/ /x/')
#     SCREEN=$(xdpyinfo | grep -m1 dimensions | awk '{print $2}')
#     if [ "$WINDOW" = "$SCREEN" ] && [ "$(/usr/bin/qdbus org.kde.KWin /Compositor org.kde.kwin.Compositing.active)" == "true" ]; then
#         /usr/bin/qdbus org.kde.KWin /Compositor org.kde.kwin.Compositing.suspend;
#         mpv /mnt/archlinux/ROOT/usr/lib/libreoffice/share/gallery/sounds/911.wav
#     fi
    

    if [[ -n "$(/usr/bin/pgrep Diablo)" && -n "$(wmctrl -l | grep Diablo)" ]]; then
        if [ "$(/usr/bin/qdbus org.kde.KWin /Compositor org.kde.kwin.Compositing.active)" == "true" ]; then
            /usr/bin/qdbus org.kde.KWin /Compositor org.kde.kwin.Compositing.suspend;
        fi
    elif [[ -n "$(/usr/bin/pgrep QEMU)" || -n "$(wmctrl -l | grep QEMU)" ]]; then
        if [ "$(/usr/bin/qdbus org.kde.KWin /Compositor org.kde.kwin.Compositing.active)" == "true" ]; then
            /usr/bin/qdbus org.kde.KWin /Compositor org.kde.kwin.Compositing.suspend;
        fi
    elif [[ -n "$(/usr/bin/pgrep UNO)" && -n "$(wmctrl -l | grep UNO)" ]]; then
        contador=$(($contador + 1))
        if [ $contador -gt 1 ]; then
            contador=0;
        fi
        if [ $contador -eq 1 ] && [ "$(/usr/bin/qdbus org.kde.KWin /Compositor org.kde.kwin.Compositing.active)" == "true" ]; then
            sleep 10;
        elif [ "$(/usr/bin/qdbus org.kde.KWin /Compositor org.kde.kwin.Compositing.active)" == "true" ]; then 
            /usr/bin/qdbus org.kde.KWin /Compositor org.kde.kwin.Compositing.suspend;
        fi
    elif [[ -n "$(/usr/bin/pgrep qemu)" && -n "$(wmctrl -l | grep qemu)" ]]; then
        if [ "$(/usr/bin/qdbus org.kde.KWin /Compositor org.kde.kwin.Compositing.active)" == "true" ]; then
            /usr/bin/qdbus org.kde.KWin /Compositor org.kde.kwin.Compositing.suspend;
        fi
    else
        /usr/bin/qdbus org.kde.KWin /Compositor org.kde.kwin.Compositing.resume
    fi
        /usr/bin/sleep 5
done

z

