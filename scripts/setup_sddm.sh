#!/bin/bash

# Setup SDDM and Theme

echo "Installing SDDM..."
doas pacman -S --needed sddm qt6-5compat qt6-declarqtive qt6-svg --noconfirm

echo "Installing SDDM Astronaut Theme via Paru..."
# Check if paru is installed before trying to use it
if command -v paru >/dev/null 2>&1; then
    paru -S --needed sddm-astronaut-theme --noconfirm
else
    echo "Paru is not installed. Please run install_paru.sh first!"
    exit 1
fi

echo "Configuring SDDM to use the astronaut theme and wayland..."
# Create the sddm.conf.d directory if it doesn't exist
doas mkdir -p /etc/sddm.conf.d

# Create a theme configuration file
echo -e "[Theme]\nCurrent=sddm-astronaut-theme\n\n[General]\nDisplayServer=wayland" | doas tee /etc/sddm.conf.d/10-theme.conf > /dev/null

if command -v dinitctl >/dev/null 2>&1; then
    echo "Enabling and starting SDDM with dinit..."
    doas dinitctl enable sddm
    doas dinitctl start sddm
else
    echo "dinitctl is unavailable; SDDM was configured but not enabled or started."
fi

echo "SDDM setup complete!"
