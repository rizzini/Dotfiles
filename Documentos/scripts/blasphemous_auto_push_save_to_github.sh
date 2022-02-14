#!/bin/bash
/usr/bin/time -o /tmp/blasphemous.tmp -f "%e" /mnt/archlinux/Games/Blasphemous/start.sh &&
if [ $(/usr/bin/cat /tmp/blasphemous.tmp | /usr/bin/awk -F. '{print $1}') -gt 600 ];then
    echo -ne '\n' | /usr/bin/sudo /usr/bin/yadm -Y /etc/yadm push
    /usr/bin/rm -f /tmp/blasphemous.tmp;
fi
