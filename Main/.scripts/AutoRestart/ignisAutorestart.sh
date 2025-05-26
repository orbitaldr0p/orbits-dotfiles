#!/bin/bash

ignis init &
IGNIS_PID=$!

configDir="$HOME/.config/ignis/"
firstRun=true

while true; do
    if [ "$firstRun" = true ]; then
        firstRun=false
    else
        kill "$IGNIS_PID"
        wait "$IGNIS_PID" 2>/dev/null

        ignis init &
        IGNIS_PID=$!

        notify-send "Ignis Restarted"
        sleep 1
    fi

    inotifywait -e create,modify,delete,move -r "$configDir"
done
