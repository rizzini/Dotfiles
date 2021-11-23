#!/bin/bash
set -x
contador=0
while [ -z "$(/usr/bin/pactl list sources | /usr/bin/grep 'device.description = "Áudio interno"')" ];do
    if [ -z "$(/usr/bin/ls /dev/dri/ | /usr/bin/grep card1)" ];then
        if [ -z "$(/usr/bin/pactl list sources | /usr/bin/grep 'device.description = "Áudio interno"')" ];then
            /usr/bin/sudo /home/lucas/Documentos/scripts/pulseaudio_fix_mic_copy_files_sudo.sh 0;
            /usr/bin/systemctl --user restart pulseaudio.service &
            /usr/bin/sleep 2
        fi
        if [ -z "$(/usr/bin/pactl list sources | /usr/bin/grep 'device.description = "Áudio interno"')" ];then
            /usr/bin/sudo /home/lucas/Documentos/scripts/pulseaudio_fix_mic_copy_files_sudo.sh 1;
            /usr/bin/systemctl --user restart pulseaudio.service &
        fi    
        exit;
    fi  
    sleep 1
done

