#!/bin/bash
if [ -b "/dev/sdb" ]; then
    sdb="1"
fi

if [ -b "/dev/sdc" ]; then
    sdc="1"
fi
    
data1_read_sda2=$(cat /proc/diskstats | grep -w sda | awk '{print $6}');
data1_write_sda2=$(cat /proc/diskstats | grep -w sda | awk '{print $10}');
if [ -n "$sdb" ]; then
    data1_read_sdb=$(cat /proc/diskstats | grep -w sdb | awk '{print $6}');
    data1_write_sdb=$(cat /proc/diskstats | grep -w sdb | awk '{print $10}');
fi
if [ -n "$sdc" ]; then
    data1_read_sdc1=$(cat /proc/diskstats | grep -w sdc | awk '{print $6}');
    data1_write_sdc1=$(cat /proc/diskstats | grep -w sdc | awk '{print $10}');
fi

sleep 1 &&

data2_read_sda2=$(cat /proc/diskstats | grep -w sda | awk '{print $6}');
data2_write_sda2=$(cat /proc/diskstats | grep -w sda | awk '{print $10}');
read_sda2=$((($data2_read_sda2 - $data1_read_sda2) / 2));
write_sda2=$((($data2_write_sda2 - $data1_write_sda2) / 2));
if [ -n "$sdb" ]; then
    data2_read_sdb=$(cat /proc/diskstats | grep -w sdb | awk '{print $6}');
    data2_write_sdb=$(cat /proc/diskstats | grep -w sdb | awk '{print $10}');
    read_sdb=$((($data2_read_sdb - $data1_read_sdb) / 2));
    write_sdb=$((($data2_write_sdb - $data1_write_sdb) / 2));
fi
if [ -n "$sdc" ]; then
    data2_read_sdc1=$(cat /proc/diskstats | grep -w sdc | awk '{print $6}');
    data2_write_sdc1=$(cat /proc/diskstats | grep -w sdc | awk '{print $10}');
    read_sdc1=$((($data2_read_sdc1 - $data1_read_sdc1) / 2));
    write_sdc1=$((($data2_write_sdc1 - $data1_write_sdc1) / 2));
fi


printf " SSD|""R: "$(echo $(( ${read_sda2%% *} / 1024))"MB/s")" W: "$(echo "$(( ${write_sda2%% *} / 1024))MB/s")"\n" ;
# if [ -n "$sdb" ]; then
#     printf "HDD|""R: "$(echo "$(( ${read_sdb%% *} / 1024))MB/s")" W: "$(echo "$(( ${write_sdb%% *} / 1024))MB/s");
# fi
# if [ -n "$sdc" ]; then
#     printf "sdc|""R: "$(echo "$(( ${read_sdc1%% *} / 1024))MB/s")" W: "$(echo "$(( ${write_sdc1%% *} / 1024))MB/s")"\n";
# fi

