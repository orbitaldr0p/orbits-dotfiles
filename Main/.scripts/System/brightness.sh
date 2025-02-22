#!/bin/bash

increase() {
    brightnessctl s +10%
    brightness=$(brightnessctl get)
    notify-send "Brightness: $(( $brightness * 100 / 2047 ))" -t 800 -r 91170
}

decrease() {
    brightnessctl s 10%-
    brightness=$(brightnessctl get)
    notify-send "Brightness: $(( $brightness * 100 / 2047 ))" -t 800 -r 91170
}

invalid_input(){
    echo lmao
}

case "$1" in
    i)
        increase
    ;;
    d)
        decrease
    ;;
    *)
        invalid_input
    ;;
esac
