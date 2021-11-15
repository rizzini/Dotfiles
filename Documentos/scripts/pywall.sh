#!/bin/bash
contador=0

if test -f "/tmp/wallpaper.pywall.tmp"; then
    /usr/bin/rm /tmp/wallpaper.pywall.tmp;
fi

/usr/bin/touch /tmp/wallpaper.pywall.tmp

while :; do   
    {
    while read line; do    
        contador=$(($contador + 1))             
        if [[ "$line" == *"34"* && "$line" == *"Wallpaper"* ]]; then
            soma_dez_linhas=0
            linha_atual=0
            soma_dez_linhas=$(($contador + 10))
            linha_atual=$contador
            contador=0
            break
        fi        
        done < /home/$(/usr/bin/whoami)/.config/./plasma-org.kde.plasma.desktop-appletsrc        
        while IFS= read -r line; do
            if [[ "$line" == *'Image='* ]];then
                atual=$line
                atual=$(echo $atual | /usr/bin/cut -c7-999 | /usr/bin/perl -MURI -MURI::Escape -lne 'print uri_unescape(URI->new($_)->path)')
            fi
        done <<< $(/usr/bin/sed -n $linha_atual,$soma_dez_linhas'p' /home/$(/usr/bin/whoami)/.config/./plasma-org.kde.plasma.desktop-appletsrc)   
        atual=$(/usr/bin/echo $atual | /usr/bin/cut -d' ' -f1)    
        } > /dev/null

    if !  test -f "/tmp/wallpaper.pywall.tmp"; then
        echo -e "$atual"  > /tmp/wallpaper.pywall.tmp
    else
        if [ "$(/usr/bin/cat /tmp/wallpaper.pywall.tmp)" != "$atual" ]; then
            /usr/bin/wal -q -e -t -n -i $atual
            {
            while read line; do   
                soma_dez_linhas=0
                linha_atual=0
                contador=$(($contador + 1))        
                if [[ "$line" == *"34"* && "$line" == *"Wallpaper"* ]]; then
                    soma_dez_linhas=0
                    linha_atual=0
                    soma_dez_linhas=$(($contador + 10))
                    linha_atual=$contador
                    contador=0
                    break
                fi        
            done < /home/$(/usr/bin/whoami)/.config/./plasma-org.kde.plasma.desktop-appletsrc        
            while IFS= read -r line; do
                if [[ "$line" == *'Image='* ]];then
                    atual=$line
                    atual=$(/usr/bin/echo $atual | /usr/bin/cut -c7-999 | /usr/bin/perl -MURI -MURI::Escape -lne 'print uri_unescape(URI->new($_)->path)')
                fi
            done <<< $(/usr/bin/sed -n $linha_atual,$soma_dez_linhas'p' /home/$(/usr/bin/whoami)/.config/./plasma-org.kde.plasma.desktop-appletsrc)   
            atual=$(/usr/bin/echo $atual | /usr/bin/cut -d' ' -f1)    
            } > /dev/null
                
            cor_final=$(/usr/bin/cat /home/lucas/.cache/wal/colors | /usr/bin/tail -9 | /usr/bin/head -1 | /usr/bin/tr -d '#')
            disk=$(/usr/bin/cat /home/lucas/.config/plasma-org.kde.plasma.desktop-appletsrc | /usr/bin/grep 'textColor=#' | /usr/bin/head -1 | /usr/bin/cut -c12-17)
            temp=$(/usr/bin/cat /home/lucas/.config/plasma-org.kde.plasma.desktop-appletsrc | /usr/bin/grep 'textColor=#' | /usr/bin/tail -1 | /usr/bin/cut -c12-17)

            /usr/bin/perl -pi -e 's/'"$(/usr/bin/echo 'textColor=#'$disk)"'/'"$(/usr/bin/echo 'textColor=#'$cor_final)"'/g' /home/lucas/.config/plasma-org.kde.plasma.desktop-appletsrc 

            /usr/bin/perl -pi -e 's/'"$(/usr/bin/echo 'textColor=#'$temp)"'/'"$(/usr/bin/echo 'textColor=#'$cor_final)"'/g' /home/lucas/.config/plasma-org.kde.plasma.desktop-appletsrc 
            /bin/bash -c '/usr/bin/killall plasmashell & /usr/bin/sleep 0.2 && /usr/bin/plasmashell &> /dev/null & disown $!' &
        fi
    fi
    
    /usr/bin/sleep 1
    /usr/bin/echo -e "$atual" > /tmp/wallpaper.pywall.tmp
    /usr/bin/sleep 5
done
