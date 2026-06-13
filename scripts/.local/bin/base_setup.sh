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
  molly-guard \
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

# caln
command -v caln > /dev/null || { wget -O /tmp/caln.deb "https://github.com/TSK-io/calendar-cli/releases/download/v0.1.8/caln_0.1.8_amd64.deb" && sudo apt install -y /tmp/caln.deb && rm /tmp/caln.deb; }

# clean
sudo apt autoremove -y && sudo apt clean
