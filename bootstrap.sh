#!/usr/bin/env bash

set -euo pipefail


printf "Package manager: " 
read pm

pkgs=(git neovim fastfetch ripgrep fzf tmux zsh hyprland hyprland-devel rofi-wayland quickshell greetd tuigreet hyprpaper cliphist alacritty nautilus fira-code-fonts btop gnome-keyring acpi pipewire pavucontrol)

case "$pm" in
  zypper) 
      echo "Installing packages"
      sudo zypper --non-interactive in "${pkgs[@]}"
      ;;
  apt)    
      echo "Installing packages"
      sudo apt update && sudo apt install -y "${pkgs[@]}"
      ;;
  dnf)    
      echo "Installing packages"
      sudo dnf copr -y enable errornointernet/quickshell
      sudo dnf copr -y enable alternateved/cliphist
      sudo dnf copr -y enable solopasha/hyprland
      sudo dnf install -y "${pkgs[@]}"
      ;;
  *)
      echo "Package manager $pm not supported"
      exit 1
      ;;
    
esac

sudo systemctl disable display-manager.service
sudo systemctl enable greetd.service
sudo useradd -M -G video greeter
sudo cp ./greetd.toml /etc/greetd/conf.toml
