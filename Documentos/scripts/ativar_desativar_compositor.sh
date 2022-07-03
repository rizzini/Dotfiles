#!/bin/bash
if [ "$1" = 'inicio' ];then
    if qdbus org.kde.KWin /Compositor org.kde.kwin.Compositing.active; then
        echo 'ligado' | tee /tmp/compositor.tmp
    else
        echo 'desligado' | tee /tmp/compositor.tmp
    fi
    /usr/bin/qdbus org.kde.KWin /Compositor suspend;
elif [ "$1" = 'fim' ];then
    if grep -q 'ligado' /tmp/compositor.tmp; then
        /usr/bin/qdbus org.kde.KWin /Compositor resume;
    elif grep -q 'desligado' /tmp/compositor.tmp; then
        /usr/bin/qdbus org.kde.KWin /Compositor suspend;
    fi
    rm -f /tmp/compositor.tmp
fi





