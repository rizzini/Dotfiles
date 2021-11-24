#!/bin/bash
set -x
if [ "$1" == 'start' ];then
    export DISPLAY=:1
    export LD_LIBRARY_PATH='/mnt/archlinux/opengl_libs/nvidia/'
    while [ -z "$(/usr/bin/ps auxm | /usr/bin/grep Xorg | /usr/bin/grep ':1')" ];
    do
        /usr/bin/echo 'aguardando :1..'
        /usr/bin/sleep 0.5
    done
    killall plasmashell
    killall -9 kwin_x11
    sleep 1
    plasmashell &> /dev/null & disown $!
    kwin_x11 --replace &> /dev/null & disown $!
    konsole &
    x0vncserver -display :1 -PasswordFile /home/lucas/.vnc/passwd 
    # /usr/bin/xinput set-int-prop $(/usr/bin/xinput --list | /usr/bin/grep 'USB Optical Mouse' | /usr/bin/awk '{ print $6 }' | /usr/bin/tr -d 'id=') "Device Enabled" 8 0
    # keyboard+=($(/usr/bin/xinput --list | /usr/bin/grep 'Microsoft Wired Keyboard 600' | /usr/bin/awk '{ print $6 }' | /usr/bin/tr -d 'id=' | /usr/bin/head -2 | /usr/bin/tail -1))
    # keyboard+=($(/usr/bin/xinput --list | /usr/bin/grep 'Microsoft Wired Keyboard 600' | /usr/bin/awk '{ print $6 }' | /usr/bin/tr -d 'id=' | /usr/bin/tail -1))
    # /usr/bin/xinput set-int-prop ${keyboard[0]} "Device Enabled" 8 0
    # /usr/bin/xinput set-int-prop ${keyboard[1]} "Device Enabled" 8 0
    # 
elif [ "$1" == 'stop' ];then
    export DISPLAY=:0
    export LD_LIBRARY_PATH=''
    killall plasmashell
    killall -9 kwin_x11
    sleep 1
    kwin_x11 --replace &> /dev/null & disown $!
    plasmashell &> /dev/null & disown $!
fi
