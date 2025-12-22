{ pkgs, ... }:

{
  home.packages = with pkgs; [
    ddcutil

    (pkgs.writeShellScriptBin "brightness" ''
      #!/usr/bin/env sh
      # brightness - Multi-monitor brightness via DDC/CI (ddcutil)

      set -eu

      VCP="0x10"
      CACHE_TTL="5"
      STEP_DELAY="0.03"
      NOTIFY="1"

      # Set your display connectors `ddcutil detect' and add DRM_connector names here
      CONNECTORS_DEFAULT="card1-DP-1 card1-DP-2"
      CONNECTORS="''${BRIGHTNESS_CONNECTORS:-''$CONNECTORS_DEFAULT}"

      usage() {
        echo "Usage: brightness <0-100|+N|-N|N+|N->" >&2
        exit 2
      }

      is_uint() {
        case "''${1:-}" in
          ""|*[!0-9]*) return 1 ;;
          *) return 0 ;;
        esac
      }

      clamp_0_100() {
        n="''$1"
        [ "''$n" -lt 0 ] && n=0
        [ "''$n" -gt 100 ] && n=100
        printf '%s\n' "''$n"
      }

      has_cmd() {
        command -v "''$1" >/dev/null 2>&1
      }

      notify_limit() {
        [ "''$NOTIFY" = "1" ] || return 0
        has_cmd notify-send || return 0
        val="''$1"
        if [ "''$val" -le 0 ]; then
          notify-send "Brightness" "Already at minimum (0%)"
        elif [ "''$val" -ge 100 ]; then
          notify-send "Brightness" "Already at maximum (100%)"
        fi
      }

      lockdir="''${XDG_RUNTIME_DIR:-/tmp}/brightness-ddcutil.lock"
      if mkdir "''$lockdir" 2>/dev/null; then
        trap 'rmdir "''$lockdir" 2>/dev/null || true' EXIT INT TERM
      else
        exit 0
      fi

      cache_dir="''${XDG_CACHE_HOME:-''$HOME/.cache}/brightness-ddcutil"
      cache_file="''$cache_dir/detect.txt"
      cache_ts="''$cache_dir/detect.ts"

      mkdir -p "''$cache_dir"

      now_epoch() { date +%s; }

      is_cache_fresh() {
        [ -f "''$cache_file" ] || return 1
        [ -f "''$cache_ts" ] || return 1
        ts="$(cat "''$cache_ts" 2>/dev/null || echo 0)"
        age=$(( $(now_epoch) - ts ))
        [ "''$age" -lt "''$CACHE_TTL" ]
      }

      get_detect() {
        if is_cache_fresh; then
          cat "''$cache_file"
          return
        fi

        out="$(ddcutil detect 2>/dev/null || true)"
        [ -n "''$out" ] || {
          echo "Error: ddcutil detect returned no output. Check DDC/CI and permissions." >&2
          exit 1
        }

        printf '%s\n' "''$out" > "''$cache_file"
        now_epoch > "''$cache_ts"
        printf '%s\n' "''$out"
      }

      bus_for_connector() {
        conn="''$1"
        get_detect | awk -v c="''$conn" '
          /^Display/ { inblock=1; bus="" }
          inblock && $1=="I2C" && $2=="bus:" {
            bus=$3; sub("^/dev/i2c-","",bus)
          }
          inblock && $1=="DRM_connector:" && $2==c {
            print bus; exit
          }
        '
      }

      get_buses() {
        # Allow override by buses (space-separated)
        if [ -n "''${BRIGHTNESS_BUSES:-}" ]; then
          printf '%s\n' "''$BRIGHTNESS_BUSES" | tr ' ' '\n' | sed '/^''$/d'
          return
        fi

        for c in ''$CONNECTORS; do
          bus_for_connector "''$c"
        done
      }

      get_cur() {
        bus="''$1"
        ddcutil --bus="''$bus" getvcp "''$VCP" --terse 2>/dev/null \
          | awk '{for(i=1;i<=NF;i++) if($i=="C") {print $(i+1); exit}}'
      }

      [ "''$#" -eq 1 ] || usage
      RAW="''$1"

      case "''$RAW" in
        +[0-9]*|-[0-9]*)
          MODE=REL
          DELTA="''$RAW"
          ;;
        *+)
          n="''${RAW%+}"
          is_uint "''$n" || usage
          MODE=REL
          DELTA="+''$n"
          ;;
        *-)
          n="''${RAW%-}"
          is_uint "''$n" || usage
          MODE=REL
          DELTA="-''$n"
          ;;
        *)
          is_uint "''$RAW" || usage
          MODE=ABS
          ABS="$(clamp_0_100 "''$RAW")"
          ;;
      esac

      for BUS in $(get_buses); do
        if [ "''$MODE" = "ABS" ]; then
          ddcutil --bus="''$BUS" setvcp "''$VCP" "''$ABS" >/dev/null
          notify_limit "''$ABS"
        else
          cur="$(get_cur "''$BUS")"
          [ -n "''$cur" ] || cur=0

          sign="$(printf '%s' "''$DELTA" | cut -c1)"
          mag="$(printf '%s' "''$DELTA" | cut -c2-)"

          if [ "''$sign" = "+" ]; then
            new=$(( cur + mag ))
          else
            new=$(( cur - mag ))
          fi

          new="$(clamp_0_100 "''$new")"
          ddcutil --bus="''$BUS" setvcp "''$VCP" "''$new" >/dev/null
          notify_limit "''$new"
        fi

        sleep "''$STEP_DELAY"
      done
    '')
  ];
}
