#!/bin/bash


while :;do
    test -f /tmp/antigo && touch /tmp/antigo
    atual=$(xclip -o)
    antigo=$(cat /tmp/antigo)
    regex='(https?|ftp|file)://[-A-Za-z0-9\+&@#/%?=~_|!:,.;]*[-A-Za-z0-9\+&@#/%=~_|]'
    if [[ $atual =~ $regex ]];    then 
        echo "$antigo" &> /tmp/antigo
        if [[ ! "$antigo" == *"$atual"*  ]];then
            cat $atual &> /tmp/antigo
            cd /home/lucas/Downloads/
            youtube-dl  "$atual" &> /dev/null &
            echo "Download iniciado. Downloads em andamento: $(ps aux | grep yout | wc -l)"
        else
            echo "Downloads em andamento: $(ps aux | grep yout | wc -l)"
        fi
    
    fi    
echo "Downloads em andamento: $(ps aux | grep yout | wc -l)"
sleep 1
done
