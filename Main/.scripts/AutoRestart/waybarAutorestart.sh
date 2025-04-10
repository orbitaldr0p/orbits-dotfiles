#!/bin/bash

start_waybar_watcher() {
    local CONFIG_DIR="$1"
    local CONFIG="$HOME/.config/waybar/$CONFIG_DIR/config.jsonc"
    local STYLE="$HOME/.config/waybar/$CONFIG_DIR/style.css"
    
    trap "killall waybar" EXIT
    
    while true; do
        waybar -c "$CONFIG" -s "$STYLE" &
        inotifywait -e create,modify "$CONFIG" "$STYLE"
        sleep 1
        killall waybar
    done
}

case "$1" in
    h)
        start_waybar_watcher "hypr"
    ;;
    n)
        start_waybar_watcher "niri"
    ;;
    *)
        echo "Usage: $0 [h|n]"
        echo "  h - Use Hyprland config"
        echo "  n - Use Niri config"
        exit 1
    ;;
esac
