#!/bin/bash
if [ "$1" == "0" ]; then
    /usr/bin/cp /etc/pulse/default.pa_0 /etc/pulse/default.pa;
elif [ "$1" == "1" ]; then
    /usr/bin/cp /etc/pulse/default.pa_1 /etc/pulse/default.pa;
elif [ "$1" == "2" ]; then
    /usr/bin/cp /etc/pulse/default.pa_2 /etc/pulse/default.pa;
fi
