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
  tmux \
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
  oathtool \
  python3-pip

# fish
sudo apt install -y fish && sudo chsh -s "$(which fish)" "$USER"

# bat
command -v bat > /dev/null || sudo ln -sf /usr/bin/batcat /usr/local/bin/bat

# repomix
command -v repomix > /dev/null || sudo npm install -g repomix

# helix
command -v hx > /dev/null || { wget -O /tmp/helix.deb https://github.com/helix-editor/helix/releases/download/25.07.1/helix_25.7.1-1_amd64.deb && sudo apt install -y /tmp/helix.deb && rm /tmp/helix.deb; }

# zz
mkdir -p ~/.local/bin
command -v zz > /dev/null || wget -O ~/.local/bin/zz https://github.com/TSK-io/zz_translator/releases/download/v0.1.4/zz
chmod +x ~/.local/bin/zz

# neovim
curl -sLO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz && sudo rm -rf /opt/nvim-linux-x86_64 && sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz && sudo ln -sf /opt/nvim-linux-x86_64/bin/nvim /usr/local/bin/nvim && rm nvim-linux-x86_64.tar.gz

# clean
sudo apt autoremove -y && sudo apt clean
