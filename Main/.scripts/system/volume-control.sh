#!/usr/bin/env sh

volume_increased() {
  pamixer -i 10
  vol=$(pamixer --get-volume-human | cat)
  dunstify "Volume: $vol" -t 800 -r 91190
}

volume_decreased() {
  pamixer -d 10
  vol=$(pamixer --get-volume-human | cat)
  dunstify "Volume: $vol" -t 800 -r 91190
}

muted() {
  pamixer -t
  muteState=$(pamixer --get-mute | cat)
  if [ "$muteState" == "true" ] ; then
    dunstify "Muted" -t 800 -r 91190
  else
    dunstify "Unmuted" -t 800 -r 91190
  fi
}

mic_mute() {
  dunstify "Currently doesn't work lol." -t 800 -r 91190
}

invalid_input(){
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
