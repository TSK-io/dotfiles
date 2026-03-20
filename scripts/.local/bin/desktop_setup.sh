#!/bin/bash

# update && upgrade
apk upgrade && apk upgrade

sudo apk add alacritty dunst xclip maim dbus-x11 xinit i3status i3lock i3wm xorg-server
sudo apk add copyq --repository=https://dl-cdn.alpinelinux.org/alpine/edge/testing/

# keyd
sudo apk add keyd
sudo ln -sf $HOME/dotfiles/keyd/default.conf /etc/keyd/
sudo keyd

sudo apk add prismlauncher

sudo apk add rpi-imager --repository=https://dl-cdn.alpinelinux.org/alpine/edge/testing/

# qemu
sudo apt -y install qemu-kvm libvirt-daemon-system libvirt-clients bridge-utils virt-manager
sudo adduser $USER libvirt
sudo adduser $USER kvm

# fcitx5 # Restart Required
sudo apt -y install fcitx5 fcitx5-chinese-addons fcitx5-frontend-gtk3 fcitx5-frontend-qt5 im-config
im-config -n fcitx5

# v2rayA
wget -qO - https://apt.v2raya.org/key/public-key.asc | sudo tee /etc/apt/keyrings/v2raya.asc
echo "deb [signed-by=/etc/apt/keyrings/v2raya.asc] https://apt.v2raya.org/ v2raya main" | sudo tee /etc/apt/sources.list.d/v2raya.list
sudo apt -y update
sudo apt -y install v2raya v2ray 
sudo systemctl enable --now v2raya

# daed (Official script)
command -v daed > /dev/null || { wget https://github.com/daeuniverse/daed/releases/download/v1.24.0/installer-daed-linux-x86_64.deb && sudo apt -y install ./installer-daed-linux-x86_64.deb && rm installer-daed-linux-x86_64.deb; }
sudo systemctl enable --now daed

# FlClash
sudo apt -y install libayatana-appindicator3-dev libkeybinder-3.0-dev
command -v FlClash > /dev/null || { wget https://github.com/chen08209/FlClash/releases/download/v0.8.92/FlClash-0.8.92-linux-amd64.deb && sudo apt -y install ./FlClash-0.8.92-linux-amd64.deb && rm FlClash-0.8.92-linux-amd64.deb; }

