#!/bin/bash

while :; do
    while [ $(ls /sys/class/bluetooth | wc -l) -ge 2 ];do
        if [ -n "$(pactl list | grep "Perfil ativo: headset_head_unit")" ];then
            sleep 5
            pacmd set-card-profile bluez_card.FC_58_FA_93_42_42 a2dp_sink_sbc
        fi
        sleep 2
        if [ -n "$(pactl list | grep "Perfil ativo: a2dp_sink_sbc")" ];then
            break
        fi
    done
    sleep 1
done
