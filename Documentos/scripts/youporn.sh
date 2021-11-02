#!/bin/bash
counter=0
mkdir -p /home/lucas/Downloads/xxx/
while :;do
historico=''
    counter=$(($counter + 1)) 
    atual=$(xclip -o)
    regex='(https?|ftp|file)://[-A-Za-z0-9\+&@#/%?=~_|!:,.;]*[-A-Za-z0-9\+&@#/%=~_|]'
    if [[ $atual =~ $regex ]] && [[ $atual == *"pornhub"* || $atual == *"xvideos"* ]];    then 
        if [[ $atual == *"pornhub"* ]];then
            grep -q "$(echo "$atual" | cut -d "=" -f2 )" /home/lucas/Documentos/scripts/youporn_historico
            if [ "$?" == "1" ];then
                echo "$atual" | cut -d "=" -f2  >> /home/lucas/Documentos/scripts/youporn_historico
                cd /home/lucas/Downloads/xxx/
                youtube-dl  "$atual" &> /dev/null &
                disown $!
                timeout 1 mpg123 /home/lucas/Documentos/scripts/youporn.mp3 &> /dev/null &
            fi 
        elif [[ $atual == *"xvideos"* ]];then
            grep -q "$(echo "$atual" | cut -d "/" -f5 )" /home/lucas/Documentos/scripts/xvideos_historico
            if [ "$?" == "1" ];then
                echo "$atual" | cut -d "/" -f5  >> /home/lucas/Documentos/scripts/xvideos_historico
                cd /home/lucas/Downloads/xxx/
                youtube-dl  "$atual" &> /dev/null &
                disown $!
                timeout 1 mpg123 /home/lucas/Documentos/scripts/youporn.mp3 &> /dev/null &
            fi
        fi
    fi    
if [ $((counter%2)) -eq 0 ];
then    
    RED='\033[1;35m'
    NOCOLOR='\033[0m'
    echo -ne "Downloads em andamento: ""${RED}$(($(ps aux | grep yout | grep -v color | wc -l) - 1))\033[0K\r${NOCOLOR}"
fi
sleep 1
done
