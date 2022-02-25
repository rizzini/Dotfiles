#!/bin/bash
while [ "$(/usr/bin/qdbus org.kde.KWin /Compositor org.kde.kwin.Compositing.active)" == "true" ]; do
    qdbus org.kde.KWin /Compositor suspend;
    /usr/bin/sleep 1
done


