# dotfiles

个人 Linux (Debian) 环境的配置文件集合，采用 [GNU Stow](https://www.gnu.org/software/stow/) 风格的目录结构进行管理。

## 结构

每个顶层目录是一个独立的 stow 包，内部按照其在 `$HOME` 中的真实路径组织（多数为 `.config/<app>`）：

| 目录 | 说明 |
| --- | --- |
| `fish` | Fish shell 配置（`config.fish`、函数、补全等） |
| `git` | Git 配置与签名设置 |
| `starship` | Starship 提示符配置 |
| `kitty` | Kitty 终端配置 |
| `vim` | Vim 配置 |
| `icewm` | IceWM 窗口管理器配置 |
| `dunst` | Dunst 通知守护进程配置 |
| `fcitx5` | Fcitx5 输入法配置 |
| `gnupg` | GnuPG 配置（私钥等敏感文件已在 `.gitignore` 中排除） |
| `scripts` | 放置于 `~/.local/bin` 的脚本与工具 |
| `docs` | 安装与恢复笔记（详见 `docs/`） |

## 使用

安装某个包，在仓库根目录执行：

```bash
stow fish        # 将 fish/ 下的文件软链接到 $HOME
```

安装全部：

```bash
stow */
```

卸载：

```bash
stow -D fish
```

## 文档

- [`docs/install.md`](docs/install.md) — Debian 安装、网络与驱动恢复笔记
- [`docs/`](docs/) — 其他说明与配置档案

## 许可

释放至公有领域。详见 [LICENSE](LICENSE)。
