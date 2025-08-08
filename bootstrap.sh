#!/usr/bin/env bash

set -euo pipefail


printf "Package manager: " 
read pm

pkgs=(git neovim fastfetch ripgrep fzf tmux zsh hyprland rofi-wayland quickshell greetd tuigreet hyprpaper cliphist alacritty)

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
      sudo dnf install -y "${pkgs[@]}"
      ;;
  *)
      echo "Package manager $pm not supported"
      ;;
    
esac
