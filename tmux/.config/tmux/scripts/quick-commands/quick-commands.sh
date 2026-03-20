#!/usr/bin/env bash

file="$HOME/.config/tmux/scripts/quick-commands/quick-commands.txt"

{
  item=''

  while IFS= read -r line || [ -n "$line" ]; do
    if [ "$line" = '---' ]; then
      if [ -n "${item//[$' \t\r\n']}" ]; then
        printf '%s\0' "${item%$'\n'}"
      fi
      item=''
    else
      item+="$line"$'\n'
    fi
  done < "$file"

  if [ -n "${item//[$' \t\r\n']}" ]; then
    printf '%s\0' "${item%$'\n'}"
  fi
} | fzf --bind "up:ignore,down:ignore" --reverse --read0 \
  | tmux load-buffer -w -
