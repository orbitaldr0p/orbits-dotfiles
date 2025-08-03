#!/bin/bash
iconDir="$HOME/.resources/icons/brightness/"
displayDevice="intel_backlight"

increase() {
    brightness=$(brightnessctl -d "$displayDevice" -m | cut -d, -f4 | sed 's/%//')
    if [ "$brightness" -ge 100 ]; then
        return
    fi
    brightnessctl -d "$displayDevice" s +10%
    hyprctl dispatch "global quickshell:getBrightnessActivator"
    brightness=$(brightnessctl -d "$displayDevice" -m | cut -d, -f4 | sed 's/%//')
    icon=$(getIcon "$brightness")
    notify-send -h int:value:"$brightness" -h string:synchronous:brightness "Brightness: ${brightness}%" -t 2000 -r 91170 -i "$icon"
}

decrease() {
    brightness=$(brightnessctl -d "$displayDevice" -m | cut -d, -f4 | sed 's/%//')
    if [ "$brightness" -le 0 ]; then
        return
    fi
    brightnessctl -d "$displayDevice" s 10%-
    hyprctl dispatch "global quickshell:getBrightnessActivator"
    brightness=$(brightnessctl -d "$displayDevice" -m | cut -d, -f4 | sed 's/%//')
    icon=$(getIcon "$brightness")
    notify-send -h int:value:"$brightness" -h string:synchronous:brightness "Brightness: ${brightness}%" -t 2000 -r 91170 -i "$icon"
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

invalidInput() {
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
