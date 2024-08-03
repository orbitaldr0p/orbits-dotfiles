#!/bin/bash
currentProfile=$(powerprofilesctl get)
case $currentProfile in
    power-saver)
        dunstify "Profile: Balanced" -t 800 -r 91160
        powerprofilesctl set balanced
    ;;
    
    balanced)
        dunstify "Profile: Performance" -t 800 -r 91160
        powerprofilesctl set performance
    ;;
    
    performance)
        dunstify "Profile: Silent" -t 800 -r 91160
        powerprofilesctl set power-saver
        
    ;;
esac
