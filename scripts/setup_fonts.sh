#!/bin/bash

# Setup Fonts (System Packages and Manual Downloads)

echo "Installing font packages via Pacman/Paru..."
sudo pacman -S --needed awesome-terminal-fonts cantarell-fonts gsfonts noto-fonts-cjk ttf-bitstream-vera ttf-dejavu ttf-liberation ttf-opensans --noconfirm

# Check if paru is installed for AUR fonts
if command -v paru >/dev/null 2>&1; then
    paru -S --needed ttf-meslo-nerd ttf-nerd-fonts-symbols --noconfirm
else
    echo "Paru is not installed. Skipping AUR fonts (ttf-meslo-nerd, ttf-nerd-fonts-symbols)."
fi

echo "Creating local fonts directory..."
mkdir -p ~/.local/share/fonts

# JetBrainsMono Nerd Font is handled in zsh_and_kitty_conf.sh, but we'll add other downloaded ones here
# You have Geist, Inter, and Monaspace installed manually in ~/.local/share/fonts

echo "Downloading and installing Monaspace fonts..."
mkdir -p /tmp/monaspace
cd /tmp/monaspace || exit
curl -fLo monaspace.zip https://github.com/githubnext/monaspace/releases/download/v1.000/monaspace-v1.000.zip
unzip -o monaspace.zip
cp -r monaspace-v1.000/fonts/otf/* ~/.local/share/fonts/

echo "Downloading and installing Inter fonts..."
mkdir -p /tmp/inter
cd /tmp/inter || exit
curl -fLo inter.zip https://github.com/rsms/inter/releases/download/v4.0/Inter-4.0.zip
unzip -o inter.zip
cp *.ttf ~/.local/share/fonts/

echo "Downloading and installing Geist fonts..."
mkdir -p /tmp/geist
cd /tmp/geist || exit
curl -fLo geist.zip https://github.com/vercel/geist-font/releases/download/1.3.0/Geist-1.3.0.zip
curl -fLo geist-mono.zip https://github.com/vercel/geist-font/releases/download/1.3.0/GeistMono-1.3.0.zip
unzip -o geist.zip
unzip -o geist-mono.zip
cp -r Geist-1.3.0/statics-otf/* ~/.local/share/fonts/ 2>/dev/null || cp -r Geist-1.3.0/statics-ttf/* ~/.local/share/fonts/
cp -r GeistMono-1.3.0/statics-otf/* ~/.local/share/fonts/ 2>/dev/null || cp -r GeistMono-1.3.0/statics-ttf/* ~/.local/share/fonts/

echo "Cleaning up temp files..."
cd "$HOME" || exit
rm -rf /tmp/monaspace /tmp/inter /tmp/geist

echo "Updating font cache..."
fc-cache -fv

echo "Fonts installed successfully!"
