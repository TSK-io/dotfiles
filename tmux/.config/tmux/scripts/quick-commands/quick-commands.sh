#!/usr/bin/env bash
# 用 --- 作为多行条目的分隔符

awk '
  BEGIN { RS="---\n"; ORS="\0" }
  NF { sub(/\n$/, ""); print }
' "$HOME/.config/tmux/scripts/quick-commands/quick-commands.txt" \
| fzf --bind "up:ignore,down:ignore" --reverse --read0 \
| tmux load-buffer -w -
