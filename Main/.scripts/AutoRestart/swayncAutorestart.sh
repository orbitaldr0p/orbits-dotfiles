#!/bin/bash
swaync &

configDir="$HOME/.config/swaync/"
firstRun=true

while true; do
    if [ "$firstRun" = true ]; then
        notify-send "Welcome, Olivia."
        # echo "welcome message sent"
        firstRun=false
    else
        # echo "reloading swaync..."
        swaync-client -R
        swaync-client -rs
        notify-send "SwayNC Reloaded"
    fi
    
    inotifywait -e create,modify,delete,move -r "$configDir"
done
