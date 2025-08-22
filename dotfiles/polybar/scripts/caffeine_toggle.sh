#!/usr/bin/env bash

STATE_FILE="/tmp/polybar_caffeine_state"

enable_caffeine() {
    xset s off -dpms
    echo "on" > "$STATE_FILE"
}

disable_caffeine() {
    xset s on +dpms
    echo "off" > "$STATE_FILE"
}

status() {
    if [[ -f "$STATE_FILE" && "$(cat "$STATE_FILE")" == "on" ]]; then
        echo "%{T2}%{T-}"
    else
        echo "%{T2}%{T-}"
    fi
}

toggle() {
    if [[ -f "$STATE_FILE" && "$(cat "$STATE_FILE")" == "on" ]]; then
        disable_caffeine
    else
        enable_caffeine
    fi
}

case "$1" in
    status) status ;;
    toggle) toggle ;;
    *) echo "Usage: $0 {status|toggle}" ;;
esac
