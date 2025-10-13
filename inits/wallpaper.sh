#!/bin/sh

# Get the initial wallpaper
LAST_WALLPAPER=$(swww query | awk -F 'image: ' '{print $2}')

while true; do
  # Get the current wallpaper
  CURRENT_WALLPAPER=$(swww query | awk -F 'image: ' '{print $2}')

  # Check if the wallpaper has changed
  if [ "$CURRENT_WALLPAPER" != "$LAST_WALLPAPER" ]; then
    LAST_WALLPAPER="$CURRENT_WALLPAPER"

    # Apply pywal colors
    wal -i "$CURRENT_WALLPAPER"

    # Reload Waybar
    #pkill -SIGUSR2 waybar
  fi

  # Sleep for a short duration to avoid excessive CPU usage
  sleep 2
done
