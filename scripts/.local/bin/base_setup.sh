#!/bin/bash

# debian
apt update && apt upgrade -y

# basic-debian
sudo apt install -y git curl wget unzip fzf tmux pass pass-otp stow gnupg ripgrep rclone mpv mpc psmisc yt-dlp 7zip starship eza arp-scan sshfs jq pandoc ffmpeg maven btop nodejs npm bat podman gh network-manager oathtool python3-pip dbus-user-session uidmap slirp4netns systemd systemd-sysv

# fish
sudo apt install -y fish && sudo chsh -s "$(which fish)" "$USER"
command -v bat > /dev/null || sudo ln -sf /usr/bin/batcat /usr/local/bin/bat

# repomix
command -v repomix > /dev/null || sudo npm install -g repomix

# helix
sudo apt install -y hx

# zz
mkdir -p ~/.local/bin
command -v zz > /dev/null || wget -O ~/.local/bin/zz https://github.com/TSK-io/zz_translator/releases/download/v0.1.4/zz
chmod +x ~/.local/bin/zz
