#!/bin/bash

colour=$(hyprpicker -a)

if [ -n "$colour" ]; then
    icon_path="/tmp/colour_preview.png"
    MAGICK_OCL_DEVICE=OFF convert -size 64x64 xc:"$colour" "$icon_path"
    notify-send -i "$icon_path" "Selected Colour: $colour" -t 2000 -r 91100
fi
