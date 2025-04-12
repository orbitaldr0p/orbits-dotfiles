#!/bin/bash
# Kill and restart dunst whenever its config files change
configDir="$HOME/.config/dunst/"
trap "killall dunst" EXIT

firstRun=true

while true; do
    dunst &
    if [ "$firstRun" = true ]; then
        notify-send "Welcome, Olivia."
        firstRun=false
    else
        notify-send "Dunst Reloaded"
    fi
    inotifywait -e create,modify,delete,move -r $configDir
    killall dunst
done
