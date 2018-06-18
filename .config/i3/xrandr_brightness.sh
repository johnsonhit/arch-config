#!/bin/bash

if [ -f ~/.xrandr_brightness ]
then
    b=`cat ~/.xrandr_brightness`
else
    echo 100 > ~/.xrandr_brightness
    b=100
fi
b=$((b+$1))

if [ $b -ge 100 ]
then
    xrandr --output eDP-1 --brightness 1
    echo 100 > ~/.xrandr_brightness
elif [ $b -le 30 ]
then
    xrandr --output eDP-1 --brightness 0.3
    echo 30 > ~/.xrandr_brightness
else
    xrandr --output eDP-1 --brightness 0.$b
    echo $b > ~/.xrandr_brightness
fi
