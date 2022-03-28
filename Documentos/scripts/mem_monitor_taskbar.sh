#!/bin/bash
size () {
    local -a units
    local -i scale
    scale=1000
    units=(B KB MB GB TB EB PB YB ZB)
    local -i unit=0
    if [ -z "${units[0]}" ]
    then
        unit=1
    fi
    local -i whole=${1:-0}
    local -i remainder=0
    while (( whole >= $scale ))
    do
        remainder=$(( whole % scale ))
        whole=$((whole / scale))
        unit=$(( $unit + 1 ))
    done
    local decimal
    if [ $remainder -gt 0 ]
    then
        local -i fraction="$(( (remainder * 10 / scale)))"
        if [ "$fraction" -gt 0 ]
        then
            decimal=".$fraction"
        fi
    fi
    echo "${whole}${decimal}${units[$unit]}"
}
writeback=$(size $(/usr/bin/cat  /proc/meminfo | /usr/bin/grep 'Writeback:' | /usr/bin/awk '{print $2}')000)
dirty=$(size $(/usr/bin/cat  /proc/meminfo | /usr/bin/grep 'Dirty:' | /usr/bin/awk '{print $2}')000)
echo "Dirty: "$dirty "|" "Writeback: "$writeback
