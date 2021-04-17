#!/bin/bash
clipboard=$(xclip -o -sel clip)
texto+=($clipboard)
url_prefixo='https://translate.google.com/?sl=en&tl=pt&text='
url_sufixo='&op=translate'

for i in "${texto[@]}"
do
   traduzir+="$i"'%20'
done

google-chrome-stable --new-window $url_prefixo$traduzir$url_sufixo &
