#!/bin/bash

# Toggle aerospace outer.top gap between 0 (laptop) and 40 (external monitor)
TOML="$HOME/.config/aerospace/aerospace.toml"
CURRENT=$(grep -m1 'outer\.top' "$TOML" | grep -o '[0-9]*')

if [ "$CURRENT" = "0" ]; then
  sed -i '' 's/outer\.top = 0/outer.top = 40/' "$TOML"
else
  sed -i '' "s/outer\.top = $CURRENT/outer.top = 0/" "$TOML"
fi

aerospace reload-config
