#!/bin/bash

profile=$(supergfxctl -g)
echo "Current profile is: $profile"

if [ "$profile" == "Integrated" ]; then
    echo "Swapping to Hybrid"
    supergfxctl -m Hybrid
    for ((i=3; i>=1; i--)); do
            dunstify "Logging out in $i seconds..." -t 2000 -r 91190
            sleep 1
        done
    hyprctl dispatch exit

elif [ "$profile" == "Hybrid" ]; then
    echo "Swapping to Integrated"
    supergfxctl -m Integrated
    for ((i=3; i>=1; i--)); do
            dunstify "Logging out in $i seconds..." -t 2000 -r 91190
            sleep 1
        done
    hyprctl dispatch exit
else
    echo "What the fuck lmao"
fi

