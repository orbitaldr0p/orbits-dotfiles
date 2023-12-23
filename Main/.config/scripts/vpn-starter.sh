#!/bin/bash

#Launches clash if in china, mullvad otherwise.
# Get the current timezone
current_timezone=$(timedatectl | grep "Time zone" | awk '{print $3}')

# Define the target timezone
target_timezone="Asia/Shanghai"

# Check if the current timezone is Shanghai
if [ "$current_timezone" == "$target_timezone" ]; then
    echo "Launching Clash"
    cfw
else
    echo "Launching Mullvad"
    mullvad-vpn
fi
