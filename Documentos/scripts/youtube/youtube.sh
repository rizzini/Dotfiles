#!/bin/bash
SCRIPT=$(readlink -f $0)
SCRIPTPATH=`dirname $SCRIPT`
cancelado=0
converter=0
matar_se_cancelado(){
if [ -z "$(pgrep kdialog)" ]; then
    while [[ -n "$(pgrep youtube-dl)" && -n "$(pgrep HandBrakeCLI)" ]]; do
        killall -9 youtube-dl HandBrakeCLI;
    done
    find /tmp/youtube_reddit -name '*.ytdl' -type f -delete 
    find /tmp/youtube_reddit -name '*.part' -type f -delete
    if [[ $reddit -eq 1 && $converter -eq 1 ]]; then
        find /tmp/youtube_reddit/ -type f -printf '%T@ %p\n' | sort -n | tail -1 | cut -f2- -d" " | xargs rm
    fi
    
    qdbus $dbusRef close
    exit
fi
}
command -v notify-send
if [ $? -eq 1 ]; then
    i+=('libnotify');
fi
command -v notify-send
if [ $? -eq 1 ]; then
    i+=('kdialog');
fi
command -v xdg-open
if [ $? -eq 1 ]; then
    i+=('xdg-utils');
fi
command -v qdbus
if [ $? -eq 1 ]; then
    i+=('qt5-tools');
fi
command -v ps
if [ $? -eq 1 ]; then
    i+=('procps-ng');
fi
command -v killall
if [ $? -eq 1 ]; then
    i+=('psmisc');
fi
if [[ -n "${i[@]}" ]]; then
    kdialog --title 'Dependências' --error "Os seguintes pacotes não foram encontrados: $(echo "${i[*]}"'.' | xargs | sed -e 's/ /, /g' )\n\nO nome dos pacotes pode variar dependendo da sua destribuição Linux. Com uma rápida busca no google, você conseguira achar o pacote correspondente p/ sua destribuição."
    exit
fi

regex='^(http(s)?:\/\/)?((w){3}.)?(reddit|youtube)?(\.com)?\/.+'
string=$(xclip -o)
if [[ $string == *"reddit.com"* ]]; then
    reddit=1
else    
    reddit=0
fi
if [[ $string =~ $regex ]]; then  
    mkdir -p /tmp/youtube_reddit    
    if [ $reddit -eq 0 ]; then
        dbusRef=`kdialog --title "YouTube" --progressbar "Iniciando download.." 100`
        video_id=$(xclip -o | sed -r 's/^.*[&?]v=(.{11})([&#].*)?$/\1/')    
        qdbus $dbusRef setLabelText "Baixando vídeo do Youtube.."
        youtube-dl --newline --max-downloads 3 -o  "/tmp/youtube_reddit/%(title)s.%(ext)s" --restrict-filenames -- $video_id 2>&1 \
        | while read -r line; do
            matar_se_cancelado
            if [[ $line == *"[download]"* ]];then
                line=$(echo $line | awk '{print $2}' | tr -d '%')
                qdbus $dbusRef Set "" value $(echo ${line%.*})
            fi
        done  
    elif [ $reddit -eq 1 ]; then
        dbusRef=`kdialog --title "Reddit" --progressbar "Iniciando download.." 100`
        qdbus $dbusRef setLabelText "Baixando vídeo do Reddit"
        youtube-dl --newline --max-downloads 3 -f mp4 -o  "/tmp/youtube_reddit/%(title)s" --restrict-filenames -- $string 2>&1 \
        | while read -r line; do
            matar_se_cancelado
            if [[ "$(echo $line | grep '[0-9]*%')" ]];then
                percent=$(echo $line | awk '{print $2}')
                echo "$3${percent%.*}"
                echo "${percent%%.*}"
                qdbus $dbusRef Set "" value $(echo "${percent%%.*}" | sed 's/%//')
            fi
        done 
    fi
    if [ $? = "0" ]; then
        if [ $reddit -eq 1 ]; then
            kdialog --yesno 'Deseja converter o vídeo do Reddit?'
            if [ $? = "0" ]; then
                converter=1
                arquivo_baixado=$(find /tmp/youtube_reddit/ -type f -printf '%T@ %p\n' | sort -n | tail -1 | cut -f2- -d" " )  
                qdbus $dbusRef setLabelText "Convertendo.."
                HandBrakeCLI --json  -i $arquivo_baixado -o "/tmp/youtube_reddit/"$(echo $arquivo_baixado | cut -c21-999 | sed 's/.*/convertido_&/') -e x264 2>&1 \
                | while read -r line; do
                    matar_se_cancelado
                    if [[ $line == *"Progress"* ]]; then
                        if [[ $line = *[[:digit:]]* ]]; then
                            porcentagem=$(echo $line | cut -c13-999 | tr -d ',' | cut -c3-4)
                            qdbus $dbusRef Set "" value $porcentagem
                        fi            
                    fi
                  done  
            fi
        fi
        xdg-open /tmp/youtube_reddit/ &
        notify-send  -i $SCRIPTPATH/youtube_reddit.png "Download realizado com sucesso."
        qdbus $dbusRef close
    else
        qdbus $dbusRef close
        find /tmp/youtube_reddit -name "*.part" -type f -delete
        notify-send --urgency=critical -i $SCRIPTPATH/youtube_reddit.png "Erro ao baixar o vídeo..."
    fi
else
    qdbus $dbusRef close
    notify-send --urgency=critical -i $SCRIPTPATH/youtube_reddit.png "Link inválido..."
fi
