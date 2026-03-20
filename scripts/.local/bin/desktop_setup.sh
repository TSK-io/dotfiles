#!/bin/bash

# update && upgrade
apk upgrade && apk upgrade

sudo apk add dunst xclip maim dbus-x11 xinit i3status i3lock i3wm xorg-server

# keyd
sudo apk add keyd
sudo ln -sf $HOME/dotfiles/keyd/default.conf /etc/keyd/
sudo keyd
