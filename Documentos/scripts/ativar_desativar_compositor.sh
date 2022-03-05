#!/bin/bash
if [ "$1" == "desativar" ]; then
    qdbus org.kde.KWin /Compositor suspend;
elif [ "$1" == "ativar" ]; then
    qdbus org.kde.KWin /Compositor resume;
fi


