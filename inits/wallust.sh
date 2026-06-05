#!/bin/bash

CACHE_DIR="$HOME/.cache/awww"
LINK_PATH="$HOME/.cache/awww/current"

CACHE_FILE=$(find "$CACHE_DIR" -maxdepth 2 -name "eDP-1" 2>/dev/null | head -n1)

if [ -z "$CACHE_FILE" ]; then
  echo "Error: Could not find awww cache file" >&2
  exit 1
fi

get_wallpaper() {
  tr -d '\000' <"$CACHE_FILE" | grep -oP '/home/\S+\.(jpg|jpeg|png|webp)$'
}

LAST_BG=$(get_wallpaper)
ln -sf "$LAST_BG" "$LINK_PATH"

inotifywait -m -e modify "$CACHE_FILE" | while read -r; do
  CURRENT_BG=$(get_wallpaper)

  if [ "$CURRENT_BG" != "$LAST_BG" ]; then
    LAST_BG="$CURRENT_BG"
    ln -sf "$CURRENT_BG" "$LINK_PATH"
    matugen image "$CURRENT_BG"
  fi
done
