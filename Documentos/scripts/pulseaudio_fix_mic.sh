#!/bin/bash
set -x
contador=0
while [ -z "$(/usr/bin/pactl list sources | /usr/bin/grep 'device.description = "Áudio interno"')" ];do
    contador=$(($contador + 1))
    if [[ $contador -eq 1 && -z "$(/usr/bin/grep nvidia /etc/X11/xorg.conf)" ]];then
        /usr/bin/sudo /home/lucas/Documentos/scripts/pulseaudio_fix_mic_copy_files_sudo.sh 0_intel;
        /usr/bin/systemctl --user restart pulseaudio.service
    elif [[ $contador -eq 1 && -n "$(/usr/bin/grep nvidia /etc/X11/xorg.conf)" ]];then
        /usr/bin/sudo /home/lucas/Documentos/scripts/pulseaudio_fix_mic_copy_files_sudo.sh 0_nvidia;
        /usr/bin/systemctl --user restart pulseaudio.service    
    elif [[ $contador -eq 2 && -z "$(/usr/bin/grep nvidia /etc/X11/xorg.conf)" ]];then
        /usr/bin/sudo /home/lucas/Documentos/scripts/pulseaudio_fix_mic_copy_files_sudo.sh 1_intel;  
        /usr/bin/systemctl --user restart pulseaudio.service
    elif [[ $contador -eq 2 && -n "$(/usr/bin/grep nvidia /etc/X11/xorg.conf)" ]];then 
        /usr/bin/sudo /home/lucas/Documentos/scripts/pulseaudio_fix_mic_copy_files_sudo.sh 1_nvidia;  
        /usr/bin/systemctl --user restart pulseaudio.service    
    elif [[ $contador -eq 3 && -z "$(/usr/bin/grep nvidia /etc/X11/xorg.conf)" ]];then
        /usr/bin/sudo /home/lucas/Documentos/scripts/pulseaudio_fix_mic_copy_files_sudo.sh 2_intel;  
        /usr/bin/systemctl --user restart pulseaudio.service
    elif [[ $contador -eq 3 && -n "$(/usr/bin/grep nvidia /etc/X11/xorg.conf)" ]];then
        /usr/bin/sudo /home/lucas/Documentos/scripts/pulseaudio_fix_mic_copy_files_sudo.sh 2_nvidia;  
        /usr/bin/systemctl --user restart pulseaudio.service
    fi    
    /usr/bin/sleep 1
done

