#!/bin/bash
clipboard=$(/usr/bin/xclip -o -sel clip)
if [ -z "$clipboard" ];then
    exit
fi
kdialog --title 'Google Translator' --textinputbox 'Google Translator' "$(/usr/bin/crow -b $clipboard)"
