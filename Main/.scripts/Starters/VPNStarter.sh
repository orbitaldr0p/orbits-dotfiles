#!/bin/bash
current_timezone=$(timedatectl | grep "Time zone" | awk '{print $3}')

target_timezone="Asia/Shanghai"

if [ "$current_timezone" == "$target_timezone" ]; then
    echo "Launching Clash"
    sleep 4
    clash-verge
else
    echo "Launching Mullvad"
    mullvad
    sleep 4
    mullvad-vpn
fi
