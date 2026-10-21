#!/bin/bash

# Auto Installer for Zsh, Oh My Zsh, Oh My Posh, and Kitty with custom configs

echo "Updating system and installing dependencies..."
sudo pacman -Syu --noconfirm
sudo pacman -S --needed zsh kitty curl unzip fontconfig git hyfetch zoxide lsd bat opendoas --noconfirm

if command -v paru >/dev/null 2>&1; then
    paru -S --needed pay-respects --noconfirm
else
    echo "paru is unavailable; skipping pay-respects (AUR)."
fi

# Get the directory where the script is located, and the root of the repo
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" &> /dev/null && pwd)"
REPO_ROOT="$(dirname "$SCRIPT_DIR")"

echo "Installing Oh My Zsh..."
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    RUNZSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
    echo "Oh My Zsh already installed."
fi

echo "Installing Oh My Zsh plugins used by .zshrc..."
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

if [ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
fi

if [ ! -d "$ZSH_CUSTOM/plugins/fast-syntax-highlighting" ]; then
    git clone https://github.com/zdharma-continuum/fast-syntax-highlighting "$ZSH_CUSTOM/plugins/fast-syntax-highlighting"
fi

if [ ! -d "$ZSH_CUSTOM/plugins/zsh-history-substring-search" ]; then
    git clone https://github.com/zsh-users/zsh-history-substring-search "$ZSH_CUSTOM/plugins/zsh-history-substring-search"
fi

echo "Installing Oh My Posh..."
curl -s https://ohmyposh.dev/install.sh | bash -s

echo "Downloading and installing JetBrainsMono Nerd Font..."
mkdir -p ~/Downloads/JetBrainsMono
cd ~/Downloads/JetBrainsMono
curl -fLo JetBrainsMono.zip https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/JetBrainsMono.zip
unzip -o JetBrainsMono.zip
mkdir -p ~/.local/share/fonts/
cp ./* ~/.local/share/fonts/
fc-cache -fv
cd "$SCRIPT_DIR"

echo "Applying your EXACT configs..."
# Kitty
mkdir -p ~/.config/kitty
cp "$REPO_ROOT/configs/kitty/kitty.conf" ~/.config/kitty/
cp "$REPO_ROOT/configs/kitty/current-theme.conf" ~/.config/kitty/

# Oh My Posh
mkdir -p ~/.config/oh-my-posh
cp "$REPO_ROOT/configs/oh-my-posh/main.toml" ~/.config/oh-my-posh/

# Zsh
cp "$REPO_ROOT/configs/zsh/.zshrc" ~/

echo "Done! Please change your default shell to Zsh using 'chsh -s $(which zsh)' if you haven't already."
echo "You can now start 'kitty' to see the changes."
