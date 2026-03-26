#!/bin/bash

# Map app names to icons (using Nerd Font icons)
icon_map() {
  case "$1" in
    "Safari") echo "󰀹" ;;
    "Firefox") echo "󰈹" ;;
    "Terminal"|"iTerm2"|"Alacritty"|"kitty") echo "" ;;
    "Warp") echo "󰆍" ;;
    "Google Chrome") echo "󰊯" ;;
    "Signal")
      badge=$(lsappinfo info -only StatusLabel "Signal" 2>/dev/null | grep -o '"label"="[^"]*"' | cut -d'"' -f4)
      if [ -n "$badge" ]; then
        echo "󰭹˙"
      else
        echo "󰭹"
      fi
      ;;
    "Notion") echo $'\xee\xa1\x88' ;;
    "Code") echo "󰨞" ;;
    "Slack")
      badge=$(lsappinfo info -only StatusLabel "Slack" 2>/dev/null | grep -o '"label"="[^"]*"' | cut -d'"' -f4)
      if [ -n "$badge" ]; then
        echo "󰒱˙"
      else
        echo "󰒱"
      fi
      ;;
    "Discord") echo "󰙯" ;;
    "Finder") echo "󰀶" ;;
    "Messages") echo "󰍩" ;;
    "Mail") echo "󰇮" ;;
    "Spotify") echo "󰓇" ;;
    "Notes") echo "󰎞" ;;
    *) echo "󰘔" ;;  # fallback icon
  esac
}

update_space() {
  local sid="$1"
  local current="$2"
  local is_number="$3"

  apps=$(aerospace list-windows --workspace "$sid" --format '%{app-name}' 2>/dev/null)

  # Number workspaces: hide when empty, show when occupied
  if [ "$is_number" = "true" ]; then
    if [ -z "$apps" ] && [ "$sid" != "$current" ]; then
      sketchybar --set space.$sid drawing=off
      return
    else
      sketchybar --set space.$sid drawing=on
    fi
  fi

  if [ -z "$apps" ]; then
    label=""
    icon_text="$sid"
  else
    icons=""
    while IFS= read -r app; do
      icon=$(icon_map "$app")
      icons+="$icon "
    done <<< "$apps"
    label="$icons"
    icon_text=""
  fi

  if [ "$sid" = "$current" ]; then
    sketchybar --set space.$sid \
      icon="$icon_text" \
      label="$label" \
      background.drawing=on \
      background.color=0xffffffff \
      icon.color=0xff000000 \
      label.color=0xff000000
  else
    sketchybar --set space.$sid \
      icon="$icon_text" \
      label="$label" \
      background.drawing=off \
      icon.color=0xffffffff \
      label.color=0xffffffff
  fi
}

# Use the env var from the event, fall back to querying aerospace
CURRENT="${FOCUSED_WORKSPACE:-$(aerospace list-workspaces --focused)}"

# Letter workspaces (always visible)
for sid in N P W C E T S M F; do
  update_space "$sid" "$CURRENT" "false"
done

# Number workspaces (only visible when occupied or focused)
for sid in $(seq 0 9); do
  update_space "$sid" "$CURRENT" "true"
done
