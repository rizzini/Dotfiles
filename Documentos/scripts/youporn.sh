#!/bin/bash
[ ! -f '/home/lucas/Documentos/scripts/xhamster_historico' ] && touch /home/lucas/Documentos/scripts/xhamster_historico;
[ ! -f '/home/lucas/Documentos/scripts/pornhub_historico' ] && touch /home/lucas/Documentos/scripts/pornhub_historico;
[ ! -f '/home/lucas/Documentos/scripts/xvideos_historico' ] && touch /home/lucas/Documentos/scripts/xvideos_historico;
[ ! -f '/home/lucas/Documentos/scripts/xnxx_historico' ] && touch /home/lucas/Documentos/scripts/xnxx_historico;

counter=0;
while :; do
    historico='';
    counter=$(($counter + 1)); 
    clipboard=$(xclip -o);
    regex='(https?|ftp|file)://[-A-Za-z0-9\+&@#/%?=~_|!:,.;]*[-A-Za-z0-9\+&@#/%=~_|]';
    if [[ $clipboard =~ $regex ]] && [[ $clipboard == *"pornhub"* || $clipboard == *"xvideos"* || $clipboard == *"xnxx"* || $clipboard == *"xhamster"* ]]; then 
        if [[ $clipboard == *"pornhub"* ]]; then
            grep -q "$(echo "$clipboard" | cut -d "=" -f2 )" /home/lucas/Documentos/scripts/pornhub_historico;
            if [ "$?" == "1" ]; then
                mkdir -p /home/lucas/Downloads/xxx/pornhub;
                echo "$clipboard" | cut -d "=" -f2  >> /home/lucas/Documentos/scripts/pornhub_historico;
                cd /home/lucas/Downloads/xxx/pornhub/;
                yt-dlp  "$clipboard" &> /dev/null &
                disown $!;
                timeout 1 mpg123 /home/lucas/Documentos/scripts/notify.mp3 &> /dev/null &
            fi 
        elif [[ $clipboard == *"xvideos"* ]]; then
            grep -q "$(echo "$clipboard" | cut -d "/" -f5 )" /home/lucas/Documentos/scripts/xvideos_historico;
            if [ "$?" == "1" ]; then
                mkdir -p /home/lucas/Downloads/xxx/xvideos;
                echo "$clipboard" | cut -d "/" -f5  >> /home/lucas/Documentos/scripts/xvideos_historico;
                cd /home/lucas/Downloads/xxx/xvideos/;
                yt-dlp  "$clipboard" &> /dev/null &
                disown $!;
                timeout 1 mpg123 /home/lucas/Documentos/scripts/notify.mp3 &> /dev/null &
            fi
        elif [[ $clipboard == *"xnxx"* ]]; then
            grep -q "$(echo "$clipboard" | cut -d "/" -f5 )" /home/lucas/Documentos/scripts/xnxx_historico;
            if [ "$?" == "1" ]; then
                mkdir -p /home/lucas/Downloads/xxx/xnxx;
                echo "$clipboard" | cut -d "/" -f5  >> /home/lucas/Documentos/scripts/xnxx_historico;
                cd /home/lucas/Downloads/xxx/xnxx/;
                yt-dlp  "$clipboard" &> /dev/null &
                disown $!;
                timeout 1 mpg123 /home/lucas/Documentos/scripts/notify.mp3 &> /dev/null &
            fi
        elif [[ $clipboard == *"xhamster"* ]]; then
            grep -q "$(echo "$clipboard" | cut -d "/" -f5 )" /home/lucas/Documentos/scripts/xhamster_historico;
            if [ "$?" == "1" ]; then
                mkdir -p /home/lucas/Downloads/xxx/xhamster;
                echo "$clipboard" | cut -d "/" -f5  >> /home/lucas/Documentos/scripts/xhamster_historico;
                cd /home/lucas/Downloads/xxx/xhamster/;
                yt-dlp  "$clipboard" &> /dev/null &
                disown $!;
                timeout 1 mpg123 /home/lucas/Documentos/scripts/youporn.mp3 &> /dev/null &
            fi
        fi
    fi    
if [ $((counter%2)) -eq 0 ]; then    
    echo -ne "Downloads em andamento: ""\033[1;35m$(($(ps aux | grep yt-dlp | grep -v color | wc -l) - 1))\r\033[0m";
fi
sleep 1
done
