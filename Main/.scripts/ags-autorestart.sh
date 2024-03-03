#!/bin/bash
# Kill and restart waybar whenever its config files change
CONFIG_FILES="$HOME/.config/ags/"
trap "killall ags" EXIT

while true; do
    ags &
    inotifywait -e create,modify $CONFIG_FILES
    killall ags
done
