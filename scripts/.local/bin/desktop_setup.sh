#!/bin/bash

# update && upgrade
sudo apt -y update && sudo apt -y upgrade

sudo apt -y install alacritty copyq dunst xclip maim dbus-x11 xinit xserver-xorg i3-wm i3status i3lock

# Prism Launcher
sudo wget https://prism-launcher-for-debian.github.io/repo/prismlauncher.gpg -O /usr/share/keyrings/prismlauncher-archive-keyring.gpg \
  && echo "deb [signed-by=/usr/share/keyrings/prismlauncher-archive-keyring.gpg] https://prism-launcher-for-debian.github.io/repo $(. /etc/os-release; echo "${UBUNTU_CODENAME:-${DEBIAN_CODENAME:-${VERSION_CODENAME}}}") main" | sudo tee /etc/apt/sources.list.d/prismlauncher.list \
  && sudo apt -y update \
  && sudo apt -y install prismlauncher

# rpi-imager
command -v rpi-imager > /dev/null || { wget https://github.com/raspberrypi/rpi-imager/releases/download/v2.0.3/rpi-imager_2.0.3_amd64.deb && sudo apt -y install ./rpi-imager_2.0.3_amd64.deb && rm rpi-imager_2.0.3_amd64.deb; }

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
wget -P /tmp https://github.com/daeuniverse/daed/releases/latest/download/installer-daed-linux-$(arch).deb
sudo dpkg -i /tmp/installer-daed-linux-$(arch).deb
sudo systemctl enable --now daed

echo "✅ 所有安装任务已完成！建议重启系统以应用组权限和驱动更改。"

# zen
curl -fsSL https://github.com/zen-browser/updates-server/raw/refs/heads/main/install.sh | $SHELL

# FlClash
sudo apt -y install libayatana-appindicator3-dev libkeybinder-3.0-dev
command -v FlClash > /dev/null || { wget https://github.com/chen08209/FlClash/releases/download/v0.8.92/FlClash-0.8.92-linux-amd64.deb && sudo apt -y install ./FlClash-0.8.92-linux-amd64.deb && rm FlClash-0.8.92-linux-amd64.deb; }

