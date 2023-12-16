#!/bin/bash

increase() {
  brightnessctl s +10%
  brightness=$(brightnessctl get)
  #screenpad
  dunstify "Brightness: $(( $brightness * 100 / 255 ))" -t 800 -r 91170
}

decrease() {
  brightnessctl s 10%-
  brightness=$(brightnessctl get)
  #screenpad
  dunstify "Brightness: $(( $brightness * 100 / 255 ))" -t 800 -r 91170
}

#Too Inefficent
#screenpad() {
#  if [ "$brightness" > 0 ] ; then
#    echo "$brightness" | tee '/sys/class/leds/asus::screenpad/brightness'
#  fi
#}

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
