#!/bin/bash

# debian
passwd
apt update && apt upgrade -y

apt install -y sudo
adduser free514dom-debian-wsl
echo "free514dom-debian-wsl ALL=(ALL:ALL) ALL" > /etc/sudoers.d/free514dom-debian-wsl

# basic-debian
JAVA_PACKAGE=default-jdk
apt-cache show openjdk-21-jdk > /dev/null 2>&1 && JAVA_PACKAGE=openjdk-21-jdk
sudo apt install -y git curl wget unzip fzf tmux pass pass-otp stow gnupg ripgrep rclone mpv mpc psmisc yt-dlp 7zip starship eza arp-scan sshfs jq pandoc ffmpeg maven btop nodejs npm bat podman gh network-manager oathtool "$JAVA_PACKAGE" python3-pip dbus-user-session uidmap slirp4netns systemd systemd-sysv

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
