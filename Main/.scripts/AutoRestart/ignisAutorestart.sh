#!/bin/bash

configDir="$HOME/.config/ignis/"
firstRun=true

startIgnis() {
    ignis init &
    ignisPid=$!
    echo "Ignis started with PID $ignisPid"
}

startIgnis

while true; do
    if [ "$firstRun" = true ]; then
        firstRun=false
    else
        # Wait for file change or ignis crash, whichever comes first
        inotifywait -e create,modify,delete,move -r "$configDir" &
        watcherPid=$!

        # Wait for either ignis or inotifywait to finish
        wait -n $ignisPid $watcherPid

        if ! kill -0 "$ignisPid" 2>/dev/null; then
            echo "Ignis crashed or exited."
        else
            echo "Configuration change detected."
            kill "$ignisPid"
            wait "$ignisPid" 2>/dev/null
            kill "$watcherPid" 2>/dev/null
        fi

        notify-send "Ignis Restarted"
        sleep 1
        startIgnis
    fi
done
