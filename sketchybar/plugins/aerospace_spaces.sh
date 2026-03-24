#!/bin/bash

CURRENT=$(aerospace current-workspace)

for i in {1..9}; do
  if [ "$i" = "$CURRENT" ]; then
    sketchybar --set space.$i \
      background.drawing=on \
      background.color=0xff29f2e8 \
      label.color=0xff000000
  else
    sketchybar --set space.$i \
      background.drawing=off \
      label.color=0xffffffff
  fi
done