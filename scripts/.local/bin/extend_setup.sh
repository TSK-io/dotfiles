#!/bin/bash

# debian
sudo apt update && sudo apt upgrade -y

# xorg-and-dm
sudo apt install -y xorg lightdm lightdm-gtk-greeter

# i3wm-core
sudo apt install -y i3-wm i3status i3lock suckless-tools x11-xserver-utils

# desktop-apps
sudo apt install -y alacritty pcmanfm feh picom firefox-esr lxappearance network-manager-gnome pavucontrol pulseaudio

# fonts
sudo apt install -y fonts-noto fonts-font-awesome fonts-wqy-microhei

# default-terminal
command -v alacritty > /dev/null && sudo update-alternatives --set x-terminal-emulator /usr/bin/alacritty

# enable-services
sudo systemctl enable lightdm
sudo systemctl enable NetworkManager

# clean
sudo apt autoremove -y && sudo apt clean
