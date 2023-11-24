#!/bin/bash
# Kill and restart waybar whenever its config files change
CONFIG_FILES="$HOME/.config/waybar/config.jsonc $HOME/.config/waybar/style.css"
trap "killall waybar" EXIT

while true; do
    waybar &
    inotifywait -e create,modify $CONFIG_FILES
    killall waybar
done
