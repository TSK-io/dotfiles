#!/bin/bash
set -u
LOG="/tmp/screenshot_debug.log"
exec 2>>"$LOG"
echo "=== $(date) ===" >>"$LOG"

TMP_FULL="/tmp/screenshot_full_$$.png"
TMP_CROP="/tmp/screenshot_crop_$$.png"
trap 'rm -f "$TMP_FULL" "$TMP_CROP"' EXIT

# ImageMagick 7 用 magick,6 用 convert
if command -v magick >/dev/null; then IM="magick"; else IM="convert"; fi
echo "IM=$IM" >>"$LOG"

# 1) 全屏截图(此刻菜单/tooltip 还在)
if ! maim -u "$TMP_FULL"; then
    notify-send "截图失败" "maim 全屏失败"; exit 1
fi
echo "tmp=$(stat -c%s "$TMP_FULL") bytes" >>"$LOG"

# 2) feh 全屏显示这张图当"冻结画面"
feh --fullscreen --hide-pointer --title "i3-freezeshot" "$TMP_FULL" &
FEH_PID=$!

# 等 feh 窗口真出现,最多 500ms
for _ in 1 2 3 4 5 6 7 8 9 10; do
    xdotool search --name "i3-freezeshot" >/dev/null 2>&1 && break
    sleep 0.05
done
echo "feh up, pid=$FEH_PID" >>"$LOG"

# 3) 在静态图上 slop 选区
COORDS=$(slop -f "%x %y %w %h")
RC=$?
echo "slop rc=$RC coords='$COORDS'" >>"$LOG"

kill "$FEH_PID" 2>/dev/null; wait 2>/dev/null

if [ $RC -ne 0 ] || [ -z "$COORDS" ]; then
    notify-send "截图取消" "slop rc=$RC"; exit 0
fi
read -r X Y W H <<<"$COORDS"
if [ "${W:-0}" -le 0 ] || [ "${H:-0}" -le 0 ]; then
    notify-send "截图取消" "选区为空 ${W}x${H}"; exit 0
fi

# 4) 裁剪到临时文件
"$IM" "$TMP_FULL" -crop "${W}x${H}+${X}+${Y}" +repage "$TMP_CROP"
RC=$?
SIZE=$(stat -c%s "$TMP_CROP" 2>/dev/null || echo 0)
echo "crop rc=$RC size=$SIZE" >>"$LOG"

if [ $RC -ne 0 ] || [ "$SIZE" -eq 0 ]; then
    notify-send "截图失败" "$IM 裁剪失败,看 $LOG"; exit 1
fi

# 5) 复制到剪贴板（trap 会清理临时文件）
xclip -selection clipboard -t image/png -i "$TMP_CROP"
echo "done" >>"$LOG"
notify-send "截图完成" "已复制到剪贴板"
