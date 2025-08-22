#!/usr/bin/env bash

POLL=1
STATE=shown

hide_bar() {
  polybar-msg cmd hide >/dev/null 2>&1
  STATE=hidden
}

show_bar() {
  polybar-msg cmd show >/dev/null 2>&1
  STATE=shown
}

while true; do
  # ID of the active window
  wid=$(xprop -root _NET_ACTIVE_WINDOW 2>/dev/null | awk -F' ' '{print $5}')

  if [ -n "$wid" ] && [ "$wid" != "0x0" ]; then
    # If it's in fullscreen
    if xprop -id "$wid" _NET_WM_STATE 2>/dev/null | grep -q "_NET_WM_STATE_FULLSCREEN"; then
      [ "$STATE" != "hidden" ] && hide_bar
    else
      [ "$STATE" != "shown" ] && show_bar
    fi
  else
    # If there's no active window, shows polybar
    [ "$STATE" != "shown" ] && show_bar
  fi

  sleep "$POLL"
done
