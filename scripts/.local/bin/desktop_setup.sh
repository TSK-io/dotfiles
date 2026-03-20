#!/bin/bash

# update && upgrade
apk upgrade && apk upgrade

sudo apk add alacritty dunst xclip maim dbus-x11 xinit i3status i3lock i3wm xorg-server

# keyd
sudo apk add keyd
sudo ln -sf $HOME/dotfiles/keyd/default.conf /etc/keyd/
sudo keyd

# fcitx5 # Restart Required
sudo apt -y install fcitx5 fcitx5-chinese-addons fcitx5-frontend-gtk3 fcitx5-frontend-qt5 im-config
im-config -n fcitx5
