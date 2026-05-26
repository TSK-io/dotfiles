#!/usr/bin/env bash
# Super+n: 全屏截图 -> 交给 Claude Code CLI 看图 -> 一句话白话讲解弹通知。
# 取代旧的 screenshot-to-aistudio.sh:不再开浏览器、不再 xdotool 模拟粘贴/提交。
# 依赖: flameshot, claude(Claude Code CLI), libnotify-bin(notify-send)+dunst, xclip(可选)。
set -u
export PATH="$HOME/.local/bin:$PATH"           # 从 IceWM 键位启动时确保能找到 claude

PROMPT="${PROMPT:-总结(一句话)}"    # ← 想换提示词改这里或用环境变量
MODEL="${MODEL:-sonnet}"                          # 看图够用且快;想更准改 sonnet

# 临时文件:截图 + 错误输出,退出时统一清理
IMG="$(mktemp --suffix=.png)"
ERR="$(mktemp)"
trap 'rm -f "$IMG" "$ERR"' EXIT

# 1) 全屏截图存临时文件(想框选区域就把 full 换成 gui)
flameshot full --raw > "$IMG" || { notify-send -u critical "🐳 看图失败" "截图(flameshot)失败"; exit 1; }

# 2) 交给 Claude 看图,只给它 Read 工具,拿回纯文本答案
ANS="$(claude -p "$PROMPT。图片:$IMG" --allowedTools Read --model "$MODEL" </dev/null 2>"$ERR")"
rc=$?

# 3) 弹通知(答案很短正好);成功时顺手塞进剪贴板方便粘贴
if [ "$rc" -eq 0 ] && [ -n "$ANS" ]; then
    printf '%s' "$ANS" | xclip -selection clipboard -in 2>/dev/null
    notify-send -t 20000 "🐳 看图说话" "$ANS"
else
    notify-send -u critical "🐳 看图失败" "${ANS:-$(tail -n1 "$ERR")} (退出码 $rc)"
    exit 1
fi
