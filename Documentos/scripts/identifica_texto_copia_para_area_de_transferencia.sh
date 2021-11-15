#!/bin/bash
# Dependencies: scrot tesseract-ocr imagemagick
language=${1:-eng}
# set -e
image_file=/tmp/clipboard.png
output_file=/tmp/clipboard
trap 'rm $image_file*' EXIT
/usr/bin/scrot -a $(/usr/bin/slop -f '%x,%y,%w,%h') "$image_file"
/usr/bin/mogrify -modulate 100,0 -resize 400% "$image_file" # should increase detection rate
/usr/bin/tesseract -l $language "$image_file" "$output_file" &> /dev/null
/usr/bin/cat $output_file.txt | /usr/bin/xclip -se c

