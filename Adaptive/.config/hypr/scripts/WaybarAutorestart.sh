#!/bin/bash
# Kill and restart waybar whenever its config files change
CONFIG_FILES="$HOME/.dotfiles/Nord/.config/waybar/config.jsonc $HOME/.dotfiles/Nord/.config/waybar/style.css"
trap "killall waybar" EXIT

while true; do
    waybar &
    inotifywait -e create,modify $CONFIG_FILES
    killall waybar
done

