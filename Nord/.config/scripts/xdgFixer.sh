#!/bin/bash
# Fixes broken screenshare?
systemctl --user kill xdg-desktop-portal
systemctl --user kill xdg-desktop-portal-hyprland
sleep 1
systemctl --user start xdg-desktop-portal
systemctl --user start xdg-desktop-portal-hyprland
systemctl --user start xdg-desktop-portal-gtk