#!/bin/bash
contador=0
pegar_linha=0
if test -f "/tmp/wallpaper.pywall.tmp"; then
    rm /tmp/wallpaper.pywall.tmp;
fi

touch /tmp/wallpaper.pywall.tmp

while :; do   
{
    while read line; do
        contador=$(($contador + 1))
        if [[ "$line" == *"34"* && "$line" == *"Wallpaper"* ]]; then
            pegar_linha=$(($contador + 1))
        fi
        if [ $contador -eq $pegar_linha ]; then
            atual=$line
            atual=$(echo $atual | cut -c7-999 | perl -MURI -MURI::Escape -lne 'print uri_unescape(URI->new($_)->path)')
        fi
    done < /home/$(whoami)/.config/./plasma-org.kde.plasma.desktop-appletsrc
    atual=$(echo $atual | cut -d' ' -f1)
} &> /dev/null
    if !  test -f "/tmp/wallpaper.pywall.tmp"; then
        echo -e "$atual"  > /tmp/wallpaper.pywall.tmp
    else
        if [ "$(cat /tmp/wallpaper.pywall.tmp)" != "$atual" ]; then
            wal -q -e -t -n -i $atual
            {
            while read line; do
                contador=$(($contador + 1))
                if [[ "$line" == *"34"* && "$line" == *"Wallpaper"* ]]; then
                    pegar_linha=$(($contador + 1))
                fi
                if [ $contador -eq $pegar_linha ]; then
                    atual=$line
                    atual=$(echo $atual | cut -c7-999 | perl -MURI -MURI::Escape -lne 'print uri_unescape(URI->new($_)->path)')
                fi
            done < /home/$(whoami)/.config/./plasma-org.kde.plasma.desktop-appletsrc    
            atual=$(echo $atual | cut -d' ' -f1)
            } &> /dev/null
            
            cor_final=$(cat /home/lucas/.cache/wal/colors | tail -9 | head -1 | tr -d '#')
            disk=$(cat /home/lucas/.config/plasma-org.kde.plasma.desktop-appletsrc | grep 'textColor=#' | head -1 | cut -c12-17)
            temp=$(cat /home/lucas/.config/plasma-org.kde.plasma.desktop-appletsrc | grep 'textColor=#' | tail -1 | cut -c12-17)

            perl -pi -e 's/'"$(echo 'textColor=#'$disk)"'/'"$(echo 'textColor=#'$cor_final)"'/g' /home/lucas/.config/plasma-org.kde.plasma.desktop-appletsrc 

            perl -pi -e 's/'"$(echo 'textColor=#'$temp)"'/'"$(echo 'textColor=#'$cor_final)"'/g' /home/lucas/.config/plasma-org.kde.plasma.desktop-appletsrc 
        fi
    fi
    
    sleep 1
    echo -e "$atual" > /tmp/wallpaper.pywall.tmp
    sleep 5
done
