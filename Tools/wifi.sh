#!/usr/bin/env bash

if [[ -z $2 ]]
then
    echo '''Usage: ./wifi.sh interface ssid [options]
Options:
  -d
    Run dhcpcd after connection.'''
    exit 1
fi

best_bss=""
best_signal="-10000.00"

echo "Trying to connect to $2"

while read -r line
do
    case $line in
        *BSS*)
            bss=`echo $line | cut -f2 -d' ' | cut -f1 -d'('`
            ;;
        *signal*)
            signal=`echo $line | cut -f2 -d' '`
            ;;
        *$2*)
            if [ `echo "$signal > $best_signal" | bc` -eq 1 ]
            then
                best_signal=$signal
                best_bss=$bss
            fi
            ;;
    esac
done <<< `ip link set $1 up && iw dev $1 scan | grep "^BSS\|signal\|$2"`

echo "Connecting to ap $best_bss with signal $best_signal mdB"
iwconfig $1 essid $2 ap $best_bss
if [[ $3 = "-d" ]]
then
    dhcpcd $1
fi
