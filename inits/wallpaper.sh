#!/bin/sh

CACHE_FILE="$HOME/.cache/swww/eDP-1"
LINK_PATH="$HOME/.cache/swww/current"

# Get the initial wallpaper
LAST_WALLPAPER=$(strings "$CACHE_FILE" | grep '^/')
ln -sf "$LAST_WALLPAPER" "$LINK_PATH"

while true; do
  CURRENT_WALLPAPER=$(strings "$CACHE_FILE" | grep '^/')

  if [ "$CURRENT_WALLPAPER" != "$LAST_WALLPAPER" ]; then
    LAST_WALLPAPER="$CURRENT_WALLPAPER"
    ln -sf "$CURRENT_WALLPAPER" "$LINK_PATH"

    # Apply pywal colors
    wal -i "$CURRENT_WALLPAPER"

    # Optional: reload Waybar
    # pkill -SIGUSR2 waybar
  fi

  sleep 2
done
