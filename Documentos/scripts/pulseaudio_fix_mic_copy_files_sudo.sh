#!/bin/bash
if [ "$1" == "0_intel" ]; then
    /usr/bin/cp /etc/pulse/default.pa_0_intel /etc/pulse/default.pa;
elif [ "$1" == "0_nvidia" ]; then
    /usr/bin/cp /etc/pulse/default.pa_0_nvidia /etc/pulse/default.pa;
elif [ "$1" == "1_intel" ]; then
    /usr/bin/cp /etc/pulse/default.pa_1_intel /etc/pulse/default.pa;
elif [ "$1" == "1_nvidia" ]; then
    /usr/bin/cp /etc/pulse/default.pa_1_nvidia /etc/pulse/default.pa;
elif [ "$1" == "2_intel" ]; then
    /usr/bin/cp /etc/pulse/default.pa_2_intel/etc/pulse/default.pa;
elif [ "$1" == "2_nvidia" ]; then
    /usr/bin/cp /etc/pulse/default.pa_2_nvidia /etc/pulse/default.pa;
fi
