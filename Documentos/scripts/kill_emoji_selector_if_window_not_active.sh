#!/bin/bash
/usr/bin/ibus-ui-emojier-plasma &> /dev/null &
/usr/bin/sleep 1
while [ "$(/usr/bin/xdotool getactivewindow getwindowclassname)" == "plasma.emojier" ]; do
    /usr/bin/sleep 0.5;
done
/usr/bin/killall ibus-ui-emojier-plasma
