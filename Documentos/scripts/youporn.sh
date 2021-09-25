#!/bin/bash
for i in $(xclip -o); do    
    regex='(https?|ftp|file)://[-A-Za-z0-9\+&@#/%?=~_|!:,.;]*[-A-Za-z0-9\+&@#/%=~_|]'
    if [[ $i =~ $regex ]]
    then 
        chromium $(echo $i | sed "s/pt.pornhub.com/saveporn.net/") &
    fi    
done
