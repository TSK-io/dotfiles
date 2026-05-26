# 代码审查 / Code Review

> **范围**：整个 dotfiles 仓库（setup 脚本、fish 配置、IceWM 脚本与配置、各工具配置文件）
> **日期**：2026-05-26 · **目标系统**：Debian 13 (trixie) + IceWM + fish
> **排除**：`fish/.config/fish/completions/grok.fish`（`grok completions fish` 自动生成，不审查）；
> `.github-kisu`（加密二进制 blob）

## 摘要

这是一个用 GNU Stow 管理的个人 dotfiles 仓库，没有构建/测试流程，"代码"主要是
Shell 脚本和配置。整体质量不错：**没有在被跟踪文件里发现任何硬编码密钥/令牌**，
`secrets.fish`、GPG 私钥、fish 历史等敏感内容都已正确 `.gitignore`。

需要关注的问题集中在两类：**(1) 安装脚本的安全姿态**（全局免密 sudo、未校验的
`curl|bash`），**(2) 脚本健壮性与可移植性**（缺少 `set -euo pipefail`、硬编码
`/home/tsk`、被提交的备份文件）。下面按严重程度排列。

---

## 🔴 高 — 安全

### S1. `extend_setup.sh:58` 给所有用户开启全局免密 sudo

```bash
echo "ALL ALL=(ALL:ALL) NOPASSWD: ALL" | sudo tee /etc/sudoers.d/nopasswd
```

这会让**系统上每一个用户**无需密码即可执行任意 root 命令。一旦任意一个账户
（或一个被攻陷的进程/脚本）拿到普通用户权限，就等于直接拿到 root，sudo 的口令
屏障形同虚设。

**改进**：
- 至少限定到当前用户而非 `ALL`：`echo "$USER ALL=(ALL) NOPASSWD: ALL"`；
- 更好的做法是只对少数明确命令免密（例如 `apt`、`systemctl`），其余仍需口令；
- 写入后用 `sudo visudo -cf /etc/apt/.../nopasswd`（或 `visudo -c`）校验语法，
  并 `chmod 0440`，避免一行写坏导致 sudo 整体不可用。

### S2. 多处未校验的 `curl … | bash` / 远程二进制安装

`extend_setup.sh` 直接把远程脚本管道给 shell 执行，且无任何校验：

| 行 | 来源 |
|----|------|
| 40 | `curl … github.com/zen-browser/…/install.sh \| bash` |
| 46 | `curl -fsSL https://antigravity.google/cli/install.sh \| bash` |
| 49 | `curl -fsSL https://gh.io/copilot-install \| bash` |
| 55 | `curl -fsSL https://claude.ai/install.sh \| bash` |

`base_setup.sh:48` 下载 `zz` 二进制同样无校验：

```bash
command -v zz > /dev/null || wget -O ~/.local/bin/zz https://github.com/TSK-io/zz_translator/releases/download/v0.1.4/zz
chmod +x ~/.local/bin/zz
```

风险：上游或传输被篡改时会以你的权限执行任意代码；没有 checksum/签名校验，无法
发现下载到的是错误内容或 HTTP 错误页。

**改进**：
- 对可固定版本的下载（如 `zz`）记录并校验 `sha256sum`，校验通过再 `chmod +x`；
- 对 `curl|bash`，尽量先 `curl -fsSL … -o /tmp/x.sh`，**人工/diff 审阅后**再执行，
  或固定到具体 commit/tag；
- 在这些命令前加 `set -o pipefail`（见 C1），否则 `curl` 失败而 `bash` 成功时整条
  管道仍返回 0，错误被吞掉。

---

## 🟡 中 — 正确性 / 健壮性

### C1. 两个 setup 脚本都缺少 `set -euo pipefail`

`base_setup.sh` 与 `extend_setup.sh` 顶部只有 `#!/bin/bash`，没有任何 `set`。
后果：任何一步失败（apt 装包失败、下载失败、网络问题）脚本都会**继续往下跑**，
最终可能留下一个"装了一半"的系统，且退出码为 0，让人误以为成功。

**改进**：在两个脚本顶部加

```bash
set -euo pipefail
```

注意：加了 `set -e` 后，需要同时修掉 C2/C3 里那些"正常情况下也会返回非 0"的行，
否则脚本会提前退出。

### C2. `base_setup.sh:35` 的 vim/fzf 一行式在重复运行时返回非 0

