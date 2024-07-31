#!/bin/bash
# Kill and restart dunst whenever its config files change
CONFIG_FILES="$HOME/.config/dunst/dunstrc"
trap "killall dunst" EXIT

first_run=true

while true; do
    dunst &
    if [ "$first_run" = true ]; then
        dunstify "Dunst Started"
        first_run=false
    else
        dunstify "Dunst Reloaded"
    fi
    inotifywait -e create,modify $CONFIG_FILES
    killall dunst
done
