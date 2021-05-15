#!/bin/bash
clipboard=$(xclip -o -sel clip)
texto+=($clipboard)
url_prefixo='https://translate.google.com/?sl=en&tl=pt&text='
url_sufixo='&op=translate'
re='^[0-9]+$'

for i in "${texto[@]}"
do  
    if [[ "$i" == *'%'* ]]; then
        i=$(echo $i'25')
    fi
    traduzir+="$i"'%20'
done

google-chrome-stable --new-window $url_prefixo$traduzir$url_sufixo &
