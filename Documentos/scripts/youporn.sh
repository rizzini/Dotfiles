#!/bin/bash
if [ "$1" == 'taskbar' ];then
    /usr/bin/echo -ne "Espaço livre: $(/usr/bin/df -h | /usr/bin/grep sda2 | /usr/bin/head -1 | /usr/bin/awk '{print $4}') / Downloads: ""$(($(/usr/bin/ps aux | /usr/bin/grep yt-dlp | /usr/bin/grep -v color | /usr/bin/wc -l) - 1))\r";
    exit
fi
rm /home/lucas/Documentos/scripts/xnxx_historico /home/lucas/Documentos/scripts/xvideos_historico /home/lucas/Documentos/scripts/pornhub_historico /home/lucas/Documentos/scripts/xhamster_historico &> /dev/null
[ ! -f '/home/lucas/Documentos/scripts/xhamster_historico' ] && /usr/bin/touch /home/lucas/Documentos/scripts/xhamster_historico;
[ ! -f '/home/lucas/Documentos/scripts/pornhub_historico' ] && /usr/bin/touch /home/lucas/Documentos/scripts/pornhub_historico;
[ ! -f '/home/lucas/Documentos/scripts/xvideos_historico' ] && /usr/bin/touch /home/lucas/Documentos/scripts/xvideos_historico;
[ ! -f '/home/lucas/Documentos/scripts/xnxx_historico' ] && /usr/bin/touch /home/lucas/Documentos/scripts/xnxx_historico;
[ ! -d '/home/lucas/Downloads/megasync_temp/' ] && /usr/bin/mkdir -p /home/lucas/Downloads/megasync_temp/;
[ ! -d '/home/lucas/Downloads/xxx' ] && /usr/bin/mkdir -p /home/lucas/Downloads/xxx/;
counter=0;
while :; do
    for i in $(/usr/bin/ls /home/lucas/Downloads/megasync_temp/ | cut -d "[" -f2 | cut -d "]" -f1); do
        videos_baixados+=("$i")
    done
    historico='';
    ja_baixado=0;
    counter=$(($counter + 1)); 
    clipboard=$(/usr/bin/xclip -o);
    regex='(https?)://[-A-Za-z0-9\+&@#/%?=~_|!:,.;]*[-A-Za-z0-9\+&@#/%=~_|]';
    if [[ $clipboard =~ $regex ]] && [[ $clipboard == *"pornhub"* || $clipboard == *"xvideos"* || $clipboard == *"xnxx"* || $clipboard == *"xhamster"* ]]; then 
        if [[ $clipboard == *"pornhub"* ]]; then
            /usr/bin/grep -q "$(echo "$clipboard" | /usr/bin/cut -d "=" -f2 )" /home/lucas/Documentos/scripts/pornhub_historico;
            if [ "$?" == "1" ]; then
                for i in "${videos_baixados[@]}"; do
                    if [ "$(echo "$clipboard" | /usr/bin/cut -d "=" -f2 )" == "$i" ];then
                        ja_baixado=1
                    fi
                done
                if [ $ja_baixado -eq 0 ];then
                    /usr/bin/ffplay  -nodisp -autoexit  -volume 40 /home/lucas/Documentos/scripts/notify.mp3 &> /dev/null & 
                    /usr/bin/mkdir -p /home/lucas/Downloads/xxx/pornhub;
                    /usr/bin/echo "$clipboard" | /usr/bin/cut -d "=" -f2  >> /home/lucas/Documentos/scripts/pornhub_historico;
                    cd /home/lucas/Downloads/xxx/pornhub/;
                    /usr/bin/yt-dlp "$clipboard" &> /dev/null &
                    disown $!;
                    clipboard=''
                fi
            fi 
        elif [[ $clipboard == *"xvideos"* ]]; then
            /usr/bin/grep -q "$(/usr/bin/echo "$clipboard" | /usr/bin/cut -d "/" -f5 )" /home/lucas/Documentos/scripts/xvideos_historico;
            if [ "$?" == "1" ]; then
                /usr/bin/ffplay  -nodisp -autoexit  -volume 40 /home/lucas/Documentos/scripts/notify.mp3 &> /dev/null & 
                /usr/bin/mkdir -p /home/lucas/Downloads/xxx/xvideos;
                /usr/bin/echo "$clipboard" | /usr/bin/cut -d "/" -f5  >> /home/lucas/Documentos/scripts/xvideos_historico;
                cd /home/lucas/Downloads/xxx/xvideos/;
                /usr/bin/yt-dlp "$clipboard" &> /dev/null &
                disown $!;
            fi
        elif [[ $clipboard == *"xnxx"* ]]; then
            /usr/bin/grep -q "$(/usr/bin/echo "$clipboard" | /usr/bin/cut -d "/" -f5 )" /home/lucas/Documentos/scripts/xnxx_historico;
            if [ "$?" == "1" ]; then
                /usr/bin/ffplay  -nodisp -autoexit  -volume 40 /home/lucas/Documentos/scripts/notify.mp3 &> /dev/null & 
                /usr/bin/mkdir -p /home/lucas/Downloads/xxx/xnxx;
                /usr/bin/echo "$clipboard" | /usr/bin/cut -d "/" -f5  >> /home/lucas/Documentos/scripts/xnxx_historico;
                cd /home/lucas/Downloads/xxx/xnxx/;
                /usr/bin/yt-dlp "$clipboard" &> /dev/null &
                disown $!;
            fi
        elif [[ $clipboard == *"xhamster"* ]]; then
            /usr/bin/grep -q "$(/usr/bin/echo "$clipboard" | /usr/bin/cut -d "/" -f5 )" /home/lucas/Documentos/scripts/xhamster_historico;
            if [ "$?" == "1" ]; then
                /usr/bin/ffplay  -nodisp -autoexit  -volume 40 /home/lucas/Documentos/scripts/notify.mp3 &> /dev/null & 
                /usr/bin/mkdir -p /home/lucas/Downloads/xxx/xhamster;
                /usr/bin/echo "$clipboard" | /usr/bin/cut -d "/" -f5  >> /home/lucas/Documentos/scripts/xhamster_historico;
                cd /home/lucas/Downloads/xxx/xhamster/;
                /usr/bin/yt-dlp "$clipboard" &> /dev/null &
                disown $!;
            fi
        fi
    fi    
if [ $((counter%2)) -eq 0 ]; then
    /usr/bin/find /home/lucas/Downloads/xxx/ -iname "*.mp4" -exec mv {} /home/lucas/Downloads/megasync_temp/ \;
    /usr/bin/echo -ne "Espaço livre: $(/usr/bin/df -h | /usr/bin/grep sda2 | /usr/bin/head -1 | /usr/bin/awk '{print $4}') / Downloads em andamento: ""\033[1;35m$(($(/usr/bin/ps aux | /usr/bin/grep yt-dlp | /usr/bin/grep -v color | /usr/bin/wc -l) - 1))\r\033[0m";
fi
/usr/bin/sleep 1
printf "$(ps auxm | grep 'yt-dlp' | awk '{print $13}')\n" &> /home/lucas/Downloads/xxx/links.txt
killall -9 ffmpeg &> /dev/null &
done
