# dotfiles

Personal configuration files for a Debian/Linux setup, managed with [GNU Stow](https://www.gnu.org/software/stow/).

## Contents

| Directory    | Configuration                                  |
| ------------ | ---------------------------------------------- |
| `fish`       | Fish shell                                     |
| `starship`   | Starship prompt                                |
| `kitty`      | Kitty terminal                                 |
| `vim`        | Vim editor                                     |
| `git`        | Git                                            |
| `gnupg`      | GnuPG                                          |
| `icewm`      | IceWM window manager                           |
| `dunst`      | Dunst notification daemon                      |
| `fcitx5`     | Fcitx5 input method                            |
| `scripts`    | Personal scripts (`~/.local/bin`)              |
| `docs`       | Notes and install guides                       |

## Usage

Each top-level directory is a Stow package whose layout mirrors `$HOME`.
Clone the repo into your home directory and symlink a package with `stow`:

```bash
git clone https://github.com/TSK-io/dotfiles.git ~/dotfiles
cd ~/dotfiles
stow fish        # link a single package
stow */          # or link everything
```

Remove a package with `stow -D <package>`.

## Documentation

See [`docs/`](docs) for setup notes, including [install guides](docs/install.md).

## License

Released into the public domain. See [LICENSE](LICENSE).
