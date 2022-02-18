#!/bin/bash
/usr/bin/time -o /tmp/blasphemous.tmp -f "%e" /mnt/archlinux/Games/Blasphemous/start.sh

if [ $(/usr/bin/cat /tmp/blasphemous.tmp | /usr/bin/cut -d. -f1) -gt 1200 ];then
    echo -e '\n' | /usr/bin/sudo /usr/bin/yadm -Y /etc/yadm push;
fi
