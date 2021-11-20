#!/bin/bash
/usr/bin/printf "CPU: ""$(/usr/bin/echo $(/usr/bin/sensors | /usr/bin/grep 'Package id 0:' | /usr/bin/tail -1 | /usr/bin/cut -c 17-18))""ºc"
