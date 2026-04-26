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
fonts-noto-cjk \
dunst \
libnotify-bin \
xclip \
slop \
feh \
maim

sudo apt install -y \
pipewire \
wireplumber \
pipewire-pulse \
pulseaudio-utils \
pavucontrol \
alsa-utils

# fcitx5 # Restart Required
sudo apt -y install fcitx5 fcitx5-chinese-addons fcitx5-frontend-gtk3 fcitx5-frontend-qt5 im-config
im-config -n fcitx5

# default-terminal
sudo apt install -y alacritty && command -v alacritty > /dev/null && sudo update-alternatives --set x-terminal-emulator /usr/bin/alacritty

# v2rayA
wget -qO - https://apt.v2raya.org/key/public-key.asc | sudo tee /etc/apt/keyrings/v2raya.asc
echo "deb [signed-by=/etc/apt/keyrings/v2raya.asc] https://apt.v2raya.org/ v2raya main" | sudo tee /etc/apt/sources.list.d/v2raya.list
sudo apt -y update
sudo apt -y install v2raya v2ray 
sudo systemctl enable --now v2raya

# daed (Official script)
command -v daed > /dev/null || { wget https://github.com/daeuniverse/daed/releases/download/v1.24.0/installer-daed-linux-x86_64.deb && sudo apt -y install ./installer-daed-linux-x86_64.deb && rm installer-daed-linux-x86_64.deb; }
sudo systemctl enable --now daed

# zen
curl -fsSL https://github.com/zen-browser/updates-server/raw/refs/heads/main/install.sh | bash

# FlClash
sudo apt -y install libayatana-appindicator3-dev libkeybinder-3.0-dev
command -v FlClash > /dev/null || { wget https://github.com/chen08209/FlClash/releases/download/v0.8.92/FlClash-0.8.92-linux-amd64.deb && sudo apt -y install ./FlClash-0.8.92-linux-amd64.deb && rm FlClash-0.8.92-linux-amd64.deb; }

# vscode
command -v code > /dev/null || { echo "code code/add-microsoft-repo boolean true" | sudo debconf-set-selections && wget -O /tmp/vscode.deb "https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64" && sudo DEBIAN_FRONTEND=noninteractive apt-get install -y /tmp/vscode.deb && rm /tmp/vscode.deb; }

# clean
sudo apt autoremove -y && sudo apt clean
