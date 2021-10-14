#!/bin/bash
for i in $(xclip -o); do    
    regex='(https?|ftp|file)://[-A-Za-z0-9\+&@#/%?=~_|!:,.;]*[-A-Za-z0-9\+&@#/%=~_|]'
    if [[ $i =~ $regex ]]
    then 
        youtube-dl  "$i" &> /dev/null &

    fi    
done
