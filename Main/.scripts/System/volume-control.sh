#!/bin/bash
icondir="$HOME/.resources/dunst/volume/"

volume_increased() {
    wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+ -l 1.0
    vol=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep -oE '[0-9]+\.[0-9]+' | awk '{printf "%.0f\n", $1 * 100}')
    icon=$(get_icon "$vol")
    dunstify "Volume: $vol%" -t 800 -r 91190 -i "${icon}"
}

volume_decreased() {
    wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%- -l 1.0
    vol=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep -oE '[0-9]+\.[0-9]+' | awk '{printf "%.0f\n", $1 * 100}')
    icon=$(get_icon "$vol")
    dunstify "Volume: $vol%" -t 800 -r 91190 -i "${icon}"
}

muted() {
    muteState=$(wpctl get-volume @DEFAULT_AUDIO_SINK@)
    if echo "$muteState" | grep -q '\[MUTED\]'; then
        wpctl set-mute @DEFAULT_AUDIO_SINK@ 0
        icon=$(get_icon "$vol")
        dunstify "Unmuted" -t 800 -r 91190 -i "${icon}"
    else
        wpctl set-mute @DEFAULT_AUDIO_SINK@ 1
        icon="${icondir}/vol-muted.svg"
        dunstify "Muted" -t 800 -r 91190 -i "${icon}"
    fi
}

mic_mute() {
    muteState=$(wpctl get-volume @DEFAULT_AUDIO_SOURCE@)
    if echo "$muteState" | grep -q '\[MUTED\]'; then
        wpctl set-mute @DEFAULT_AUDIO_SOURCE@ 0
        icon="${icondir}/mic-unmuted.svg"
        dunstify "Mic Unmuted" -t 800 -r 91190 -i "${icon}"
    else
        wpctl set-mute @DEFAULT_AUDIO_SOURCE@ 1
        icon="${icondir}/mic-muted.svg"
        dunstify "Mic Muted" -t 800 -r 91190 -i "${icon}"
    fi
}

get_icon() {
    if [ "$1" -le 33 ]; then
        echo "${icondir}/vol-0.svg"
        elif [ "$1" -le 66 ]; then
        echo "${icondir}/vol-1.svg"
    else
        echo "${icondir}/vol-2.svg"
    fi
}

invalid_input() {
    echo lmao
}

case "$1" in
    i)
        volume_increased
    ;;
    d)
        volume_decreased
    ;;
    m)
        muted
    ;;
    mm)
        mic_mute
    ;;
    *)
        invalid_input
    ;;
esac
