#!/bin/bash

# 1. 定义保存路径
DIR="$HOME/Pictures/Screenshots"
mkdir -p "$DIR"

# 2. 定义文件名 (时间戳)
FILENAME="$(date +%Y%m%d_%H%M%S).png"
FILEPATH="$DIR/$FILENAME"

# 3. 执行截图 (maim)
# -s: 选择区域
# -u: 隐藏光标
# 使用 if 判断：只有当截图成功生成文件后，才执行后续操作
if maim -s -u "$FILEPATH"; then
    # 4. 复制到剪贴板
    xclip -selection clipboard -t image/png -i "$FILEPATH"

    # 5. 发送系统通知
    notify-send "截图完成" "已保存文件并复制到剪贴板\n$FILEPATH"
else
    # 可选：如果取消截图（比如按了 Esc），可以在这里处理，或者什么都不做
    echo "截图已取消"
fi
