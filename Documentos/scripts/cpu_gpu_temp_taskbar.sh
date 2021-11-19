#!/bin/bash
/usr/bin/printf "Free space: $(df -h | grep sda2 | head -1 | awk '{print $5}')% | CPU: ""$(/usr/bin/echo $(/usr/bin/sensors | /usr/bin/grep 'Package id 0:' | /usr/bin/tail -1 | /usr/bin/cut -c 17-18))""ºc"
