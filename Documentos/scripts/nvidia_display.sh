#!/bin/bash
if [ -n "$1" ];then
    kill -9 $(ps auxm | grep Xorg | grep ':1' | grep -v 'color' | awk '{print $2}') &> /dev/null &
else
    if [ -z "$(ps auxm | grep Xorg | grep ':1' | grep -v 'color' | awk '{print $2}')" ];then
        echo 'Iniciando'
        kill -9 $(ps auxm | grep Xorg | grep ':1' | grep -v 'color' | awk '{print $2}')
        killall -9 plasmashell kwin_x11 x0vncserver &> /dev/null &
        sleep 1 &&
        /usr/bin/X :1 -noreset -seat seat1 -sharevts -config nvidia/xorg.conf &> /dev/null &
        sleep 2
        x0vncserver -display :1 -PasswordFile /home/lucas/.vnc/passwd &> /dev/null &
        DISPLAY=:1 LD_LIBRARY_PATH='/mnt/archlinux/opengl_libs/nvidia/'  kwin_x11 --replace &> /dev/null & 
        DISPLAY=:1 LD_LIBRARY_PATH='/mnt/archlinux/opengl_libs/nvidia/'  plasmashell &> /dev/null  & 
    else
        echo 'Interrompendo'
        sudo /home/lucas/Documentos/scripts/nvidia_display.sh kill_xorg
        killall -9 kwin_x11 plasmashell x0vncserver &> /dev/null &
        sleep 1 &&
        DISPLAY=:0 LD_LIBRARY_PATH='' kwin_x11 --replace &> /dev/null &
        DISPLAY=:0 LD_LIBRARY_PATH='' plasmashell &> /dev/null &
    fi
fi

