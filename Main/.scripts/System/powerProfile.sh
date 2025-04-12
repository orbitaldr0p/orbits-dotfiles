#!/bin/bash
icondir="$HOME/.resources/notifications/power/"
currentProfile=$(powerprofilesctl get)
case $currentProfile in
    power-saver)
        powerprofilesctl set balanced
        icon="${icondir}/power-1.png"
        notify-send "Profile: Balanced" -t 800 -r 91160 -i "${icon}"
    ;;
    
    balanced)
        powerprofilesctl set performance
        icon="${icondir}/power-2.png"
        notify-send "Profile: Performance" -t 800 -r 91160 -i "${icon}"
    ;;
    
    performance)
        powerprofilesctl set power-saver
        icon="${icondir}/power-0.png"
        notify-send "Profile: Silent" -t 800 -r 91160 -i "${icon}"
    ;;
esac
