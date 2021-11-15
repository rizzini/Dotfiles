#!/bin/bash

while :; do
    while [ $(/usr/bin/ls /sys/class/bluetooth | /usr/bin/wc -l) -ge 2 ];do
        if [ -n "$(/usr/bin/pactl list | /usr/bin/grep "Perfil ativo: headset_head_unit")" ];then
            /usr/bin/sleep 5
            pacmd set-card-profile bluez_card.FC_58_FA_93_42_42 a2dp_sink_sbc
        fi
        /usr/bin/sleep 2
        if [ -n "$(/usr/bin/pactl list | /usr/bin/grep "Perfil ativo: a2dp_sink_sbc")" ];then
            break
        fi
    done
    /usr/bin/sleep 1
done
