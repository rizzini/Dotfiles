#!/bin/bash
if [ "$1" == "desativar" ]; then
    /usr/bin/qdbus org.kde.KWin /Compositor suspend;
elif [ "$1" == "ativar" ]; then
    /usr/bin/qdbus org.kde.KWin /Compositor resume;
fi


