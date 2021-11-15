#!/bin/bash
re='^(http:\/\/www\.|https:\/\/www\.|http:\/\/|https:\/\/)?[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$'
url=$(/usr/bin/xclip -o)
if [[ $url =~ $re ]]; then 
    /usr/bin/surl -c "$url" | /usr/bin/xclip -selection clipboard
    if [ $? -eq 0 ];then
        /usr/bin/notify-send "Url encurtada com sucesso."
    else
        /usr/bin/notify-send "Link válido, mas houve algum problema ao encurtar o link"
    fi
else
    /usr/bin/notify-send "Link inválido."
fi
