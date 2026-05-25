#!/usr/bin/env bash
# Super+z: 全屏截图 -> 打开 AI Studio -> 粘贴图片 -> 粘贴固定提示词。
# 依赖: flameshot, xclip, xdotool, 以及注册了 xdg-open 的浏览器。
set -u

URL="https://aistudio.google.com"
PROMPT="极短的通俗的一句白话讲解"   # ← 想换提示词只改这一行

# 可调参数（若粘贴过早/落点不对就改这几个，可用环境变量临时覆盖）
LOAD_WAIT="${LOAD_WAIT:-3.0}"   # 等页面加载的秒数
PASTE_GAP="${PASTE_GAP:-0.8}"   # 图片粘贴与文本粘贴之间的间隔
SUBMIT_GAP="${SUBMIT_GAP:-0.5}" # 粘完文本到按 Ctrl+Enter 提交的间隔

# 1) 全屏截图直接进剪贴板
flameshot full -c || exit 1

# 2) 打开 AI Studio（默认浏览器新标签）
xdg-open "$URL" >/dev/null 2>&1 &

# 3) 等加载，并把浏览器窗口提到前台
sleep "$LOAD_WAIT"
win=$(xdotool search --onlyvisible --name "AI Studio" 2>/dev/null | tail -1)
[ -z "$win" ] && win=$(xdotool getactivewindow)
xdotool windowactivate --sync "$win" 2>/dev/null

# 4) 点击输入框聚焦（默认取屏幕底部中央，AI Studio 输入框常在此），再粘贴图片
read -r W H < <(xdotool getdisplaygeometry)
CX="${CLICK_X:-$((W/2))}"
CY="${CLICK_Y:-$((H*9/10))}"
xdotool mousemove "$CX" "$CY" click 1
sleep 0.3
xdotool key --clearmodifiers ctrl+v        # 粘贴图片

# 5) 把固定文本换上剪贴板，再粘贴文本
sleep "$PASTE_GAP"
printf '%s' "$PROMPT" | xclip -selection clipboard -in
xdotool key --clearmodifiers ctrl+v        # 粘贴文本

# 6) 一切就绪后提交
sleep "$SUBMIT_GAP"
xdotool key --clearmodifiers ctrl+Return   # Ctrl+Enter 提交
