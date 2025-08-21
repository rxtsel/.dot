# External Monitor Brightness Control with ddcutil + Hyprland

This guide explains how to control monitor brightness via **DDC/CI** on Arch Linux, using `ddcutil` and keybindings in **Hyprland**.  
It is designed for setups with multiple monitors (example: dual LG UltraGear on I²C buses 6 and 7).

---

## 1. Install required packages

```bash
sudo pacman -S ddcutil libnotify
````

* `ddcutil` → communicates with monitors via DDC/CI
* `libnotify` → allows `notify-send` for desktop notifications

---

## 2. Enable I²C support

Load the kernel module:

```bash
sudo modprobe i2c-dev
```

Make it persistent:

```bash
echo i2c-dev | sudo tee /etc/modules-load.d/i2c_dev.conf
```

---

## 3. Permissions

Add your user to the required groups:

```bash
sudo usermod -aG i2c,video $USER
```

Log out and log back in (or reboot) so group membership applies.

---

## 4. Detect your monitors

Run:

```bash
ddcutil detect
```

You should see each display listed with its I²C bus, for example:

```
Display 1
   I2C bus:  /dev/i2c-6
   Model:    LG ULTRAGEAR
Display 2
   I2C bus:  /dev/i2c-7
   Model:    LG ULTRAGEAR
```

Write down the bus numbers (`6` and `7` in this example).

---

## 5. Install the script

Create the script file:

```bash
mkdir -p ~/.dot/.config/hypr/scripts
nvim ~/.dot/.config/hypr/scripts/brightness.sh
```

Paste the following:

```sh
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

notify_limit() {
  val=$1
  if [ "$val" -le 0 ]; then
    notify-send "Brightness" "Already at minimum (0%)"
  elif [ "$val" -ge 100 ]; then
    notify-send "Brightness" "Already at maximum (100%)"
  fi
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
    echo "BUS $BUS → brightness ${new}%"
    notify_limit "$new"
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
    echo "BUS $BUS → $cur% → $new% (Δ $DELTA)"
    notify_limit "$new"
  fi
  sleep 0.05
done
```

Make it executable:

```bash
chmod +x ~/.dot/.config/hypr/scripts/brightness.sh
```

---

## 6. Add Hyprland keybindings

Edit your `~/.dot/.config/hypr/hyprland.conf` and add:

```ini
# Brightness control
bind = $mod, XF86AudioRaiseVolume, exec, ~/.dot/.config/hypr/scripts/brightness.sh 10+
bind = $mod, XF86AudioLowerVolume, exec, ~/.dot/.config/hypr/scripts/brightness.sh 10-

# You can use any keys you prefer
```

Reload Hyprland (`hyprctl reload`) or restart it.

---

## 7. Test

```bash
~/.dot/.config/hypr/scripts/brightness.sh 0     # set to 0%
~/.dot/.config/hypr/scripts/brightness.sh 50    # set to 50%
~/.dot/.config/hypr/scripts/brightness.sh 10+   # increase by 10
~/.dot/.config/hypr/scripts/brightness.sh 10-   # decrease by 10
```

When trying to go below 0% or above 100%, a **desktop notification** will appear.

---

## Notes

* If your monitor buses change (e.g. reconnecting cables), update the `BUSES` variable in the script.
* You can override buses at runtime:

  ```bash
  BRIGHTNESS_BUSES="7 6" ~/.dot/.config/hypr/scripts/brightness.sh 30
  ```

* Works independently of X11/Wayland (since DDC/CI is hardware-based).
* Requires monitors with **DDC/CI support** (most modern displays have it, but some hubs/KVM switches block it).
