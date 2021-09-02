#!/bin/bash
set -x
export DISPLAY=':1'
export LD_LIBRARY_PATH=''
while [ -z "$(ps auxm | grep Xorg | grep ':1')" ];
do
    sleep 0.5
    echo 'aguardando :1..'
done
while [[ "$(DISPLAY=:1 xrandr | head -3 | tail -1 | awk '{print $3}')" != *"1024x768"* ]]; do
    xrandr --output HDMI-1 --mode 1024x768
    sleep 1
    echo 'aguardando xrandr..'
done

xinput set-int-prop $(xinput --list | grep 'USB Optical Mouse' | awk '{ print $6 }' | tr -d 'id=') "Device Enabled" 8 0
keyboard+=($(xinput --list | grep 'Microsoft Wired Keyboard 600' | awk '{ print $6 }' | tr -d 'id=' | head -2 | tail -1))
keyboard+=($(xinput --list | grep 'Microsoft Wired Keyboard 600' | awk '{ print $6 }' | tr -d 'id=' | tail -1))
xinput set-int-prop ${keyboard[0]} "Device Enabled" 8 0
xinput set-int-prop ${keyboard[1]} "Device Enabled" 8 0
x0vncserver -display :1 -PasswordFile /home/lucas/.vnc/passwd &
exit 0
