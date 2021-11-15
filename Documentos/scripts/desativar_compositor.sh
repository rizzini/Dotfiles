#!/bin/bash
/usr/bin/sleep 4 &&
while [ "$(/usr/bin/qdbus org.kde.KWin /Compositor org.kde.kwin.Compositing.active)" == "true" ]; do
    /usr/bin/xdotool keydown Alt_L+Shift_L + key F12 && /usr/bin/xdotool keyup Alt_L+Shift_L;
    /usr/bin/sleep 1
done


