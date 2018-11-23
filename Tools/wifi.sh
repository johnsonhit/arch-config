#!/usr/bin/env bash

USAGE='''Usage: ./wifi.sh interface ssid [options]
Options:
  -w
    Connect to a wireless network with WPA.
  -d
    Run dhcpcd after connection.'''

interface=''
ssid=''
wpa=false
dhcp=false

while [ $# -ne 0 ]
do
    case "$1" in
        -w)
            wpa=true
            ;;
        -d)
            dhcp=true
            ;;
        *)
            if [ -z "$interface" ]
            then
                interface="$1"
            elif [ -z "$ssid" ]
            then
                ssid="$1"
            else
                echo "$USAGE"
                exit 1
            fi
            ;;
    esac
    shift
done

if [ -z "$interface" ] || [ -z "$ssid" ]
then
    echo "$USAGE"
    exit 1
fi

echo "Trying to connect to $ssid"

if [ $wpa == true ]
then
    read -s -p 'WPA Password: ' pass
    echo ''
    filename=/tmp/"wpa_passphrase_$ssid"
    wpa_passphrase "$ssid" "$pass" > "$filename"
    wpa_supplicant -B -i "$interface" -c "$filename"
    rm "$filename"
else
    best_bss=''
    best_signal='-10000.00'

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
    done <<< `ip link set "$interface" up && iw dev "$interface" scan | grep "^BSS\|signal\|$ssid"`

    echo "Connecting to AP $best_bss with signal $best_signal mdB"
    iwconfig $interface essid $ssid ap $best_bss
fi

if [ $dhcp == true ]
then
    dhcpcd "$interface"
fi
