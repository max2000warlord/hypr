#!/bin/sh

HYPRPAPER_CONF="$HOME/.config/hypr/hyprpaper.conf"
LINK_PATH="$HOME/.cache/hyprpaper/current"

mkdir -p "$(dirname "$LINK_PATH")"

get_wallpaper() {
  grep "^wallpaper = eDP-1," "$HYPRPAPER_CONF" 2>/dev/null |
    sed 's/^wallpaper = eDP-1,//' |
    tr -d ' '
}

# Initial setup
CURRENT=$(get_wallpaper)
[ -n "$CURRENT" ] && [ -f "$CURRENT" ] && {
  ln -sf "$CURRENT" "$LINK_PATH"
  wal -i "$CURRENT"
}

# Watch for changes
inotifywait -m -e modify "$HYPRPAPER_CONF" 2>/dev/null | while read -r; do
  WALLPAPER=$(get_wallpaper)
  [ -n "$WALLPAPER" ] && [ -f "$WALLPAPER" ] && {
    ln -sf "$WALLPAPER" "$LINK_PATH"
    wal -i "$WALLPAPER"
  }
done
