#!/bin/bash

if [[ -z "$1" ]]; then
  echo "Usage: $0 <dot>"
  exit 1
fi

CURRENT_WS=$(i3-msg -t get_workspaces \
  | jq '.[] | select(.focused==true).name' \
  | cut -d"\"" -f2)

[[ "$CURRENT_WS" != "$1" ]] && i3-msg move container to workspace $1
