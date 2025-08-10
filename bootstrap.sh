#!/usr/bin/env bash

set -euo pipefail

pkgs=(git neovim fastfetch ripgrep fzf tmux zsh hyprland hyprland-devel hyprland-qtutils gcc rofi-wayland quickshell greetd tuigreet hyprpaper cliphist alacritty nautilus fira-code-fonts btop gnome-keyring acpi pipewire pavucontrol libqt5-qtwayland qt6-wayland)

echo "Installing packages"
sudo zypper addrepo https://download.opensuse.org/repositories/home:dp348/openSUSE_Tumbleweed/home:dp348.repo

sudo zypper refresh
sudo zypper --non-interactive in "${pkgs[@]}"

sudo systemctl disable display-manager.service
sudo systemctl enable greetd.service
sudo cp ./greetd.toml /etc/greetd/conf.toml
