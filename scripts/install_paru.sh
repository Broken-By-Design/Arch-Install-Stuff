#!/bin/bash

# Auto Installer for Paru (AUR Helper)

echo "Installing base dependencies..."
sudo pacman -S --needed base-devel git --noconfirm

echo "Cloning and building Paru..."
git clone https://aur.archlinux.org/paru.git /tmp/paru
cd /tmp/paru || exit

# makepkg cannot be run as root
makepkg -si --noconfirm

echo "Cleaning up..."
cd "$HOME" || exit
rm -rf /tmp/paru

echo "Paru is installed and ready!"
