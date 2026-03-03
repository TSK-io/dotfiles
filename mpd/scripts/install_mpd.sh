#!/bin/bash

# 1. 安装核心服务端（顺手带上 mpc 作为临时配置工具）
apt update && apt install mpd mpc -y

# 2. 从 dotfiles 同步配置 (推荐用强软链接)
ln -sf ~/dotfiles/mpd/mpd.conf /etc/mpd.conf

# 3. 赋予音乐目录权限并启动服务
chmod -R 755 /mnt/data/Music
systemctl enable --now mpd
sleep 2 # 给 MPD 两秒钟时间完成 socket 绑定

# ==========================================
# 4. 核心魔法：自动化且幂等的播放状态初始化
# ==========================================
# --wait 是灵魂参数，它会让脚本暂停，直到音乐扫描彻底完成，防止下面 add 找不到歌
mpc update --wait 

# clear 是为了保证“幂等性”。如果跑两次脚本，不清空就会导致歌单里出现两份一样的歌
mpc clear 

mpc add /
mpc repeat on
mpc random on    # <--- 新增这一行！让电台永远随机洗牌
mpc play

# 5. 过河拆桥：卸载 mpc，深藏功与名，保持服务端极致精简！
apt purge -y mpc
apt autoremove -y

echo "🎵 你的云端电台已就绪并开始广播！"
