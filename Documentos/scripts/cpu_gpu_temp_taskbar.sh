#!/bin/bash
if [ -n "$(/usr/bin/pgrep amule)" ];then
    /usr/bin/printf "Free space: $(/usr/bin/df -h | /usr/bin/grep sda2 | /usr/bin/head -1 | /usr/bin/awk '{print $4}') | CPU: ""$(/usr/bin/echo $(/usr/bin/sensors | /usr/bin/grep 'Package id 0:' | /usr/bin/tail -1 | /usr/bin/cut -c 17-18))""ºc"
else
    /usr/bin/printf "CPU: ""$(/usr/bin/echo $(/usr/bin/sensors | /usr/bin/grep 'Package id 0:' | /usr/bin/tail -1 | /usr/bin/cut -c 17-18))""ºc | "
    if [ -n "$(/usr/bin/lsmod | /usr/bin/grep nouveau)" ]; then
        if [ "$(/usr/bin/sensors | /usr/bin/grep 'temp1:' | /usr/bin/tail -1 | /usr/bin/cut -c 16-17)" == '27' ];then
            temp_gpu=$(/usr/bin/sensors | /usr/bin/grep 'temp1:' | /usr/bin/head -1 | /usr/bin/cut -c 16-17)
        else
            temp_gpu=$(/usr/bin/sensors | /usr/bin/grep 'temp1:' | /usr/bin/tail -1 | /usr/bin/cut -c 16-17)
        fi
        if [ $temp_gpu -ge 70 ];then
            /usr/bin/printf "GPU: ""$(/usr/bin/echo 'ALERTA!')""\n"
        else
            /usr/bin/printf "GPU: ""$(/usr/bin/echo $temp_gpu)""ºc"""
        fi
    else
        temp_gpu=$(/usr/bin/nvidia-smi --query-gpu=temperature.gpu,utilization.gpu --format=csv,nounits,noheader | /usr/bin/cut -c1-2)
    if [ $temp_gpu -ge 70 ];then
        /usr/bin/printf "GPU: ""$(/usr/bin/echo 'ALERTA!')""\n"
    else
        /usr/bin/printf "GPU: ""$(/usr/bin/echo $temp_gpu)""ºc""\n"
    fi
    fi
fi


