#!/bin/bash

# Setup Docker and Virtualization Packages

echo "Installing required packages..."
doas pacman -S --needed docker docker-compose libvirt virt-manager bluez bluez-utils cups --noconfirm

echo "Adding user to required groups..."
# Add the current user to the docker and libvirt groups
doas usermod -aG docker "$USER"
doas usermod -aG libvirt "$USER"

if command -v dinitctl >/dev/null 2>&1; then
    echo "Enabling and starting services with dinit..."
    for service in docker libvirtd bluetoothd cups; do
        doas dinitctl enable "$service"
        doas dinitctl start "$service"
    done
else
    echo "dinitctl is unavailable; services were installed but not enabled or started."
fi

echo "Setup complete!"
echo "Log out and back in for the group changes to take effect."
