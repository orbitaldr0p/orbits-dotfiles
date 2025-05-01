#!/bin/bash
dunst &

configDir="$HOME/.config/dunst/"
firstRun=true

while true; do
    if [ "$firstRun" = true ]; then
        notify-send "Welcome, Olivia."
        # echo "welcome message sent"
        firstRun=false
    else
        # echo "reloading dunst..."
        dunstctl reload
        notify-send "Dunst Reloaded"
    fi

    inotifywait -e create,modify,delete,move -r "$configDir"
done
