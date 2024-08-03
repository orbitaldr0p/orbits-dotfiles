#!/bin/bash
icondir="$HOME/.resources/dunst/power/"
currentProfile=$(powerprofilesctl get)
case $currentProfile in
    power-saver)
        powerprofilesctl set balanced
        icon="${icondir}/balanced.svg"
        dunstify "Profile: Balanced" -t 800 -r 91160 -i "${icon}"
    ;;
    
    balanced)
        powerprofilesctl set performance
        icon="${icondir}/performance.svg"
        dunstify "Profile: Performance" -t 800 -r 91160 -i "${icon}"
    ;;
    
    performance)
        powerprofilesctl set power-saver
        icon="${icondir}/silent.svg"
        dunstify "Profile: Silent" -t 800 -r 91160 -i "${icon}"
    ;;
esac
