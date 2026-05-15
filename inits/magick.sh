#!/bin/bash

IMAGE="$1"
NUM_COLORS="${2:-16}"

if [[ -z "$IMAGE" ]]; then
  echo "Usage: $0 <image> [num_colors]"
  exit 1
fi

TEMP_IMG="/tmp/wallpaper-resize.jpg"
magick "$IMAGE" -resize 50% "$TEMP_IMG"

# Extract colors
COLORS=$(magick "$TEMP_IMG" -quantize LAB -kmeans "$NUM_COLORS" -unique-colors txt: | grep -oP '#[0-9A-F]{6}')

# Convert to array
mapfile -t COLOR_ARRAY <<<"$COLORS"

# Waybar colors (CSS)
cat >~/.config/waybar/colors.css <<EOF
/* Generated from $IMAGE */
@define-color background ${COLOR_ARRAY[0]};
@define-color foreground ${COLOR_ARRAY[8]};
@define-color color0  ${COLOR_ARRAY[0]};
@define-color color1  ${COLOR_ARRAY[1]};
@define-color color2  ${COLOR_ARRAY[2]};
@define-color color3  ${COLOR_ARRAY[3]};
@define-color color4  ${COLOR_ARRAY[4]};
@define-color color5  ${COLOR_ARRAY[5]};
@define-color color6  ${COLOR_ARRAY[6]};
@define-color color7  ${COLOR_ARRAY[7]};
@define-color color8  ${COLOR_ARRAY[8]};
@define-color color9  ${COLOR_ARRAY[9]};
@define-color color10 ${COLOR_ARRAY[10]};
@define-color color11 ${COLOR_ARRAY[11]};
@define-color color12 ${COLOR_ARRAY[12]};
@define-color color13 ${COLOR_ARRAY[13]};
@define-color color14 ${COLOR_ARRAY[14]};
@define-color color15 ${COLOR_ARRAY[15]};
EOF

# Hyprland colors
cat >~/.config/hypr/hypr.colors.conf <<EOF
# Generated from $IMAGE
\$background = rgb(${COLOR_ARRAY[0]#\#})
\$foreground = rgb(${COLOR_ARRAY[8]#\#})
\$color0 = rgb(${COLOR_ARRAY[0]#\#})
\$color1 = rgb(${COLOR_ARRAY[1]#\#})
\$color2 = rgb(${COLOR_ARRAY[2]#\#})
\$color3 = rgb(${COLOR_ARRAY[3]#\#})
\$color4 = rgb(${COLOR_ARRAY[4]#\#})
\$color5 = rgb(${COLOR_ARRAY[5]#\#})
\$color6 = rgb(${COLOR_ARRAY[6]#\#})
\$color7 = rgb(${COLOR_ARRAY[7]#\#})
\$color8 = rgb(${COLOR_ARRAY[8]#\#})
\$color9 = rgb(${COLOR_ARRAY[9]#\#})
\$color10 = rgb(${COLOR_ARRAY[10]#\#})
\$color11 = rgb(${COLOR_ARRAY[11]#\#})
\$color12 = rgb(${COLOR_ARRAY[12]#\#})
\$color13 = rgb(${COLOR_ARRAY[13]#\#})
\$color14 = rgb(${COLOR_ARRAY[14]#\#})
\$color15 = rgb(${COLOR_ARRAY[15]#\#})

# Border colors
col.active_border = \$color5 \$color6 45deg
col.inactive_border = \$color0
EOF

echo "Generated:"
echo "  - waybar-colors.css"
echo "  - hypr.colors.conf"
