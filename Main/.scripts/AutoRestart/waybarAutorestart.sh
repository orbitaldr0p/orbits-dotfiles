#!/bin/bash

start_waybar_watcher() {
    local configDir="$1"
    local configPath="$HOME/.config/waybar/$configDir"
    local themesPath="$HOME/.config/waybar/themes"
    local config="$configPath/config.jsonc"
    local style="$configPath/style.css"
    local firstRun=true
    local WAYBAR_PID

    trap '[[ -n "$WAYBAR_PID" ]] && kill "$WAYBAR_PID"' EXIT

    while true; do
        if [ "$firstRun" = true ]; then
            firstRun=false
        else
            kill "$WAYBAR_PID"
            wait "$WAYBAR_PID" 2>/dev/null
        fi

        waybar -c "$config" -s "$style" &
        WAYBAR_PID=$!

        inotifywait -e create,modify,delete,move -r "$configPath" "$themesPath"
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
