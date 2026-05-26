#!/usr/bin/env bash
# Super+n: 全屏截图 -> 交给 Claude Code CLI 看图 -> 一句话白话讲解弹通知。
# 取代旧的 screenshot-to-aistudio.sh:不再开浏览器、不再 xdotool 模拟粘贴/提交。
# 依赖: flameshot, claude(Claude Code CLI), libnotify-bin(notify-send)+dunst, xclip(可选)。
set -u
export PATH="$HOME/.local/bin:$PATH"           # 从 IceWM 键位启动时确保能找到 claude

PROMPT="${PROMPT:-通俗的白话讲解,稍微详细一些}"    # ← 想换提示词改这里或用环境变量
MODEL="${MODEL:-sonnet}"                          # 看图够用且快;想更准改 sonnet

# 临时文件:截图 + 错误输出,退出时统一清理
IMG="$(mktemp --suffix=.png)"
ERR="$(mktemp)"
trap 'rm -f "$IMG" "$ERR"' EXIT

# 把要塞进通知的文本做 Pango 转义:dunst 的 markup=full 下,正文里出现 < > &
# 会被当成标记、解析失败 → 正文从那里起被截断(日志里见过 Unable to parse markup)。
# 注意先转义 & 再转义 < >。剪贴板存原文,不经过这里。
pango_escape() { local s=$1; s=${s//&/&amp;}; s=${s//</&lt;}; s=${s//>/&gt;}; printf '%s' "$s"; }

# 1) 全屏截图存临时文件(想框选区域就把 full 换成 gui)
flameshot full --raw > "$IMG" || { notify-send -u critical "🐳 看图失败" "截图(flameshot)失败"; exit 1; }

# 2) 交给 Claude 看图,只给它 Read 工具,拿回纯文本答案
ANS="$(claude -p "$PROMPT。图片:$IMG" --allowedTools Read --model "$MODEL" </dev/null 2>"$ERR")"
rc=$?

# 3) 弹通知(显示时间和内容都加长,读起来更舒服);成功时顺手塞进剪贴板方便粘贴
if [ "$rc" -eq 0 ] && [ -n "$ANS" ]; then
    printf '%s' "$ANS" | xclip -selection clipboard -in 2>/dev/null
    notify-send -t 60000 "🐳 看图说话" "$(pango_escape "$ANS")"
else
    notify-send -u critical "🐳 看图失败" "$(pango_escape "${ANS:-$(tail -n1 "$ERR")}") (退出码 $rc)"
    exit 1
fi
