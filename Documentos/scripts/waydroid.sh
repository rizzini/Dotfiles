#!/bin/bash
if [ "$(/usr/bin/systemctl is-active waydroid-container.service)" == 'active' ];then
    /usr/bin/killall -9 kwin_wayland
    /usr/bin/sudo /usr/bin/systemctl stop waydroid-container.service
    exit
fi
/usr/bin/killall -9 kwin_wayland
/usr/bin/sudo /usr/bin/systemctl restart waydroid-container.service
if [ -z "$(/usr/bin/pgrep kwin_wayland)" ]; then
#   /usr/bin/weston --width=780 --height=425 --xwayland &> /dev/null &
    /usr/bin/kwin_wayland --no-lockscreen --width=780 --height=420 --xwayland &> /dev/null &
fi
/usr/bin/sleep 1 &&
export XDG_SESSION_TYPE='wayland'
export DISPLAY=':1'
/usr/bin/konsole --new-tab --hide-tabbar --hide-menubar -e '/usr/bin/waydroid show-full-ui' &
while [ -n "$(/usr/bin/pgrep kwin_wayland)" ];do
    /usr/bin/sleep 1
done
/usr/bin/sudo /usr/bin/systemctl stop waydroid-container.service
