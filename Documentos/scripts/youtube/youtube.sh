#!/bin/bash

regex='^(http(s)?:\/\/)?((w){3}.)?youtu(be|.be)?(\.com)?\/.+'
string=$(xclip -o)
if [[ $string =~ $regex ]]
then 
    dbusRef=`kdialog --title "Youtube" --progressbar "Link ok. Iniciando download.." 100`
    
    mkdir -p /tmp/youtube
    video_id=$(xclip -o | sed -r 's/^.*[&?]v=(.{11})([&#].*)?$/\1/')
    
    qdbus $dbusRef setLabelText "Baixando.."
    youtube-dl --newline --max-downloads 1  -o  "/tmp/youtube/%(title)s.%(ext)s" -f mp4 -- $video_id 2>&1 \
    | while read -r line; do
        if [[ "$(echo $line | grep '[0-9]*%')" ]];then
            percent=$(echo $line | awk '{print $2}')
            echo "$3${percent%.*}"
            echo "${percent%%.*}"
            qdbus $dbusRef Set "" value $(echo "${percent%%.*}" | sed 's/%//')
        fi

    done  
        
    if [ $? = "0" ]
    then
        dolphin /tmp/youtube/ &
        notify-send  -i /home/lucas/Documentos/scripts/youtube/pngwing.com.png "Download realizado com sucesso."
        qdbus $dbusRef close
    else
        qdbus $dbusRef close
        find /tmp/youtube -name "*.part" -type f -delete
        notify-send --urgency=critical -i /home/lucas/Documentos/scripts/youtube/pngwing.com.png "Erro ao baixar o vídeo do youtube..."
    fi
else
    qdbus $dbusRef close
    notify-send --urgency=critical -i /home/lucas/Documentos/scripts/youtube/pngwing.com.png "Link inválido..."
fi
