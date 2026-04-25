#!/bin/bash

# debian
sudo apt update && sudo apt upgrade -y

# xorg-and-dm
sudo apt install -y xorg lightdm lightdm-gtk-greeter

# i3wm-core (保留了 i3lock)
sudo apt install -y i3-wm i3status i3lock suckless-tools x11-xserver-utils

# desktop-apps (去掉了 picom, feh, lxappearance)
sudo apt install -y alacritty pcmanfm firefox-esr pavucontrol pulseaudio

# fonts (去掉了 fonts-font-awesome)
sudo apt install -y fonts-noto fonts-wqy-microhei

# default-terminal
command -v alacritty > /dev/null && sudo update-alternatives --set x-terminal-emulator /usr/bin/alacritty

# enable-services
sudo systemctl enable lightdm
sudo systemctl enable NetworkManager

# clean
sudo apt autoremove -y && sudo apt clean
