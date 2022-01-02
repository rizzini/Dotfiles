#!/bin/bash
contador=0
while [ -z "$(/usr/bin/pactl list sources | /usr/bin/grep 'device.description = "Áudio interno"')" ];do
    contador=$(($contador + 1))
    if [ $contador -eq 1 ];then
        /usr/bin/sudo /home/lucas/Documentos/scripts/pulseaudio_fix_mic_copy_files_sudo.sh 0_intel;
        /usr/bin/systemctl --user restart pulseaudio.service;
    elif [ $contador -eq 2 ];then
        /usr/bin/sudo /home/lucas/Documentos/scripts/pulseaudio_fix_mic_copy_files_sudo.sh 1_intel;  
        /usr/bin/systemctl --user restart pulseaudio.service;
    elif [ $contador -eq 3 ];then
        /usr/bin/sudo /home/lucas/Documentos/scripts/pulseaudio_fix_mic_copy_files_sudo.sh 2_intel;  
        /usr/bin/systemctl --user restart pulseaudio.service;
    fi    
    /usr/bin/sleep 1;
done
