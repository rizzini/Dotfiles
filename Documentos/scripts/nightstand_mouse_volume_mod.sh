#!/bin/bash
device_id=$(xinput --list | grep '2.4G Mouse' |  awk '{print $5}' | tr -d 'id=')
xinput --test $device_id | grep --line-buffered -E 'button press   1|button press   3|button release 1|button release 3' | while read -r line; do
    if [ "$line" == 'button press   1' ] && [ "$right_button" == 0 ]; then
        left_button=1
        continue
    elif [ "$line" == 'button release 1' ]; then
        left_button=0
    fi
    if [ "$line" == 'button press   3' ] && [ "$left_button" == 1 ]; then
       /home/lucas/Documentos/scripts/playerctl 'avancar_posicao'
    fi
    if [ "$line" == 'button press   3' ]; then
        right_button=1
        continue
    elif [ "$line" == 'button release 3' ]; then
        right_button=0
    fi
    if [ "$line" == 'button press   1' ] && [ "$right_button" == 1 ]; then
       /home/lucas/Documentos/scripts/playerctl 'voltar_posicao'
    fi
done
