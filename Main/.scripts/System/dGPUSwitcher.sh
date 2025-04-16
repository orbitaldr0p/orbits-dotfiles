#!/bin/bash
icondir="$HOME/.resources/icons/wlogout/"
icon="$icondir/gpu.png"
profile=$(supergfxctl -g)
echo "Current profile is: $profile"

if [ "$profile" == "Integrated" ]; then
    echo "Swapping to Hybrid"
    supergfxctl -m Hybrid
    for ((i=3; i>=1; i--)); do
        notify-send -h string:synchronous:power "Logging out in $i seconds..." -t 2000 -r 91190 -i "$icon"
        sleep 1
    done
    hyprctl dispatch exit
    niri msg action quit -s
    
    elif [ "$profile" == "Hybrid" ]; then
    echo "Swapping to Integrated"
    supergfxctl -m Integrated
    for ((i=3; i>=1; i--)); do
        notify-send -h string:synchronous:power "Logging out in $i seconds..." -t 2000 -r 91190 -i "$icon"
        sleep 1
    done
    hyprctl dispatch exit
    niri msg action quit -s
else
    echo "What the fuck lmao"
fi

