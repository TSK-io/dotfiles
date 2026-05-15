#!/usr/bin/env bash

file="$HOME/.config/rofi/scripts/quick-commands.txt"

sel=$({
  item=''
  while IFS= read -r line || [ -n "$line" ]; do
    if [ "$line" = '---' ]; then
      [ -n "${item//[$' \t\r\n']}" ] && printf '%s\0' "${item%$'\n'}"
      item=''
    else
      item+="$line"$'\n'
    fi
  done < "$file"
  [ -n "${item//[$' \t\r\n']}" ] && printf '%s\0' "${item%$'\n'}"
} | rofi -dmenu -i -sep '\0' -p commands)

[ -n "$sel" ] && printf '%s' "$sel" | xclip -selection clipboard -in
