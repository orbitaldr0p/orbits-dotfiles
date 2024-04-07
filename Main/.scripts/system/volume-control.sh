#!/usr/bin/env sh

volume_increased() {
  wpctl set-volume @DEFAULT_AUDIO_SINK@ 10%+ -l 1.0
  vol=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep -oE '[0-9]+\.[0-9]+' | awk '{printf "%.0f\n", $1 * 100}')
  dunstify "Volume: $vol%" -t 800 -r 91190
}

volume_decreased() {
  wpctl set-volume @DEFAULT_AUDIO_SINK@ 10%- -l 1.0
  vol=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep -oE '[0-9]+\.[0-9]+' | awk '{printf "%.0f\n", $1 * 100}')
  dunstify "Volume: $vol%" -t 800 -r 91190
}

muted() {
  muteState=$(wpctl get-volume @DEFAULT_AUDIO_SINK@)
  if echo "$muteState" | grep -q '\[MUTED\]'; then
    wpctl set-mute @DEFAULT_AUDIO_SINK@ 0
    dunstify "Unmuted" -t 800 -r 91190
  else
    wpctl set-mute @DEFAULT_AUDIO_SINK@ 1
    dunstify "Muted" -t 800 -r 91190
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
