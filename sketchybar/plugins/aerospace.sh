#!/bin/bash

# Map app names to icons (using Nerd Font icons)
icon_map() {
  case "$1" in
    "Safari") echo "󰀹" ;;
    "Firefox") echo "󰈹" ;;
    "Terminal"|"iTerm2"|"Alacritty"|"kitty") echo "" ;;
    "Warp") echo "󰆍" ;;
    "Google Chrome") echo "󰊯" ;;
    "Signal") echo "󰭹" ;;
    "Notion") echo "" ;;
    "Code") echo "󰨞" ;;
    "Slack") echo "󰒱" ;;
    "Discord") echo "󰙯" ;;
    "Finder") echo "󰀶" ;;
    "Messages") echo "󰍩" ;;
    "Mail") echo "󰇮" ;;
    "Spotify") echo "󰓇" ;;
    "Notes") echo "󰎞" ;;
    *) echo "󰘔" ;;  # fallback icon
  esac
}

# Use the env var from the event, fall back to querying aerospace
CURRENT="${FOCUSED_WORKSPACE:-$(aerospace list-workspaces --focused)}"

for sid in $(seq 1 9); do
  apps=$(aerospace list-windows --workspace "$sid" --format '%{app-name}' 2>/dev/null)

  # Build label from app icons
  if [ -z "$apps" ]; then
    label=""
  else
    icons=""
    while IFS= read -r app; do
      icon=$(icon_map "$app")
      icons+="$icon "
    done <<< "$apps"
    label="$icons"
  fi

  # Highlight focused workspace
  if [ "$sid" = "$CURRENT" ]; then
    sketchybar --set space.$sid \
      label="$label" \
      background.drawing=on \
      background.color=0xffffffff \
      icon.color=0xff000000 \
      label.color=0xff000000
  else
    sketchybar --set space.$sid \
      label="$label" \
      background.drawing=off \
      icon.color=0xffffffff \
      label.color=0xffffffff
  fi
done
