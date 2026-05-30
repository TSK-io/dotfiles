import datetime
import re
import sys
import os

# 获取今天的日期，格式为 YYYY-MM-DD
# 注意：GitHub Actions 默认时区是 UTC，如果你需要北京时间（UTC+8），可以加上时差
# tz = datetime.timezone(datetime.timedelta(hours=8))
# today = datetime.datetime.now(tz).strftime("%Y-%m-%d")
today = datetime.date.today().strftime("%Y-%m-%d")

events = []
file_path = "events.md"

if not os.path.exists(file_path):
    print("没有找到 events.md 文件")
    sys.exit(0)

with open(file_path, "r", encoding="utf-8") as f:
    for line in f:
        # 正则匹配形如 "- 2026-05-30: 事件内容" 的行
        match = re.match(rf"-\s*{today}:\s*(.*)", line.strip())
        if match:
            events.append(match.group(1))

# 如果当天有事件，打印出来让 GitHub Actions 捕获
if events:
    print(f"**今天 ({today}) 的日程安排：**")
    for event in events:
        print(f"- [ ] {event}") # 使用 Markdown 待办格式
else:
    # 没事件什么都不输出
    pass
