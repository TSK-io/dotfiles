#!/bin/bash
set -u
TMP_FULL="/tmp/screenshot_full_$$.png"
TMP_CROP="/tmp/screenshot_crop_$$.png"
trap 'rm -f "$TMP_FULL" "$TMP_CROP"' EXIT

if command -v magick >/dev/null; then IM="magick"; else IM="convert"; fi

# 1) 全屏截图
maim -u "$TMP_FULL" || exit 1

# 2) feh 显示冻结画面
feh --fullscreen --hide-pointer --title "i3-freezeshot" "$TMP_FULL" &
FEH_PID=$!

for _ in 1 2 3 4 5 6 7 8 9 10; do
    xdotool search --name "i3-freezeshot" >/dev/null 2>&1 && break
    sleep 0.05
done

# 3) slop 选区
COORDS=$(slop -f "%x %y %w %h")
RC=$?
kill "$FEH_PID" 2>/dev/null; wait 2>/dev/null

[ $RC -ne 0 ] || [ -z "$COORDS" ] && exit 0

read -r X Y W H <<<"$COORDS"
[ "${W:-0}" -le 0 ] || [ "${H:-0}" -le 0 ] && exit 0

# 4) 裁剪
"$IM" "$TMP_FULL" -crop "${W}x${H}+${X}+${Y}" +repage "$TMP_CROP" || exit 1
[ "$(stat -c%s "$TMP_CROP" 2>/dev/null || echo 0)" -eq 0 ] && exit 1

# 5) 复制到剪贴板
xclip -selection clipboard -t image/png -i "$TMP_CROP"
