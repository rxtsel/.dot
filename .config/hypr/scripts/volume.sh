#!/usr/bin/env sh

# Script to manage volume and microphone settings
# Usage:
#   ./volume.sh [option] [value]
# Options:
#   --get          : Display current volume level or status (Muted/Unmuted).
#   --inc [value]  : Increase the volume by the specified value. (--inc 0.05 to increase by 5%)
#   --dec [value]  : Decrease the volume by the specified value. (--dec 0.05 to decrease by 5%)
#   --toggle       : Toggle mute for the audio.
#   --mic-inc [value]  : Increase the microphone volume by the specified value. (--mic-inc 0.05 to increase by 5%)
#   --mic-dec [value]  : Decrease the microphone volume by the specified value. (--mic-dec 0.05 to decrease by 5%)
#   --mic-toggle   : Toggle mute for the microphone.

get_volume_num() {
  wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print $2}'
}

is_muted() {
  wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep -q "MUTED"
}

get_volume_label() {
  if is_muted; then
    printf "MUTED"
  else
    printf "%s%%" "$(awk "BEGIN { print int($(get_volume_num) * 100) }")"
  fi
}

notify_user() {
  local val get_volume_label
  if is_muted; then
    val=0
  else
    val=$(get_volume_label)
  fi
  label=$(get_volume_label)
  notify-send -e \
    -h int:value:"$val" \
    -h string:x-canonical-private-synchronous:osd \
    -u low \
    -t 1000 \
    "Volume" "${label}"
}

# Volume controls
in_volume() {
  if is_muted; then
    toggle_muted
  else
    wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ "${1}+"
    notify_user
  fi
}

dec_volume() {
  if is_muted; then
    toggle_muted
  else
    wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ "${1}-"
    notify_user
  fi
}

toggle_muted() {
  pactl set-sink-mute @DEFAULT_SINK@ toggle
  notify_user
}

# Michophone helpers
is_mic_muted() {
  wpctl get-volume @DEFAULT_AUDIO_SOURCE@ | grep -q "MUTED"
}

get_mic_num() {
  wpctl get-volume @DEFAULT_AUDIO_SOURCE@ | awk '{print $2}'
}

get_mic_label() {
  if is_mic_muted; then
    printf "MUTED"
  else
    printf "%s%%" "$(awk "BEGIN { print int($(get_mic_num) * 100) }")"
  fi
}

notify_mic() {
  local val get_mic_label
  if is_mic_muted; then
    val=0
  else
    val=$(get_mic_label)
  fi
  label=$(get_mic_label)
  notify-send -e \
    -h int:value:"$val" \
    -h string:x-canonical-private-synchronous:osd \
    -u low \
    --expire-time=1000 \
    "Microphone" "${label}"
}

toggle_mic() {
  pactl set-source-mute @DEFAULT_SOURCE@ toggle
  notify_mic
}

# Mic controls
inc_mic() {
  if is_mic_muted; then
    toggle_mic
  else
    wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SOURCE@ "${1}+"
    notify_mic
  fi
}

dec_mic() {
  if is_mic_muted; then
    toggle_mic
  else
    wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SOURCE@ "${1}-"
    notify_mic
  fi
}

case $1 in
--get) get_volume_label ;;
--inc) in_volume "$2" ;;
--dec) dec_volume "$2" ;;
--toggle) toggle_muted ;;
# Mic
--mic-inc) inc_mic "$2" ;;
--mic-dec) dec_mic "$2" ;;
--mic-toggle) toggle_mic ;;
*) get_volume_label ;;
esac
