#!/bin/bash
export DISPLAY=:1
xrandr --output HDMI-1 --mode 1024x768 &
xinput set-int-prop $(xinput --list | grep 'USB Optical Mouse' | awk '{ print $6 }' | tr -d 'id=') "Device Enabled" 8 0
keyboard+=($(xinput --list | grep 'Microsoft Wired Keyboard 600' | awk '{ print $6 }' | tr -d 'id=' | head -2 | tail -1))
keyboard+=($(xinput --list | grep 'Microsoft Wired Keyboard 600' | awk '{ print $6 }' | tr -d 'id=' | tail -1))
xinput set-int-prop ${keyboard[0]} "Device Enabled" 8 0
xinput set-int-prop ${keyboard[1]} "Device Enabled" 8 0
x0vncserver -display :1 -PasswordFile /home/lucas/.vnc/passwd &
sleep 5 &&
anbox session-manager --single-window --window-size=600,600 &
