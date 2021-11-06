#!/bin/bash
{
set -x
contador=0
if [ -z "$(/usr/bin/ls /dev/dri/ | /usr/bin/grep card1)" ];then
    /usr/bin/sudo /home/lucas/Documentos/scripts/pulseaudio_fix_mic_copy_files_sudo.sh intel;
    /usr/bin/echo 'iGPU desativada. Copiando arquivo pertinente(default.pa_intel).';
    exit;
fi  

if [[ -n "$( /usr/bin/pactl list sources | /usr/bin/grep 'hw:2')" || -n "$( /usr/bin/pactl list sources | /usr/bin/grep 'hw:1')" ]];then
    if [ -z "$( /usr/bin/pactl list sources | /usr/bin/grep -E 'USB|CAMERA')" ];then
        exit;
    fi
fi
while :;do
    contador=$(($contador + 1))
    if [ `/usr/bin/expr $contador % 2` == 0 ];then
        /usr/bin/sudo /home/lucas/Documentos/scripts/pulseaudio_fix_mic_copy_files_sudo.sh 2;
    else
        /usr/bin/sudo /home/lucas/Documentos/scripts/pulseaudio_fix_mic_copy_files_sudo.sh 1;
    fi
    /usr/bin/pulseaudio -k;
    /usr/bin/sleep 1
    if [[ -n "$( /usr/bin/pactl list sources | /usr/bin/grep 'hw:2')" || -n "$( /usr/bin/pactl list sources | /usr/bin/grep 'hw:1')" ]];then
        if [ -z "$( /usr/bin/pactl list sources | /usr/bin/grep -E 'USB|CAMERA')" ];then
            break;
        fi
    fi
done
} &> /home/lucas/Documentos/scripts/logs/pulseaudio_fix_mic.log
