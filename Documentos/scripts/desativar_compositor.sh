#!/bin/bash
sleep 4 &&
while [ "$(qdbus org.kde.KWin /Compositor org.kde.kwin.Compositing.active)" == true ]; do
    xdotool keydown Alt_L+Shift_L + key F12 && xdotool keyup Alt_L+Shift_L;
    sleep 1
done
#/home/lucas/Documentos/scripts/ativar_segundo_monitor.sh startup &

