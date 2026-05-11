# dotfiles

Personal dotfiles for a keyboard-driven Linux desktop and terminal workflow.

Website: <https://tsk-io.github.io/dotfiles/>

## Overview

This repository collects configuration files and helper scripts for my daily development environment. The setup is centered around Debian/Linux, i3, fish, tmux, Git, and a small set of command-line tools.

The goal is not to provide a universal dotfiles framework. It is a practical, personal environment that can be cloned, inspected, reused, and gradually adapted.

## What is included

- `fish/` — fish shell configuration with vi key bindings, clipboard-aware editing, fzf integration, useful aliases, custom paths, and Starship initialization.
- `tmux/` — tmux configuration with vi-style copy mode, clipboard integration, fast window/pane shortcuts, and popup-based quick prompt/command pickers.
- `i3/` — i3 window manager configuration for a minimal keyboard-driven desktop, including rofi launcher bindings, workspace shortcuts, screenshots, and pin-shot helpers.
- `git/` — Git configuration for GitHub CLI credentials, SSH commit signing, and better path display.
- `scripts/` — local helper scripts, including a Debian desktop extension setup script.
- `docs/` — personal notes and TODO items.

## Desktop stack

The desktop configuration is designed around:

- Debian-based systems
- Xorg
- LightDM
- i3
- rofi
- alacritty
- tmux
- fcitx5
- dunst
- scrot, xclip, and feh for screenshots and pinned screen snippets

The i3 setup uses `Mod4` as the main modifier key, launches `alacritty` into a persistent tmux session, and keeps the UI minimal with thin borders and a hidden status bar.

## Terminal workflow

The terminal workflow is built around fish and tmux.

fish provides:

- vi key bindings
- clipboard-aware yank and paste behavior
- fzf key bindings
- `bat` as a `cat` replacement
- `eza` aliases for file listing
- Starship prompt initialization

tmux provides:

- vi-style copy mode
- clipboard copy through `xclip`
- quick new-window, kill-pane, and window navigation shortcuts
- popup pickers for reusable prompts and commands powered by `fzf`

## Setup notes

This repository follows a package-style dotfiles layout, for example:

```text
fish/.config/fish/config.fish
tmux/.config/tmux/tmux.conf
i3/.config/i3/config
git/.config/git/config
scripts/.local/bin/extend_setup.sh
```

You can symlink or copy the relevant directories into `$HOME` depending on your preferred dotfiles workflow.

A Debian-oriented helper script is available at:

```text
scripts/.local/bin/extend_setup.sh
```

It installs the desktop stack and several daily-use applications. Read the script before running it, because it installs packages, adds third-party repositories, enables services, and changes system-level settings.

## Dependencies

Some configuration files assume the following tools are installed:

- `fish`
- `tmux`
- `vim`
- `starship`
- `fzf`
- `bat`
- `eza`
- `git`
- `gh`
- `xclip`
- `alacritty`
- `i3`
- `rofi`
- `scrot`
- `feh`

The extended desktop setup script installs many of these on Debian-based systems.

## Notes

These dotfiles contain personal preferences, aliases, key bindings, and Git identity settings. Review the files before applying them directly to your own machine.

In particular, check:

- Git user name, email, and signing key
- shell aliases
- i3 key bindings
- scripts that install packages or enable services
- proxy/network related tools installed by the setup script

## License

No license has been specified yet.
