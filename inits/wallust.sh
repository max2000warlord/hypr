#!/bin/sh

CACHE_FILE="$HOME/.cache/swww/eDP-1"
LINK_PATH="$HOME/.cache/swww/current"

get_wallpaper() {
  tr -d '\000' <"$CACHE_FILE" | grep -o '/home/[^[:space:]]*\.\(jpg\|jpeg\|png\|webp\)$'
}

LAST_WALLPAPER=$(get_wallpaper)
ln -sf "$LAST_WALLPAPER" "$LINK_PATH"

while true; do
  CURRENT_WALLPAPER=$(get_wallpaper)

  if [ "$CURRENT_WALLPAPER" != "$LAST_WALLPAPER" ]; then
    LAST_WALLPAPER="$CURRENT_WALLPAPER"

    # Update symlink and apply colors
    ln -sf "$CURRENT_WALLPAPER" "$LINK_PATH"
    wallust run -s "$CURRENT_WALLPAPER"

  fi

  sleep 2
done
