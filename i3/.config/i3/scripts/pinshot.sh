#!/bin/bash

DIR="$HOME/Pictures/Screenshots"
mkdir -p "$DIR"

FILENAME="$(date +%Y%m%d_%H%M%S)_pin.png"
FILEPATH="$DIR/$FILENAME"

# 选择区域，输出格式：WIDTHxHEIGHT+X+Y
GEOM="$(slop -f '%g')" || exit 0

# 截图
maim -u -g "$GEOM" "$FILEPATH" || exit 1

# 复制到剪贴板
xclip -selection clipboard -t image/png -i "$FILEPATH"

# 用 feh 打开这个截图窗口；窗口标题固定为 i3-pinshot，方便 i3 匹配
feh \
  --title "i3-pinshot" \
  --borderless \
  --geometry "$GEOM" \
  --auto-zoom \
  "$FILEPATH" &

notify-send "Pin 完成" "已保存并复制到剪贴板\n$FILEPATH"
