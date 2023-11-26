#!/bin/bash
# Kill and restart waybar whenever its config files change
CONFIG_FILES="$HOME/.config/dunst/dunstrc"
trap "killall dunst" EXIT

while true; do
    dunst &
    dunstify "Dunst Started"
    inotifywait -e create,modify $CONFIG_FILES
    killall dunst
done
