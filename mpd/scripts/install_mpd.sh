# 1. 仅安装核心服务端
apt update && apt install mpd -y

# 2. 强制创建软链接 (-s 是软链接，-f 是如果存在就强制覆盖)
ln -sf ~/dotfiles/mpd/mpd.conf /etc/mpd.conf

# 3. 赋予音乐目录权限并重启服务
chmod -R 755 /mnt/data/Music
systemctl enable --now mpd

