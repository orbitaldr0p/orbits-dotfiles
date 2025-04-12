#!/bin/bash

start_waybar_watcher() {
    local configDir="$1"
    local configPath="$HOME/.config/waybar/$configDir"
    local themesPath="$HOME/.config/waybar/themes"
    local config="$configPath/config.jsonc"
    local style="$configPath/style.css"

    trap "killall waybar" EXIT

    while true; do
        waybar -c "$config" -s "$style" &
        inotifywait -e create,modify,delete,move -r "$configPath" "$themesPath"
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
