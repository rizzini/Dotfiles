#!/bin/bash
if [ -n "$(grep nvidia /etc/X11/xorg.conf)" ];then
    export DISPLAY=:0
    /usr/bin/nvidia-settings --load-config-only
fi
