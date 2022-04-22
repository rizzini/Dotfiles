#!/bin/bashzz
if [ "$1" == "desativar" ]; then
    /usr/bin/qdbus org.kde.KWin /Compositor suspend;
elif [[ "$1" == "ativar" && ! -f "/home/lucas/Documentos/scripts/compositor_off" ]]; then
    /usr/bin/qdbus org.kde.KWin /Compositor resume;
fi


