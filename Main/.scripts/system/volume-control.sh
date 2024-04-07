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
  muteState=$(wpctl get-volume @DEFAULT_AUDIO_SOURCE@)
  if echo "$muteState" | grep -q '\[MUTED\]'; then
    wpctl set-mute @DEFAULT_AUDIO_SOURCE@ 0
    dunstify "Unmuting Mic" -t 800 -r 91190
  else
    wpctl set-mute @DEFAULT_AUDIO_SOURCE@ 1
    dunstify "Muting Mic" -t 800 -r 91190
  fi
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
