#!/bin/bash

set -e

echo ""
echo "  ██╗  ██╗██╗   ██╗██████╗ ██████╗ "
echo "  ██║  ██║╚██╗ ██╔╝██╔══██╗██╔══██╗"
echo "  ███████║ ╚████╔╝ ██████╔╝██████╔╝"
echo "  ██╔══██║  ╚██╔╝  ██╔═══╝ ██╔══██╗"
echo "  ██║  ██║   ██║   ██║     ██║  ██║"
echo "  ╚═╝  ╚═╝   ╚═╝   ╚═╝     ╚═╝  ╚═╝"
echo ""
echo "  gruvbox dots — arch installer"
echo ""

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "  Installing dependencies..."
echo ""

sudo pacman -Syu --needed \
    hyprland \
    hyprlock \
    hypridle \
    awww \
    waybar \
    rofi-wayland \
    brightnessctl \
    wireplumber \
    pavucontrol \
    networkmanager \
    nm-connection-editor \
    blueman \
    imagemagick \
    libnotify \
    fastfetch \
    kitty \
    fish \
    ttf-jetbrains-mono-nerd

echo ""
echo "  Backing up existing configs..."
echo ""

backup() {
    local target="$HOME/.config/$1"
    if [ -e "$target" ]; then
        mv "$target" "${target}.bak.$(date +%s)"
        echo "  backed up $target"
    fi
}

backup hypr
backup waybar
backup kitty

echo ""
echo "  Installing configs..."
echo ""

install_conf() {
    local name="$1"
    mkdir -p "$HOME/.config/$name"
    cp -r "$DOTFILES_DIR/$name/." "$HOME/.config/$name/"
    echo "  installed ~/.config/$name"
}

install_conf hypr
install_conf waybar
install_conf kitty

chmod +x "$HOME/.config/hypr/scripts/lock"
chmod +x "$HOME/.config/hypr/scripts/wallpaper"

mkdir -p "$HOME/.config/hypr/wallpapers"
mkdir -p "$HOME/.cache/wallpaper-picker"

echo "     installing rofi configs"
rm -rf ~/.config/rofi
mkdir ~/.config/rofi
cp rofi/gruvbox-material.rasi ~/.config/rofi
cp rofi/config.rasi ~/.config/rofi
echo "     rofi configs installed"

echo ""
echo "  Done. Log into Hyprland to get started."
echo ""
