#!/bin/bash
re='^(http:\/\/www\.|https:\/\/www\.|http:\/\/|https:\/\/)?[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$'
url=$(xclip -o)
if [[ $url =~ $re ]]; then 
    surl -c "$url" | xclip -selection clipboard
    notify-send "Url encurtada com sucesso."
else
    notify-send "Link inválido."
fi
