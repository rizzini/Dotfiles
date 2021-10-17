#!/usr/bin/env bash
# Dependencies: scrot tesseract-ocr imagemagick
language=${1:-eng}
set -e
image_file=/tmp/clipboard.png
output_file=/tmp/clipboard
trap 'rm $image_file*' EXIT
scrot -a $(slop -f '%x,%y,%w,%h') "$image_file"
mogrify -modulate 100,0 -resize 400% "$image_file" # should increase detection rate
tesseract -l $language "$image_file" "$output_file" &> /dev/null
cat $output_file.txt | xclip -se c

