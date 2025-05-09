#!/bin/bash
ignis init &

configDir="$HOME/.config/ignis/"
firstRun=true

while true; do
    if [ "$firstRun" = true ]; then
        firstRun=false
    else
        ignis reload
        notify-send "Ignis Reloaded"
        sleep 1
    fi

    inotifywait -e create,modify,delete,move -r "$configDir"
done
