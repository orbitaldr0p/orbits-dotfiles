#!/bin/bash
icondir="$HOME/.resources/icons/volume/"

volIncrease() {
    wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+ -l 1.0
    vol=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep -oE '[0-9]+\.[0-9]+' | awk '{printf "%.0f\n", $1 * 100}')
    icon=$(getIcon $vol)
    notify-send "Volume: $vol%" -t 800 -r 91190 -i "$icon"
}

volDecrease() {
    wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%- -l 1.0
    vol=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep -oE '[0-9]+\.[0-9]+' | awk '{printf "%.0f\n", $1 * 100}')
    icon=$(getIcon $vol)
    notify-send "Volume: $vol%" -t 800 -r 91190 -i "$icon"
}

volMute() {
    muteState=$(wpctl get-volume @DEFAULT_AUDIO_SINK@)
    if echo "$muteState" | grep -q '\[MUTED\]'; then
        wpctl set-mute @DEFAULT_AUDIO_SINK@ 0
        icon=$(getIcon "$vol")
        notify-send "Unmuted" -t 800 -r 91190 -i "$icon"
    else
        wpctl set-mute @DEFAULT_AUDIO_SINK@ 1
        icon="$icondir/vol-0c.png"
        notify-send "Muted" -t 800 -r 91190 -i "$icon"
    fi
}

micMute() {
    muteState=$(wpctl get-volume @DEFAULT_AUDIO_SOURCE@)
    if echo "$muteState" | grep -q '\[MUTED\]'; then
        wpctl set-mute @DEFAULT_AUDIO_SOURCE@ 0
        icon="$icondir/mic-1.png"
        notify-send "Mic Unmuted" -t 800 -r 91190 -i "${icon}"
    else
        wpctl set-mute @DEFAULT_AUDIO_SOURCE@ 1
        icon="$icondir/mic-0c.png"
        notify-send "Mic Muted" -t 800 -r 91190 -i "${icon}"
    fi
}

getIcon() {
    if [ "$1" -eq 0 ]; then
        echo "$icondir/vol-1.png"
    elif [ "$1" -le 34 ]; then
        echo "$icondir/vol-2.png"
    elif [ "$1" -le 66 ]; then
        echo "$icondir/vol-3.png"
    else
        echo "$icondir/vol-4.png"
    fi
}

invalidInput() {
    echo lmao
}

case "$1" in
    i)
        volIncrease
    ;;
    d)
        volDecrease
    ;;
    m)
        volMute
    ;;
    mm)
        micMute
    ;;
    *)
        invalidInput
    ;;
esac
