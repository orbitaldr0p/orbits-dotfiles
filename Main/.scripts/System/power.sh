#!/bin/bash

# Check if no argument is provided
if [ $# -eq 0 ]; then
    echo "Usage: $0 [e|s|r]"
    exit 1
fi

# Check the provided argument
case "$1" in
    e)
        for ((i=3; i>=1; i--)); do
            notify-send "Logging out in $i seconds..." -t 2000 -r 91190
            sleep 1
        done
        hyprctl dispatch exit
        niri msg action quit -s
    ;;
    s)
        for ((i=3; i>=1; i--)); do
            notify-send "Shutting Down in $i seconds..." -t 2000 -r 91190
            sleep 1
        done
        shutdown now
    ;;
    r)
        for ((i=3; i>=1; i--)); do
            notify-send "Restarting in $i seconds..." -t 2000 -r 91190
            sleep 1
        done
        systemctl reboot
    ;;
    *)
        echo "Invalid option: $1. Please provide e (logout), s (shutdown), or r (restart)."
        exit 1
    ;;
esac

exit 0
