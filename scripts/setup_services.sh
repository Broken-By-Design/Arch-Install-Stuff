#!/bin/bash

# Setup System Services, Docker, and Virtualization

echo "Installing required packages..."
sudo pacman -S --needed docker docker-compose libvirt virt-manager bluez bluez-utils cups --noconfirm

echo "Enabling and starting system services..."
# Enable services so they start on boot, and start them immediately
sudo systemctl enable --now docker.service
sudo systemctl enable --now libvirtd.service
sudo systemctl enable --now bluetooth.service
sudo systemctl enable --now cups.service

echo "Adding user to required groups..."
# Add the current user to the docker and libvirt groups so you don't need sudo
sudo usermod -aG docker "$USER"
sudo usermod -aG libvirt "$USER"

echo "Setup complete! IMPORTANT: You must log out and log back in (or reboot) for the group changes to take effect."
