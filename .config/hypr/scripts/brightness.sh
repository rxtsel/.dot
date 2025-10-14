#!/usr/bin/env sh
# Brightness control for multiple monitors using ddcutil
#
# Usage:
#   brightness.sh 40     -> set brightness to 40%
#   brightness.sh +10    -> increase by 10
#   brightness.sh -10    -> decrease by 10
#   brightness.sh 10+    -> increase by 10 (Hyprland-friendly)
#   brightness.sh 10-    -> decrease by 10 (Hyprland-friendly)

set -eu

# I2C buses (override with env var BRIGHTNESS_BUSES="6 7")
BUSES="${BRIGHTNESS_BUSES:-6 7}"
VCP=0x10 # brightness code

usage() {
  echo "Usage: $0 <0-100|+N|-N|N+|N->" >&2
  exit 1
}

is_uint() {
  case "${1:-}" in '' | *[!0-9]*) return 1 ;; *) return 0 ;; esac
}

clamp_0_100() {
  n=$1
  [ "$n" -lt 0 ] && n=0
  [ "$n" -gt 100 ] && n=100
  echo "$n"
}

# Read current brightness (field 4 of terse output)
get_cur() {
  bus="$1"
  out="$(ddcutil --bus="$bus" getvcp $VCP --terse 2>/dev/null || true)"
  cur="$(printf '%s\n' "$out" | awk '{print $4}')"
  [ -n "$cur" ] && echo "$cur" || echo "0"
}

notify_osd() {
  val=$1
  notify-send -e -h string:x-canonical-private-synchronous:osd -t 1000 "Brightness" "Brightness: ${val}%"
}

# --- Argument parsing ---
[ $# -eq 1 ] || usage
RAW="$1"

case "$RAW" in
+[0-9]* | -*[0-9]*)
  MODE=REL
  DELTA="$RAW"
  ;;
*+)
  n="${RAW%+}"
  is_uint "$n" || usage
  MODE=REL
  DELTA="+$n"
  ;;
*-)
  n="${RAW%-}"
  is_uint "$n" || usage
  MODE=REL
  DELTA="-$n"
  ;;
*)
  is_uint "$RAW" || usage
  MODE=ABS
  ABS="$(clamp_0_100 "$RAW")"
  ;;
esac

# --- Apply ---
for BUS in $BUSES; do
  if [ "$MODE" = "ABS" ]; then
    new="$ABS"
    ddcutil --bus="$BUS" setvcp "$VCP" -- "$new" >/dev/null
    echo "BUS $BUS → brightness ${new}"
    notify_osd "$new"
  else
    cur="$(get_cur "$BUS")"
    sign="$(printf '%s' "$DELTA" | cut -c1)"
    mag="$(printf '%s' "$DELTA" | cut -c2-)"
    if [ "$sign" = "+" ]; then
      new=$((cur + mag))
    else
      new=$((cur - mag))
    fi
    new="$(clamp_0_100 "$new")"
    ddcutil --bus="$BUS" setvcp "$VCP" -- "$new" >/dev/null
    echo "BUS $BUS → $cur → $new (Δ $DELTA)"
    notify_osd "$new"
  fi
  sleep 0.05
done
