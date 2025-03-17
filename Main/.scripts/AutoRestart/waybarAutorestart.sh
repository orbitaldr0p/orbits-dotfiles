CONFIG_FILES="$HOME/.config/waybar/config.jsonc $HOME/.config/waybar/style.css"
waybar &

# Watch for changes in the config files
while true; do
    inotifywait -e modify $CONFIG_FILES > /dev/null
    killall -SIGUSR2 waybar
done
