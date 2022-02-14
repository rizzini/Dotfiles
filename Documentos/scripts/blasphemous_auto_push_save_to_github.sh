#!/bin/bash
/usr/bin/time -o /tmp/blasphemous.tmp -f "%e" /mnt/archlinux/Games/Blasphemous/start.sh
if [ $(cat /tmp/blasphemous.tmp | awk -F. '{print $1}') -gt 600 ];then
    sudo /usr/bin/yadm -Y /etc/yadm push;
fi
