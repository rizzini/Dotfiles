#!/bin/bash


while :;do
    test -f /tmp/antigo && touch /tmp/antigo
    atual=$(xclip -o)
    echo $atual
    antigo=$(cat /tmp/antigo)
    regex='(https?|ftp|file)://[-A-Za-z0-9\+&@#/%?=~_|!:,.;]*[-A-Za-z0-9\+&@#/%=~_|]'
    if [[ $atual =~ $regex ]];    then 
        echo "$antigo" &> /tmp/antigo
        if [[ ! "$antigo" == *"$atual"*  ]];then
            cat $atual &> /tmp/antigo
            cd /home/lucas/Downloads/
            youtube-dl  "$atual" &> /dev/null &
        else
            echo "EQUAL"
        fi
    
    fi    

sleep 1
done
