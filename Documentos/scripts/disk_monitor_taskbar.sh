#!/bin/bash
if [ -b "/dev/sdb" ]; then
    sdb="1";
fi
if [ -b "/dev/sdc" ]; then
    sdc="1";
fi
data1_read_sda2=$(/usr/bin/grep -w sda /proc/diskstats | /usr/bin/awk '{print $6}');
data1_write_sda2=$(/usr/bin/grep -w sda /proc/diskstats | /usr/bin/awk '{print $10}');
if [ -n "$sdb" ]; then
    data1_read_sdb=$(/usr/bin/grep -w sdb /proc/diskstats | /usr/bin/awk '{print $6}');
    data1_write_sdb=$(/usr/bin/grep -w sdb /proc/diskstats | /usr/bin/awk '{print $10}');
fi
if [ -n "$sdc" ]; then
    data1_read_sdc=$(/usr/bin/grep -w sdc /proc/diskstats | /usr/bin/awk '{print $6}');
    data1_write_sdc=$(/usr/bin/grep -w sdc /proc/diskstats | /usr/bin/awk '{print $10}');
fi
/usr/bin/sleep 0.5 &&
data2_read_sda2=$(/usr/bin/grep -w sda /proc/diskstats | /usr/bin/awk '{print $6}');
data2_write_sda2=$(/usr/bin/grep -w sda /proc/diskstats | /usr/bin/awk '{print $10}');
read_sda2=$((data2_read_sda2 - data1_read_sda2));
write_sda2=$((data2_write_sda2 - data1_write_sda2));
if [ -n "$sdb" ]; then
    data2_read_sdb=$(/usr/bin/grep -w sdb /proc/diskstats | /usr/bin/awk '{print $6}');
    data2_write_sdb=$(/usr/bin/grep -w sdb /proc/diskstats | /usr/bin/awk '{print $10}');
    read_sdb=$((data2_read_sdb - data1_read_sdb));
    write_sdb=$((data2_write_sdb - data1_write_sdb));
fi
if [ -n "$sdc" ]; then
    data2_read_sdc=$(/usr/bin/grep -w sdc /proc/diskstats | /usr/bin/awk '{print $6}');
    data2_write_sdc=$(/usr/bin/grep -w sdc /proc/diskstats | /usr/bin/awk '{print $10}');
    read_sdc=$((data2_read_sdc - data1_read_sdc));
    write_sdc=$((data2_write_sdc - data1_write_sdc));
fi
/usr/bin/printf "SSD|""R: $(/usr/bin/echo "$((${read_sda2%%}/1024))MB/s") W: $(/usr/bin/echo "$((${write_sda2%%}/1024))MB/s")\n" ;
if [ -n "$sdb" ]; then
    /usr/bin/printf "HDD|""R: $(/usr/bin/echo "$((${read_sdb%%}/1024))MB/s") W: $(/usr/bin/echo "$((${write_sdb%%}/1024))MB/s")\n";
fi
if [ -n "$sdc" ]; then
    /usr/bin/printf "sdc|""R: $(/usr/bin/echo "$((${read_sdc%%}/1024))MB/s") W: $(/usr/bin/echo "$((${write_sdc%%}/1024))MB/s")\n";
fi
