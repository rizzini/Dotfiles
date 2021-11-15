#!/bin/bash
clipboard=$(/usr/bin/xclip -o -sel clip)
texto+=($clipboard)
url_prefixo='https://translate.google.com/?sl=en&tl=pt&text='
url_sufixo='&op=translate'
#corrigir tradução quando após % vier um ponto. Ex.: it wasn't 100%.

for i in "${texto[@]}"
do  
    if [[ "$i" == *'%'* ]]; then
        i=$(/usr/bin/echo $i'25')
    fi
    traduzir+="$i"'%20'
done

/usr/bin/chromium $url_prefixo$traduzir$url_sufixo &
