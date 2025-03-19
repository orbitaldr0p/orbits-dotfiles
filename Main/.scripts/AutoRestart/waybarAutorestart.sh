#!/bin/bash
hypr() {
    # Kill and restart waybar whenever its config files change
    CONFIG_FILES="$HOME/.config/waybar/hypr/config.jsonc $HOME/.config/waybar/hypr/style.css"
    trap "killall waybar" EXIT
    while true; do
        waybar -c $HOME/.config/waybar/hypr/config.jsonc &
        inotifywait -e create,modify $CONFIG_FILES
        sleep 1
        killall waybar
    done
}


niri () {
    # Kill and restart waybar whenever its config files change
    CONFIG_FILES="$HOME/.config/waybar/niri/config.jsonc $HOME/.config/waybar/niri/style.css"
    trap "killall waybar" EXIT
    while true; do
        waybar -c $HOME/.config/waybar/niri/config.jsonc &
        inotifywait -e create,modify $CONFIG_FILES
        sleep 1
        killall waybar
    done
}

case "$1" in
    h)
        hypr
    ;;
    n)
        niri
    ;;
    *)
        invalid_input
    ;;
esac