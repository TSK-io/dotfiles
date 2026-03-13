#!/bin/bash

# update && upgrade
sudo sed -i 's/ main / main contrib /g' /etc/apt/sources.list
sudo apt update && sudo apt -y upgrade

# basic-debian
sudo apt -y install git curl wget unzip network-manager fzf tmux keychain pass pass-otp oathtool stow gnupg ripgrep rclone mpv mpc psmisc yt-dlp 7zip starship eza arp-scan sshfs jq pandoc ffmpeg openjdk-21-jdk maven btop nodejs npm bat gh python3-pip podman

# rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

# pip package
pip install --user openai --break-system-packages

# keyd
sudo apt -y install keyd
sudo ln -sf $HOME/dotfiles/keyd/default.conf /etc/keyd/
sudo keyd.rvaiya reload

# fish
sudo apt -y install fish && sudo chsh -s "$(which fish)" "$USER"

# repomix
command -v repomix > /dev/null || sudo npm install -g repomix

# helix
command -v hx > /dev/null || (wget https://github.com/helix-editor/helix/releases/download/25.07.1/helix_25.7.1-1_amd64.deb && sudo apt -y install ./helix_25.7.1-1_amd64.deb && rm helix_25.7.1-1_amd64.deb)

# zz
mkdir -p ~/.local/bin
command -v zz > /dev/null || wget -O ~/.local/bin/zz https://github.com/TSK-io/zz_translator/releases/download/v0.1.2/zz
chmod +x ~/.local/bin/zz
