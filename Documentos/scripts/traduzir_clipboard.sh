#!/bin/bash
clipboard=$(/usr/bin/xclip -o -sel clip)
if [ -n "$clipboard" ];then
    kdialog --title 'Google Translator' --textinputbox 'Google Translator' "$(/usr/bin/crow -b $clipboard)";
fi

