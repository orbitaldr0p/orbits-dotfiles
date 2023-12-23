#!/bin/bash

#Launches clash if in china, mullvad otherwise.
# Get the current timezone
current_timezone=$(timedatectl | grep "Time zone" | awk '{print $3}')

# Define the target timezone
target_timezone="Asia/Shanghai"

# Check if the current timezone is Shanghai
if [ "$current_timezone" == "$target_timezone" ]; then
    echo "The timezone is set to Shanghai."
    bash "$HOME/.config/scripts/appimage-starter.sh" clash
else
    echo "The timezone is not set to Shanghai."
    mullvad-vpn
fi
