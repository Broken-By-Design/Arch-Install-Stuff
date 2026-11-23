#!/bin/bash

# Switch between the repository's Fish and Zsh configurations.

set -e

if [ "$#" -ne 1 ] || { [ "$1" != "fish" ] && [ "$1" != "zsh" ]; }; then
    echo "Usage: $0 <fish|zsh>"
    exit 2
fi

TARGET="$1"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
REPO_ROOT="$(dirname "$SCRIPT_DIR")"

echo "Installing $TARGET..."
doas pacman -S --needed "$TARGET" --noconfirm

if [ "$TARGET" = "fish" ]; then
    mkdir -p "$HOME/.config/fish"
    cp "$REPO_ROOT/configs/fish/config.fish" "$HOME/.config/fish/config.fish"
else
    mkdir -p "$HOME"
    cp "$REPO_ROOT/configs/zsh/.zshrc" "$HOME/.zshrc"

    if [ ! -d "$HOME/.oh-my-zsh" ]; then
        RUNZSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    fi

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
fi

SHELL_PATH="$(command -v "$TARGET")"
chsh -s "$SHELL_PATH"

echo "Switched to $TARGET. Log out and back in to use it as your default shell."
