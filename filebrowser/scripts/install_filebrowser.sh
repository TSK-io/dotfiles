#!/bin/bash

# 遇到错误立即停止执行
set -e

# ================= 配置区 (运行前请修改这里) =================
FB_PORT="8080"
FB_USER="admin"
FB_PASS="letmekillyou3"
FB_ROOT="/data/myfiles"
DB_DIR="/opt/filebrowser"

# 替换为你刚才获取的 GitHub Raw 链接！
GITHUB_SERVICE_URL="https://raw.githubusercontent.com/TSK-io/dotfiles/refs/heads/main/filebrowser/systemd/filebrowser.service"
# =========================================================

echo "🚀 开始无人值守安装 Filebrowser..."

# 1. 下载并安装官方二进制文件
echo "-> 正在下载 Filebrowser 二进制文件..."
curl -fsSL https://raw.githubusercontent.com/filebrowser/get/master/get.sh | bash

# 2. 创建目录
echo "-> 正在创建数据和配置目录..."
mkdir -p ${DB_DIR}
mkdir -p ${FB_ROOT}

# 3. 初始化和配置（静默执行）
echo "-> 正在初始化数据库和配置账号..."
# 如果旧数据库存在则先删除，确保是干净的全新安装
rm -f ${DB_DIR}/filebrowser.db

filebrowser -d ${DB_DIR}/filebrowser.db config init > /dev/null
filebrowser -d ${DB_DIR}/filebrowser.db config set --address 0.0.0.0 > /dev/null
filebrowser -d ${DB_DIR}/filebrowser.db config set --port ${FB_PORT} > /dev/null
filebrowser -d ${DB_DIR}/filebrowser.db config set --root ${FB_ROOT} > /dev/null
filebrowser -d ${DB_DIR}/filebrowser.db users add ${FB_USER} ${FB_PASS} --perm.admin > /dev/null

# 4. 从 GitHub 拉取守护进程文件
echo "-> 正在从 GitHub 下载 Systemd 服务文件..."
curl -fsSL ${GITHUB_SERVICE_URL} -o /etc/systemd/system/filebrowser.service

# 5. 重载并启动服务
echo "-> 正在启动并设置开机自启..."
systemctl daemon-reload
systemctl enable filebrowser > /dev/null 2>&1
systemctl restart filebrowser

# 6. 获取当前服务器公网 IP (用于展示)
SERVER_IP=$(curl -s ifconfig.me || echo "你的服务器IP")

echo "=========================================="
echo "🎉 Filebrowser 安装成功并已在后台稳定运行！"
echo "🌐 访问地址: http://${SERVER_IP}:${FB_PORT}"
echo "👤 默认账号: ${FB_USER}"
echo "🔑 默认密码: ${FB_PASS}"
echo "=========================================="
