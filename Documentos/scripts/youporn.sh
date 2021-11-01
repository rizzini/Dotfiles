#!/bin/bash
counter=0
mkdir -p /home/lucas/Downloads/xxx/
while :;do
historico=''
    counter=$(($counter + 1)) 
    atual=$(xclip -o)
    regex='(https?|ftp|file)://[-A-Za-z0-9\+&@#/%?=~_|!:,.;]*[-A-Za-z0-9\+&@#/%=~_|]'
    if [[ $atual =~ $regex && $atual == *"pornhub"* ]];    then 
        grep -q "$(echo "$atual" | cut -d "=" -f2 )" /home/lucas/Documentos/scripts/youporn_historico
        if [ "$?" == "1" ];then
            echo "$atual" | cut -d "=" -f2  >> /home/lucas/Documentos/scripts/youporn_historico
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
