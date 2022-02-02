#!/bin/bash
/usr/bin/printf "CPU: ""$(/usr/bin/echo $(/usr/bin/sensors | /usr/bin/grep 'Package id 0:' | /usr/bin/tail -1 | /usr/bin/cut -c 17-18))""ºc"
# if [ -n "$(/usr/bin/lsmod | /usr/bin/grep nouveau)" ]; then
#     if [ "$(/usr/bin/sensors | /usr/bin/grep 'temp1:' | /usr/bin/tail -1 | /usr/bin/cut -c 16-17)" == '27' ];then
#         temp_gpu=$(/usr/bin/sensors | /usr/bin/grep 'temp1:' | /usr/bin/head -1 | /usr/bin/cut -c 16-17)
#     else
#         temp_gpu=$(/usr/bin/sensors | /usr/bin/grep 'temp1:' | /usr/bin/tail -1 | /usr/bin/cut -c 16-17)
#     fi
#     if [ $temp_gpu -ge 70 ];then
#         /usr/bin/printf "GPU: ""$(/usr/bin/echo 'ALERTA!')""\n"
#     else
#         /usr/bin/printf "GPU: ""$(/usr/bin/echo $temp_gpu)""ºc"""
#     fi
# elif [ -n "$(/usr/bin/lsmod | /usr/bin/grep nvidia)" ]; then
#     temp_gpu=$(/usr/bin/nvidia-smi --query-gpu=temperature.gpu,utilization.gpu --format=csv,nounits,noheader | /usr/bin/cut -c1-2)
#     case $temp_gpu in
#         ''|*[!0-9]*) echo '' ;;
#         *) if [ $temp_gpu -ge 70 ];then
#                 /usr/bin/printf " | GPU: ""$(/usr/bin/echo 'ALERTA!')""\n"
#         else
#                 /usr/bin/printf " | GPU: ""$(/usr/bin/echo $temp_gpu)""ºc""\n"
#         fi
#         ;;
#     esac
# fi
