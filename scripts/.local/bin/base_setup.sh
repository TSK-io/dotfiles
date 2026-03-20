#!/bin/bash

# zz
mkdir -p ~/.local/bin
command -v zz > /dev/null || wget -O ~/.local/bin/zz https://github.com/TSK-io/zz_translator/releases/download/v0.1.2/zz
chmod +x ~/.local/bin/zz

#!/bin/bash
# alpine
passwd
apk upgrade && apk upgrade
 
apk add sudo
adduser free514dom-alpine-wsl
echo "free514dom-alpine-wsl ALL=(ALL:ALL) ALL" > /etc/sudoers.d/free514dom-alpine-wsl

# basic-alpine
sudo apk add git curl wget unzip fzf tmux pass pass-otp stow gnupg ripgrep rclone mpv mpc psmisc yt-dlp 7zip starship eza arp-scan sshfs jq pandoc ffmpeg maven btop nodejs npm bat podman github-cli networkmanager oath-toolkit-oathtool openjdk21 py3-pip

# keyd
sudo apk add keyd
sudo ln -sf $HOME/dotfiles/keyd/default.conf /etc/keyd/
sudo keyd

# fish
sudo apk add fish shadow && sudo chsh -s "$(which fish)" "$USER"

# repomix
command -v repomix > /dev/null || sudo npm install -g repomix

# helix
sudo apk add helix helix-tree-sitter-vendor

