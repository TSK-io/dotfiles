# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this is

Personal dotfiles for a Debian Linux desktop: **fish** shell, **IceWM** window manager,
**alacritty** terminal, **vim**, **fcitx5** (Chinese input), and **starship** prompt.
There is no build step and no test suite — "running" this repo means deploying config
symlinks with GNU Stow and bootstrapping a machine with the setup scripts. Most config
comments and the `docs/` content are written in Chinese.

## GNU Stow layout (the core concept)

Each top-level directory is a **Stow package**, and the path *inside* it mirrors the
deploy location relative to `$HOME`. Examples:

- `fish/.config/fish/config.fish` → `~/.config/fish/config.fish`
- `vim/.vimrc` → `~/.vimrc`
- `scripts/.local/bin/base_setup.sh` → `~/.local/bin/base_setup.sh`

Packages: `alacritty`, `fcitx5`, `fish`, `git`, `gnupg`, `icewm`, `scripts`, `starship`, `vim`.

Deploy a package by running stow **from the repo root**:

```bash
stow fish          # symlink one package into $HOME
stow */            # symlink every package
stow -D fish       # remove a package's symlinks
stow -R fish       # restow (after adding/moving files)
```

**This repo must live at `~/dotfiles`.** Stow's default target is the *parent* of the
stow directory, so running stow from `~/dotfiles` targets `~`. Implications when editing:

- To add a new config file, create it at `<package>/<path-relative-to-$HOME>`, then
  `stow -R <package>`. Do **not** place files at the repo root.
- Deployed files are symlinks back into this repo, so editing `~/.config/...` and editing
  the repo source are the same inode. When working here, edit the repo copy directly.

## Bootstrapping a machine

Two idempotent scripts under `scripts/.local/bin/` install everything via `apt`, npm, and
upstream install scripts. Run `base_setup.sh` first, then `extend_setup.sh`, then stow the
packages:

- **`base_setup.sh`** — CLI base: git, fish (sets it as login shell), vim + fzf, stow,
  ripgrep, eza, bat, starship, pass/pass-otp, repomix, the `zz` translator, etc.
- **`extend_setup.sh`** — desktop layer: Xorg + lightdm + IceWM + rofi, fcitx5, alacritty
  (set as `x-terminal-emulator`), v2rayA, zen-browser, VS Code, and several AI CLIs
  (Antigravity, Copilot, Codex, Claude Code). **Heads-up:** it also writes
  `/etc/sudoers.d/nopasswd` granting passwordless sudo to all users.

## Commit & publish conventions

- Commits are made through the fish `gg` alias: `git add . && git commit -m "update" &&
  git pull --rebase && git push`. This is why the history is a flat stream of "update"
  commits — match that unless asked otherwise.
- Commits are **SSH-signed** (`commit.gpgsign = true`, key in `~/.ssh/`); git identity is
  configured in `git/.config/git/config`, not the global default.
- `docs/` is published as-is to GitHub Pages at <https://tsk-io.github.io/dotfiles/>
  (no Jekyll/mkdocs config — plain Markdown). `docs/install.md` holds Debian recovery
  notes (network, Broadcom Wi-Fi, FaceTime HD, hybrid-MBR dual-boot fixes).

## Local-only and untracked

- `.gitignore` keeps machine-specific and secret state out of the repo. Notably,
  `fish/.config/fish/config.fish` **sources `~/.config/fish/secrets.fish` first** — that
  file is gitignored and holds per-machine secrets/proxy/env. Put anything sensitive or
  machine-specific there, never in `config.fish`.
- The AI-CLI config dirs `.claude/`, `.codex/`, `.antigravitycli/` exist locally but are
  gitignored. So are GPG private keys, fish history/variables, and several fetched binaries
  under `scripts/.local/bin/` (eza, bat, zen, etc.).
- `.github-kisu` is an encrypted binary blob — do not attempt to read, decode, or edit it.
