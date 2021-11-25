#!/bin/bash
sleep 2 &&
if [ -n "$(grep nvidia /etc/X11/xorg.conf)" ];then
    /usr/bin/nvidia-settings --load-config-only
fi
