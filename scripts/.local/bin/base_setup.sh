#!/bin/bash

# debian
sudo apt update && sudo apt upgrade -y

# basic-debian
sudo apt install -y \
  git \
  curl \
  wget \
  unzip \
  fzf \
  pass \
  pass-otp \
  stow \
  gnupg \
  ripgrep \
  mpv \
  mpc \
  7zip \
  starship \
  eza \
  jq \
  pandoc \
  btop \
  nodejs \
  npm \
  bat \
  network-manager \
  sshfs \
  pwgen \
  oathtool

# vim
sudo apt install -y vim-gtk3 && mkdir -p ~/.vim/pack/min/start && [ ! -d ~/.vim/pack/min/start/fzf ] && git clone --depth 1 https://github.com/junegunn/fzf ~/.vim/pack/min/start/fzf

# fish
sudo apt install -y fish && sudo chsh -s "$(which fish)" "$USER"

# bat
command -v bat > /dev/null || sudo ln -sf /usr/bin/batcat /usr/local/bin/bat

# repomix
command -v repomix > /dev/null || sudo npm install -g repomix

# zz
mkdir -p ~/.local/bin
command -v zz > /dev/null || wget -O ~/.local/bin/zz https://github.com/TSK-io/zz_translator/releases/download/v0.1.4/zz
chmod +x ~/.local/bin/zz

# clean
sudo apt autoremove -y && sudo apt clean
