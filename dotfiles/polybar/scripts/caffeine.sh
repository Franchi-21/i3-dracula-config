#!/usr/bin/env bash

ICON_ON="%{T0}󰅶%{T-}"
ICON_OFF="%{T0}󰒲%{T-}"

is_on() {
  local dpms_state ss_timeout
  dpms_state="$(xset q | awk '/DPMS is/ {print $3}')"    # Enabled/Disabled
  ss_timeout="$(xset q | awk '/timeout:/ {print $2}')"   # In secs (0 = off)
  [[ "$dpms_state" == "Disabled" && "$ss_timeout" == "0" ]]
}

print_icon() {
  if is_on; then
    echo "$ICON_ON"
  else
    echo "$ICON_OFF"
  fi
}

turn_on() {
  xset s off
  xset s noblank
  xset -dpms
  command -v notify-send >/dev/null && notify-send "☕ Caffeine" "Pantalla siempre encendida"
}

turn_off() {
  xset s on
  xset +dpms
  command -v notify-send >/dev/null && notify-send "💤 Normal" "Ahorro de energía restaurado"
}

toggle() {
  if is_on; then
    turn_off
  else
    turn_on
  fi
}

#   ./caffeine.sh --tail   -> Prints the icon repeatedly
#   ./caffeine.sh --toggle -> Changes the state of caffeine
#   ./caffeine.sh --on     -> Turn caffeine on
#   ./caffeine.sh --off    -> Turn caffeine off
#   ./caffeine.sh          -> Prints the icon once

case "${1:-}" in
  --on)     turn_on ;;
  --off)    turn_off ;;
  --toggle) toggle ;;
  --tail)
    # Refreshes every second to change the icon fastly every time you click
    while :; do
      print_icon
      sleep 1
    done
    ;;
  *)
    print_icon ;;
esac

