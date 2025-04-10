#!/bin/bash

start_waybar_watcher() {
    local CONFIG_DIR="$1"
    local CONFIG_PATH="$HOME/.config/waybar/$CONFIG_DIR"
    local THEMES_PATH="$HOME/.config/waybar/themes"
    local CONFIG="$CONFIG_PATH/config.jsonc"
    local STYLE="$CONFIG_PATH/style.css"

    trap "killall waybar" EXIT

    while true; do
        waybar -c "$CONFIG" -s "$STYLE" &
        inotifywait -e create,modify,delete,move -r "$CONFIG_PATH" "$THEMES_PATH"
        # sleep 1
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
