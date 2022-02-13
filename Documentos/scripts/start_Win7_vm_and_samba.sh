#!/bin/bash
/usr/bin/sudo /usr/bin/systemctl start smb &
/usr/bin/VBoxManage startvm 'Windows 7' &> /dev/null &
wait;
while [ -n "$(/usr/bin/wmctrl -l | /usr/bin/grep 'Windows 7')" ]; do
    /usr/bin/sleep 1;
done;
/usr/bin/sudo /usr/bin/systemctl stop smb

