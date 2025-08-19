#!/usr/bin/env bash
set -euo pipefail

current=$(i3-msg -t get_workspaces | jq '.[] | select(.focused).num')

if [[ -z "${current:-}" || "$current" -le 0 ]]; then current=1; fi

target=$(( current + 1 ))
i3-msg "move container to workspace number $target"
i3-msg "workspace number $target"
