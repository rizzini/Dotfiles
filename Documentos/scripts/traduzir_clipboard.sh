#!/bin/bash
clipboard=$(/usr/bin/xclip -o -sel clip)
pointer_x=$(xdotool getmouselocation | cut -c3-6 | tr -d 'y:' | tr -d ' ')
pointer_y=$(xdotool getmouselocation | grep -Po 'y:\K[^"][^"][^"][^"]' | tr -d 'sc' | tr -d ' ')
if [ -n "$clipboard" ];then
    kdialog --title 'Google Translator' --geometry=400x200+$pointer_x+$pointer_y --textinputbox 'Texto traduzido:' "$(/usr/bin/crow -b $clipboard)";
    #zenity --info --title 'Google Translator' --text="$(/usr/bin/crow -b $clipboard)" --width=400 --height=200
fi

