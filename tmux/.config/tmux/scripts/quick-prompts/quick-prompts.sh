#!/usr/bin/env bash

file="$HOME/.config/tmux/scripts/quick-prompts/quick-prompts.txt"

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
} | fzf --read0 --reverse \
  | tmux load-buffer -w -
