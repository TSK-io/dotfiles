# dotfiles

Personal dotfiles for a keyboard-first Linux workflow (mainly Debian + i3 + fish + tmux).

Website: <https://tsk-io.github.io/dotfiles/>

## What's here

- `fish/` - fish shell config (vi mode, aliases, fzf, Starship)
- `tmux/` - tmux config (vi copy mode, clipboard, fast keybindings)
- `i3/` - i3 desktop config (rofi, workspaces, screenshot helpers)
- `git/` - Git config (GitHub CLI auth, SSH signing, path display)
- `scripts/` - local scripts, including Debian setup helper
- `docs/` - personal notes/TODOs

## Quick use

This repo uses a package-style layout (example: `fish/.config/fish/config.fish`).

Link or copy only what you need into `$HOME`.

Debian helper script:

```text
scripts/.local/bin/extend_setup.sh
```

Read it before running. It installs packages, adds repos, enables services, and changes system settings.

## Common dependencies

`fish`, `tmux`, `vim`, `starship`, `fzf`, `bat`, `eza`, `git`, `gh`, `xclip`, `alacritty`, `i3`, `rofi`, `scrot`, `feh`

## Notes

These are personal preferences. Review before applying, especially:

- Git name/email/signing key
- shell aliases
- i3 keybindings
- install scripts and network/proxy-related tools

## License

No license specified yet.
