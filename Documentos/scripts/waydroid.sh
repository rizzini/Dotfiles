#!/bin/bash
systemctl restart waydroid-container.service
if [ -z "$(pgrep weston)" ]; then
    weston --xwayland &> /dev/null &
fi
sleep 2 &&
export XDG_SESSION_TYPE='wayland'
export DISPLAY=':1'
konsole --new-tab --hide-tabbar --hide-menubar -e '/usr/bin/waydroid show-full-ui'

