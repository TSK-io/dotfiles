#!/usr/bin/env bash
# Usage: quick-pick.sh <file> <prompt-label>
# Reads `---`-separated entries from <file>, lets the user pick via rofi,
# and copies the selection to the clipboard.

file="$1"
label="$2"

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
} | rofi -dmenu -i -sep '\0' -p "$label")

[ -n "$sel" ] && printf '%s' "$sel" | xclip -selection clipboard -in
