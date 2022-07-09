#!/bin/bash
ibus-ui-emojier-plasma &> /dev/null &
sleep 1
while [ "$(xdotool getactivewindow getwindowclassname)" == "plasma.emojier" ]; do
    sleep 0.5;
done
killall ibus-ui-emojier-plasma
