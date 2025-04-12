#!/bin/bash
iconDir="$HOME/.resources/notifications/brightness/"
displayDevice="intel_backlight"

increase() {
    brightnessctl -d $displayDevice s +10%
    brightness=$(brightnessctl -d $displayDevice -m | cut -d, -f4)
    icon=$(getIcon "$(echo "$brightness" | sed 's/%//')")
    notify-send "Brightness: $brightness" -t 800 -r 91170 -i "$icon"
}

decrease() {
    brightnessctl -d $displayDevice s 10%-
    brightness=$(brightnessctl -d $displayDevice -m | cut -d, -f4)
    icon=$(getIcon "$(echo "$brightness" | sed 's/%//')")
    notify-send "Brightness: $brightness" -t 800 -r 91170 -i "$icon"
}

getIcon() {
    if [ "$1" -le 20 ]; then
        echo "$iconDir/brightness-0.png"
    elif [ "$1" -le 40 ]; then
        echo "$iconDir/brightness-1.png"
    elif [ "$1" -le 60 ]; then
        echo "$iconDir/brightness-2.png"
    elif [ "$1" -le 80 ]; then
        echo "$iconDir/brightness-3.png"
    else
        echo "$iconDir/brightness-4.png"
    fi
}

invalidInput(){
    echo lmao
}

case "$1" in
    i)
        increase
    ;;
    d)
        decrease
    ;;
    *)
        invalidInput
    ;;
esac