```bash
sudo apt install -y vim-gtk3 && mkdir -p ~/.vim/pack/min/start \
  && [ ! -d ~/.vim/pack/min/start/fzf ] && git clone --depth 1 … fzf
```

当 `fzf` 目录已存在（第二次运行）时，`[ ! -d … ]` 为假 → 整条 `&&` 链以非 0
结束。当前没有 `set -e` 所以无害，但一旦按 C1 加上 `set -e`，重复运行就会在这里
中断。建议拆成显式 `if`：

```bash
sudo apt install -y vim-gtk3
mkdir -p ~/.vim/pack/min/start
if [ ! -d ~/.vim/pack/min/start/fzf ]; then
  git clone --depth 1 https://github.com/junegunn/fzf ~/.vim/pack/min/start/fzf
fi
```

### C3. `base_setup.sh:47-49` 的 `zz` 安装：chmod 无条件执行、无错误处理

```bash
command -v zz > /dev/null || wget -O ~/.local/bin/zz https://…/zz
chmod +x ~/.local/bin/zz
```

问题：
- 若系统里**已有** `zz`（但不在 `~/.local/bin/zz`），`wget` 被跳过，但
  `chmod +x ~/.local/bin/zz` 仍会执行 → 对不存在的文件报错；
- `wget` 失败（404 / 网络错误 / 写出错误页）时不会中断，却仍给文件加可执行位。

**改进**：把下载与赋权放进同一个条件块，并校验：

```bash
if ! command -v zz > /dev/null; then
  wget -O ~/.local/bin/zz https://github.com/TSK-io/zz_translator/releases/download/v0.1.4/zz
  # echo "<已知 sha256>  $HOME/.local/bin/zz" | sha256sum -c -   # 建议加校验
  chmod +x ~/.local/bin/zz
fi
```

### C4. `screenshot-to-aistudio.sh` 用 `sleep` 驱动 UI 自动化，且会覆盖剪贴板 ✅ 已处理

脚本依赖固定 `sleep`（页面加载 3s、粘贴间隔等）来对准浏览器输入框，属于
**时序竞态**：页面慢一点、窗口没聚焦、输入框位置变化都会失败或把内容粘到错误位置。
它还会先截图进剪贴板、再用提示词文本**覆盖**剪贴板（用户原有剪贴板内容丢失）。

这是个人自动化脚本、注释里也说明了可调参数，严重度低。可考虑：用 `xdotool search
--sync` 等待窗口而非固定 sleep；结束时恢复剪贴板原值。脚本已正确使用 `set -u` 和
`flameshot … || exit 1`，这点很好。

**已处理（2026-05-26）：** 新增 `screenshot-to-claude.sh`，改用 Claude Code CLI
（`flameshot full --raw` → `claude -p … --allowedTools Read` → `notify-send`）。
**整条 GUI 自动化链路（开浏览器 / `sleep` / `xdotool` 点坐标粘贴提交）被结构性删除**，
时序竞态随之消失；剪贴板也不再先被截图覆盖，只在最后写入一次答案文本。`Super+n`
已指向新脚本；旧脚本 `screenshot-to-aistudio.sh` 及其专属依赖 `xdotool`
（`base_setup.sh` 安装项与系统中）已一并清理，如需回退见 git 历史。

---

## 🟢 低 — 可维护性 / 风格

### M1. 仓库提交了过期的备份文件 `config.fish.bak.1779753142`

`fish/.config/fish/config.fish.bak.*` 被 git 跟踪。它与当前 `config.fish` 仅差末尾
的 grok installer 块（即已经**过期**）。备份文件不应进版本库（git 本身就是历史）。

**改进**：`git rm fish/.config/fish/config.fish.bak.1779753142`，并在 `.gitignore`
增加一行 `*.bak.*`（或 `*.bak`）防止再次误提交。

### M2. `config.fish` 里混入了机器相关、由安装器追加的内容

```fish
# config.fish:66
set -gx PATH "/home/tsk/.local/bin" $PATH          # Antigravity 安装器追加
# config.fish:68-70
fish_add_path $HOME/.grok/bin                        # grok 安装器追加
```

两个问题：
- **硬编码 `/home/tsk`**：换用户/机器即失效，违背"同一份 dotfiles 多机复用"的初衷；
- **重复 PATH**：`$HOME/.local/bin` 在 `config.fish:40` 已用 `fish_add_path` 加过，
  这里再 `set -gx PATH …` 前置一次，且 `set -gx` **不去重**，每开一个新 shell 就把
  它再压一遍，PATH 里会越积越多重复项。

