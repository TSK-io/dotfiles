#!/bin/bash

# debian
sudo apt update && sudo apt upgrade -y

# base-desktop-debian
sudo apt install -y \
xorg \
lightdm \
lightdm-gtk-greeter \
i3-wm \
i3status \
i3lock \
rofi \
x11-xserver-utils \
firefox-esr \
fonts-noto \
fonts-wqy-microhei

# default-terminal
sudo apt install -y alacritty && command -v alacritty > /dev/null && sudo update-alternatives --set x-terminal-emulator /usr/bin/alacritty

# clean
sudo apt autoremove -y && sudo apt clean
