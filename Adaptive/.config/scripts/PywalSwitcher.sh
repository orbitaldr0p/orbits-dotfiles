wall=$(find ~/Pictures/Wallpapers/ -type f -name "*.jpg" -o -name "*.png" -o -name "*.gif" | shuf -n 1)

swww kill
swww init

# Picks background wallpaper
swww img $wall --transition-bezier .43,1.19,1,.4 \
        --transition-fps=60 \
        --transition-type="random" \
        --transition-duration=1 \
        # --transition-pos "$( hyprctl cursorpos )"




# generate color scheme
wal -c
wal -i $wall


# Enable this (by removing the # next to pywalfox update) if you use firefox AND downloaded the pywalfox extension and installed repository.
# pywalfox update


# Deletes the sww cache
# rm -rf $HOME/.cache/swww

sleep 5

exit