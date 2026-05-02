#!/bin/bash

# Setup Gaming (Steam, Wine, Lutris, 32-bit drivers)

echo "Enabling multilib repository..."
# This uncomments the [multilib] section and its Include line in pacman.conf
# It uses sed to find [multilib] and uncomments both that line and the line directly below it
sudo sed -i '/^#\[multilib\]/{N;s/#//g}' /etc/pacman.conf

echo "Syncing package databases..."
sudo pacman -Sy

echo "Installing gaming packages and 32-bit Nvidia drivers..."
sudo pacman -S --needed steam lutris wine-staging winetricks lib32-nvidia-utils --noconfirm

echo "Gaming setup complete! The multilib repository is now active."
