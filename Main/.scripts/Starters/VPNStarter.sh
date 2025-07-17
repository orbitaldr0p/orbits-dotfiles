#!/bin/bash
current_timezone=$(timedatectl | grep "Time zone" | awk '{print $3}')

target_timezone="Asia/Shanghai"

if [ "$current_timezone" == "$target_timezone" ]; then
    echo "Launching Clash"
    sleep 4
    cfw --force-device-scale-factor=1.5
else
    echo "Launching Mullvad"
    mullvad
    sleep 4
    mullvad-vpn
fi
