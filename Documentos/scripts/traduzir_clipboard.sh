#!/bin/bash
clipboard=$(/usr/bin/xclip -o -sel clip)
pointer_x=$(xdotool getmouselocation | /usr/bin/cut -c3-6 | /usr/bin/tr -d 'y:' | /usr/bin/tr -d ' ')
pointer_y=$(xdotool getmouselocation | /usr/bin/grep -Po 'y:\K[^"][^"][^"][^"]' | /usr/bin/tr -d 'sc' | /usr/bin/tr -d ' ')
if [ -n "$clipboard" ];then
    /usr/bin/kdialog --title 'Google Translator' --geometry=400x200+$pointer_x+$pointer_y --textinputbox 'Texto traduzido:' "$(/usr/bin/crow -b $clipboard)";
    #zenity --info --title 'Google Translator' --text="$(/usr/bin/crow -b $clipboard)" --width=400 --height=200
fi

