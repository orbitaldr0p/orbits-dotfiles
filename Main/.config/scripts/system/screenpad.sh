#!/bin/bash
# Only turn on the screenpad if the laptop is plugged on

startup() {
    state=$(acpi | grep "Battery 0")
    if [[ ! $state =~ "Discharging" ]]; then
        sleep 1
        screenpad 9 
        dunstify "Screenpad On" -t 800 -r 91180
    fi
}

normal(){
    if [ $(cat '/sys/class/leds/asus::screenpad/brightness') != 0 ]; then
        screenpad off
        dunstify "Screenpad off" -t 800 -r 91180
    else
        #echo "$( brightnessctl get )" | tee '/sys/class/leds/asus::screenpad/brightness'
        screenpad 9
        dunstify "Screenpad on" -t 800 -r 91180
    fi
}

invalid_input(){
  echo lmao
}

case "$1" in
  s)
    startup
    ;;
  n)
    normal
    ;;
  *)
    invalid_input
    ;;
esac
