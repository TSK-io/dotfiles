#!/bin/bash

# 遇到错误立即停止
set -e

echo "▶ 1. 安装基础依赖与系统识别工具..."
apt update && apt install -y curl gnupg lsb-release

echo "▶ 2. 识别系统并添加 myMPD 官方纯净源..."
. /etc/os-release
if [ "$ID" = "debian" ]; then
    OS_VER="Debian_${VERSION_ID}"
elif [ "$ID" = "ubuntu" ]; then
    OS_VER="xUbuntu_${VERSION_ID}"
else
    echo "❌ 无法识别的系统版本 ($ID)"
    exit 1
fi
curl -fsSL "https://download.opensuse.org/repositories/home:/jcorporation/${OS_VER}/Release.key" | gpg --dearmor > /etc/apt/trusted.gpg.d/mympd.gpg
echo "deb http://download.opensuse.org/repositories/home:/jcorporation/${OS_VER}/ /" > /etc/apt/sources.list.d/mympd.list

echo "▶ 3. 安装 MPD 引擎、mpc 与 myMPD 面板..."
apt update && apt install -y mpd mpc mympd

echo "▶ 4. 从 GitHub 拉取极客配置并启动引擎..."
curl -sL -o /etc/mpd.conf https://raw.githubusercontent.com/TSK-io/dotfiles/main/mpd/mpd.conf
mkdir -p /mnt/data/Music
chmod -R 755 /mnt/data/Music
systemctl enable mpd
systemctl restart mpd
sleep 2 # 等待底层 Socket 绑定

echo "▶ 5. 自动化且幂等的播放状态初始化..."
mpc update --wait
mpc clear
mpc add /
mpc repeat on
mpc random on
mpc play

echo "▶ 6. 深度定制 myMPD (自动防冲突与去 SSL 化)..."
systemctl stop mympd
# 强制修改网页端口为 18080，完美避开 80 端口冲突
echo "18080" > /var/lib/mympd/config/http_port
# 彻底关闭 SSL，防止浏览器严格的混合内容拦截
echo "false" > /var/lib/mympd/config/ssl
systemctl enable mympd
systemctl start mympd

echo "▶ 7. 过河拆桥：卸载临时工具，保持系统极致精简..."
apt purge -y mpc
apt autoremove -y

# 获取公网 IP
PUBLIC_IP=$(curl -s ifconfig.me)

echo "=================================================="
echo "🎉 终极版云端电台部署完成！"
echo "🌐 你的专属控制台地址："
echo "👉 http://${PUBLIC_IP}:18080"
echo "=================================================="
