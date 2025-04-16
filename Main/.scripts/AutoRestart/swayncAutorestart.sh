#!/bin/bash
# Watch swaync config directory and restart swaync when changes are detected

configDir="$HOME/.config/swaync/"

# Function to clean up on exit
cleanup() {
    pkill -x "swaync"
    exit 0
}

trap cleanup EXIT INT TERM

firstRun=true

while true; do
    "swaync" &
    if [ "$firstRun" = true ]; then
        notify-send "Welcome, Olivia."
        firstRun=false
    else
        notify-send -h string:synchronous:reload "Swaync Reloaded"
    fi
    inotifywait -e create,modify,delete,move -r "$configDir" >/dev/null 2>&1
    pkill -x "swaync"
done
