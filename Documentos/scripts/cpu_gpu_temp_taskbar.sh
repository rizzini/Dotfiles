#!/bin/bash
/usr/bin/printf "CPU: ""$(/usr/bin/echo $(/usr/bin/sensors | /usr/bin/grep 'Package id 0:' | /usr/bin/tail -1 | /usr/bin/cut -c 17-18))""ºc"" | " 


if [ -n "$(lsmod | grep nouveau)" ]; then
    /usr/bin/printf "GPU: ""$(/usr/bin/sensors | /usr/bin/grep 'temp1:' | /usr/bin/tail -1 | /usr/bin/cut -c 16-17)""ºc"""
else
    temp_gpu=$(nvidia-smi --query-gpu=temperature.gpu,utilization.gpu --format=csv,nounits,noheader | cut -c1-2)
    if [ $temp_gpu -ge 70 ];then
        /usr/bin/printf "GPU: ""$(/usr/bin/echo 'ALERTA!')""\n"
    else
        /usr/bin/printf "GPU: ""$(/usr/bin/echo $temp_gpu)""ºc""\n"
    fi
fi