#!/bin/bash
counter=0
mkdir -p /home/lucas/Downloads/xxx/
while :;do
    counter=$(($counter + 1))
    test -f /tmp/antigo && touch /tmp/antigo
    atual=$(xclip -o)
    antigo=$(cat /tmp/antigo)
    regex='(https?|ftp|file)://[-A-Za-z0-9\+&@#/%?=~_|!:,.;]*[-A-Za-z0-9\+&@#/%=~_|]'
    if [[ $atual =~ $regex ]];    then 
        echo "$antigo" &> /tmp/antigo
        if [[ ! "$antigo" == *"$atual"*  ]];then
            cat $atual &> /tmp/antigo
            cd /home/lucas/Downloads/xxx/
            youtube-dl  "$atual" &> /dev/null &
            disown $!
            timeout 1 cvlc /home/lucas/Documentos/scripts/youporn.mp3 &> /dev/null &
        fi
    
    fi    
if [ $((counter%2)) -eq 0 ];
then
    
    echo -ne "Downloads em andamento: ""$(($(ps aux | grep yout | grep -v color | wc -l) - 1))\033[0K\r"
fi
sleep 1
done
