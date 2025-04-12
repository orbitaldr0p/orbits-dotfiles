#!/bin/bash
iconDir="$HOME/.resources/notifications/power/"
currentProfile=$(powerprofilesctl get)
case $currentProfile in
    power-saver)
        powerprofilesctl set balanced
        icon="$iconDir/power-1.png"
        notify-send "Profile: Balanced" -t 800 -r 91160 -i "$icon"
    ;;
    
    balanced)
        powerprofilesctl set performance
        icon="$iconDir/power-2.png"
        notify-send "Profile: Performance" -t 800 -r 91160 -i "$icon"
    ;;
    
    performance)
        powerprofilesctl set power-saver
        icon="$iconDir/power-0.png"
        notify-send "Profile: Silent" -t 800 -r 91160 -i "$icon"
    ;;
esac
