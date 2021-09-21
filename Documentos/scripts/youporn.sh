#!/bin/bash
for i in $(xclip -o); do    
    regex='(https?|ftp|file)://[-A-Za-z0-9\+&@#/%?=~_|!:,.;]*[-A-Za-z0-9\+&@#/%=~_|]'
    if [[ $i =~ $regex ]]
    then 
        url=$(echo $i | sed "s/pt.pornhub.com/saveporn.net/")
        wget $url -O /tmp/porn_tmp
        if [ -n "$(cat /tmp/porn_tmp | grep '<td>1080 </td>')" ];then
           chromium "https://saveporn.net""$(cat /tmp/porn_tmp | grep '<td>1080 </td>' | cut -c45-99)" &
        elif [ -n "$(cat /tmp/porn_tmp | grep '<td>720 </td>')" ];then
            chromium "https://saveporn.net""$(cat /tmp/porn_tmp | grep '<td>720 </td>' | cut -c45-99)" &
        elif [ -n "$(cat /tmp/porn_tmp | grep '<td>480 </td>')" ];then
            chromium "https://saveporn.net""$(cat /tmp/porn_tmp | grep '<td>720 </td>' | cut -c45-99)" &
        fi
    fi    
done

