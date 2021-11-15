#!/bin/bash
export DISPLAY=:1
export LD_LIBRARY_PATH=''
while [ -z "$(/usr/bin/ps auxm | /usr/bin/grep Xorg | /usr/bin/grep ':1')" ];
do
    /usr/bin/sleep 0.5
    /usr/bin/echo 'aguardando :1..'
done
while [[ "$(DISPLAY=:1 /usr/bin/xrandr | /usr/bin/head -3 | /usr/bin/tail -1 | /usr/bin/awk '{print $3}')" != *"1024x768"* ]]; do
    /usr/bin/xrandr --output HDMI-1 --mode 1024x768
    /usr/bin/sleep 1
    /usr/bin/echo 'aguardando xrandr..'
done

/usr/bin/xinput set-int-prop $(/usr/bin/xinput --list | /usr/bin/grep 'USB Optical Mouse' | /usr/bin/awk '{ print $6 }' | /usr/bin/tr -d 'id=') "Device Enabled" 8 0
keyboard+=($(/usr/bin/xinput --list | /usr/bin/grep 'Microsoft Wired Keyboard 600' | /usr/bin/awk '{ print $6 }' | /usr/bin/tr -d 'id=' | /usr/bin/head -2 | /usr/bin/tail -1))
keyboard+=($(/usr/bin/xinput --list | /usr/bin/grep 'Microsoft Wired Keyboard 600' | /usr/bin/awk '{ print $6 }' | /usr/bin/tr -d 'id=' | /usr/bin/tail -1))
/usr/bin/xinput set-int-prop ${keyboard[0]} "Device Enabled" 8 0
/usr/bin/xinput set-int-prop ${keyboard[1]} "Device Enabled" 8 0
/usr/bin/x0vncserver -display :1 -PasswordFile /home/lucas/.vnc/passwd &
exit 0
