#!/bin/bash
while [ "$(/usr/bin/qdbus org.kde.KWin /Compositor org.kde.kwin.Compositing.active)" == "true" ]; do
#     /usr/bin/xdotool keydown Alt_L+Shift_L + key F12 && /usr/bin/xdotool keyup Alt_L+Shift_L;
    qdbus org.kde.KWin /Compositor suspend;
    /usr/bin/sleep 1
done


