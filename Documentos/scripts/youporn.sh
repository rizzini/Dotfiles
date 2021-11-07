#!/bin/bash
counter=0
while :; do
historico=''
    counter=$(($counter + 1)) 
    atual=$(xclip -o)
    regex='(https?|ftp|file)://[-A-Za-z0-9\+&@#/%?=~_|!:,.;]*[-A-Za-z0-9\+&@#/%=~_|]'
    if [[ $atual =~ $regex ]] && [[ $atual == *"pornhub"* || $atual == *"xvideos"* || $atual == *"xnxx"* || $atual == *"xhamster"* ]]; then 
        if [[ $atual == *"pornhub"* ]]; then
            grep -q "$(echo "$atual" | cut -d "=" -f2 )" /home/lucas/Documentos/scripts/pornhub_historico
            if [ "$?" == "1" ]; then
                mkdir -p /home/lucas/Downloads/xxx/pornhub
                echo "$atual" | cut -d "=" -f2  >> /home/lucas/Documentos/scripts/pornhub_historico
                cd /home/lucas/Downloads/xxx/pornhub/
                yt-dlp  "$atual" &> /dev/null &
                disown $!
                timeout 1 mpg123 /home/lucas/Documentos/scripts/notify.mp3 &> /dev/null &
            fi 
        elif [[ $atual == *"xvideos"* ]]; then
            grep -q "$(echo "$atual" | cut -d "/" -f5 )" /home/lucas/Documentos/scripts/xvideos_historico
            if [ "$?" == "1" ]; then
                mkdir -p /home/lucas/Downloads/xxx/xvideos
                echo "$atual" | cut -d "/" -f5  >> /home/lucas/Documentos/scripts/xvideos_historico
                cd /home/lucas/Downloads/xxx/xvideos/
                yt-dlp  "$atual" &> /dev/null &
                disown $!
                timeout 1 mpg123 /home/lucas/Documentos/scripts/notify.mp3 &> /dev/null &
            fi
        elif [[ $atual == *"xnxx"* ]]; then
            grep -q "$(echo "$atual" | cut -d "/" -f5 )" /home/lucas/Documentos/scripts/xnxx_historico
            if [ "$?" == "1" ]; then
                mkdir -p /home/lucas/Downloads/xxx/xnxx
                echo "$atual" | cut -d "/" -f5  >> /home/lucas/Documentos/scripts/xnxx_historico
                cd /home/lucas/Downloads/xxx/xnxx/
                yt-dlp  "$atual" &> /dev/null &
                disown $!
                timeout 1 mpg123 /home/lucas/Documentos/scripts/notify.mp3 &> /dev/null &
            fi
        elif [[ $atual == *"xhamster"* ]]; then
            grep -q "$(echo "$atual" | cut -d "/" -f5 )" /home/lucas/Documentos/scripts/xhamster_historico
            if [ "$?" == "1" ]; then
                mkdir -p /home/lucas/Downloads/xxx/xhamster
                echo "$atual" | cut -d "/" -f5  >> /home/lucas/Documentos/scripts/xhamster_historico
                cd /home/lucas/Downloads/xxx/xhamster/
                yt-dlp  "$atual" &> /dev/null &
                disown $!
                timeout 1 mpg123 /home/lucas/Documentos/scripts/youporn.mp3 &> /dev/null &
            fi
        fi
    fi    
if [ $((counter%2)) -eq 0 ]; then    
    COLOR='\033[1;35m'
    NOCOLOR='\033[0m'
    echo -ne "Downloads em andamento: ""${COLOR}$(($(ps aux | grep yt-dlp | grep -v color | wc -l) - 1))\r${NOCOLOR}"
fi
sleep 1
done
