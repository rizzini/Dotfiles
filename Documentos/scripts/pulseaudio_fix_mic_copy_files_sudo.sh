#!/bin/bash
if [ "$1" == "1" ]; then
    cp /etc/pulse/default.pa_1 /etc/pulse/default.pa;
elif [ "$1" == "2" ]; then
    cp /etc/pulse/default.pa_2 /etc/pulse/default.pa;
elif [ "$1" == "intel" ]; then
    cp /etc/pulse/default.pa_intel /etc/pulse/default.pa;
fi