这类安装器追加块、机器专属设置，更适合放进 gitignore 的 `secrets.fish` 或
`conf.d/` 局部文件里，而不是提交进共享的 `config.fish`。**改进**：删掉 66 行
（已被 40 行覆盖），grok 路径若要保留可改 `fish_add_path $HOME/.grok/bin`。

### M3. `config.fish:36` 每次启动都向 universal 变量追加

```fish
set -Ua fish_features no-keyboard-protocols
```

`-U`（universal）会持久化进 `fish_variables`，放在 `config.fish` 里意味着**每开一个
交互 shell 都执行一次**，`-a`（append）又不去重，长期可能累积重复值。`fish_features`
只需设置一次。**改进**：要么交互式执行一次后从 `config.fish` 删除；要么加判断：

```fish
contains no-keyboard-protocols $fish_features; or set -Ua fish_features no-keyboard-protocols
```

### M4. `gg` 别名：盲目 `git add .` + 固定 "update" 提交信息 + 立即推送

```fish
alias gg 'git add . && git commit -m "update" && git pull --rebase && git push'
```

`git add .` 会把当前目录下**所有**改动一次性暂存（包括误建的临时文件），提交信息恒为
"update"（这也是本仓库 git 历史全是 "update" 的原因），且不留人工复核窗口就直接
推送。日常方便，但容易误提交、历史也不可读。**改进（可选）**：保留快捷但接受
偶尔写有意义的信息；或至少在 `gg` 里只对仓库根 `git -C ~/dotfiles add -A` 以避免
在子目录误暂存无关内容。

### M5. 文档缺少"如何部署这套 dotfiles"的说明

`README.md` 只有一行链接，`docs/install.md` 是 Debian 恢复/驱动笔记，跟本仓库的
**使用方式**无关。新机器上"`git clone` 到 `~/dotfiles` → 跑 setup 脚本 → `stow <pkg>`"
这个核心流程没有任何用户文档（已在 `CLAUDE.md` 记录，但面向用户的 README 仍缺）。
**改进**：在 README 或 `docs/` 增加简短的部署步骤。

### M6. `starship.toml` 的两个 OS 符号疑似拼写错误（纯外观）

`Arch = "rch "`（疑似漏了首字母 `a`）、`EndeavourOS = "ndev "`。其余符号如
`Debian="deb "`、`Macos="mac "` 都正常。若并非有意为之，建议改为 `arch `/`endev `。
纯显示问题，最低优先级。

---

## ✅ 审查通过（无需改动）

- **无密钥泄露**：被跟踪文件中未发现 API key / token / 私钥；`secrets.fish`、GPG 私钥、
  `fish_history`、`fish_variables` 均已正确 gitignore。
- `config.fish` 先 `source secrets.fish` 的设计合理，是机器专属配置的正确落点。
- `git/.config/git/config`：SSH 提交签名（`gpg.format=ssh` + `commit.gpgsign`）配置正确。
- `vim/.vimrc`、`alacritty.toml`、`gpg-agent.conf`、`fcitx5` 配置：简洁、无明显问题。
- `quick-pick.sh`：使用了正确的 `#!/usr/bin/env bash`、NUL 分隔与 rofi 配合得当；
  提示词已内联进脚本（`---` 分隔的 heredoc），不再依赖外部文件与 `$1`/`$2` 参数。

---

## 改进措施清单（按优先级）

- [ ] **S1** 收紧 `nopasswd` sudoers：限定到当前用户或具体命令，写入后 `visudo -c` 校验。
- [ ] **S2** 对 `zz` 下载加 sha256 校验；`curl|bash` 改为先下载审阅再执行或固定版本。
- [ ] **C1** 两个 setup 脚本顶部加 `set -euo pipefail`（并配合修 C2/C3）。
- [ ] **C2/C3** 把 vim-fzf、`zz` 安装改写成显式 `if` 块，保证可重复运行不报错。
- [ ] **M1** `git rm` 删除 `config.fish.bak.*`，`.gitignore` 加 `*.bak*`。
- [ ] **M2** 删除 `config.fish:66` 硬编码 PATH，机器专属内容移入 `secrets.fish`。
- [ ] **M3** `fish_features` 改为带判断或一次性设置。
- [ ] **M4/M5/M6** 视需要处理（习惯/文档/外观，非必须）。
