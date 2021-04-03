#!/bin/bash

countdown()
(
IFS=:
set -- $*
secs=$(( ${1#0} * 3600 + ${2#0} * 60 + ${3#0} ))
while [ $secs -gt 0 ]
do
    sleep 1 &
    printf "\r%02d:%02d:%02d" $((secs/3600)) $(( (secs/60)%60)) $((secs%60))
    secs=$(( $secs - 1 ))
    wait
done
echo
)

while :;
do
    colordiff --ignore-space-change  <(echo "$(here goes the cURL command extracted from chrome)")  /home/lucas/Documentos/scripts/checar_diferenca_pagina/1.html # here is the page cloned to be compared in the future against the previously stored one.
    
    if [ $? != "0" ]; then
    
        notify-send "Status has changed!"
        while :;
        do
            timeout 4 cvlc /mnt/btr_pool/BTRFS/root/usr/lib/libreoffice/share/gallery/sounds/untie.wav
        done
        
    fi
    
    echo -e "\e[0;35m$(date +%H:%M)\e[m \e[1m-> Nothing yet...\e[0m"  
    echo "Trying again in: "; countdown "00:05:00"   
    
done
