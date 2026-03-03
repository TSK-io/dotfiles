# 1. 仅安装核心服务端
apt update && apt install mpd -y

# 2. 从你的 dotfiles 复制配置文件过去
cp ~/dotfiles/mpd/mpd.conf /etc/mpd.conf

# 3. 赋予音乐目录权限并重启服务
chmod -R 755 /mnt/data/Music
systemctl restart mpd

