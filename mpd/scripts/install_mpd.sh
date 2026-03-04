#!/bin/bash

# 确保脚本遇到错误时停止执行
set -e

echo "1. 安装核心服务端与 mpc 工具..."
apt update && apt install mpd mpc curl -y

echo "2. 从 GitHub 远程拉取最新配置..."
# 使用 curl 下载配置并直接覆盖到 /etc/mpd.conf
curl -sL -o /etc/mpd.conf https://raw.githubusercontent.com/TSK-io/dotfiles/main/mpd/mpd.conf

echo "3. 赋予音乐目录权限并应用新配置..."
# 确保目录存在且有权限
mkdir -p /mnt/data/Music
chmod -R 755 /mnt/data/Music

# 因为覆盖了配置文件，必须 restart 重启服务让配置生效
systemctl enable mpd
systemctl restart mpd
sleep 2 # 给 MPD 两秒钟时间完成 socket 绑定

echo "4. 自动化且幂等的播放状态初始化..."
# --wait 是灵魂参数，等待音乐扫描彻底完成
mpc update --wait

# clear 保证幂等性，防止重复添加
mpc clear

mpc add /
mpc repeat on
mpc random on    # 让电台永远随机洗牌
mpc play

echo "5. 过河拆桥：卸载临时工具，保持极致精简..."
apt purge -y mpc
apt autoremove -y

echo "🎵 你的云端电台已就绪并开始广播！"
