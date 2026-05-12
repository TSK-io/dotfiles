#!/bin/bash

# debian
sudo apt update && sudo apt upgrade -y

# base-desktop-debian
sudo apt install -y \
xorg \
lightdm \
lightdm-gtk-greeter \
i3 \
rofi \
x11-xserver-utils \
fonts-noto-cjk \
pulseaudio-utils \
pipewire-audio \
pavucontrol \
dunst \
libnotify-bin \
chromium \
xclip \
feh \
scrot

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

# zen
[ -d "$HOME/.tarball-installations/zen" ] || curl -fsSL https://github.com/zen-browser/updates-server/raw/refs/heads/main/install.sh | bash

# vscode
command -v code > /dev/null || { echo "code code/add-microsoft-repo boolean true" | sudo debconf-set-selections && wget -O /tmp/vscode.deb "https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64" && sudo DEBIAN_FRONTEND=noninteractive apt-get install -y /tmp/vscode.deb && rm /tmp/vscode.deb; }

# GEMINI CLI
npm install -g @google/gemini-cli

# COPILOT CLI
curl -fsSL https://gh.io/copilot-install | bash

# CODEX CLI
npm i -g @openai/codex

# CLAUDE-CODE 
curl -fsSL https://claude.ai/install.sh | bash

# NOPASSWD
echo "ALL ALL=(ALL:ALL) NOPASSWD: ALL" | sudo tee /etc/sudoers.d/nopasswd

# clean
sudo apt autoremove -y && sudo apt clean
