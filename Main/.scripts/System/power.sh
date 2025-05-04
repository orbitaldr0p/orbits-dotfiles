#!/bin/bash
icondir="$HOME/.resources/icons/wlogout/"

case "$1" in
e)
    icon="$icondir/logout.png"
    for ((i = 3; i >= 1; i--)); do
        notify-send -h string:synchronous:power "Logging out in $i seconds..." -t 1100 -r 91190 -i "$icon"
        sleep 1
    done
    hyprctl dispatch exit
    niri msg action quit -s
    ;;
s)
    icon="$icondir/shutdown.png"
    for ((i = 3; i >= 1; i--)); do
        notify-send -h string:synchronous:power "Shutting Down in $i seconds..." -t 1100 -r 91190 -i "$icon"
        sleep 1
    done
    shutdown now
    ;;
r)
    icon="$icondir/reboot.png"
    for ((i = 3; i >= 1; i--)); do
        notify-send -h string:synchronous:power "Restarting in $i seconds..." -t 1100 -r 91190 -i "$icon"
        sleep 1
    done
    systemctl reboot
    ;;
*)
    echo "lmao"
    exit 1
    ;;
esac

exit 0
