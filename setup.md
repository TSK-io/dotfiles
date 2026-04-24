# 为最小化安装的Debian恢复网络

### 第一步： 确认网卡接口名称
```bash
ip a   
```

### 第二步：启用网卡并获取 IP 地址(将enp3s0替换为第一步看到的网卡名称)
1. 启动网卡
```bash
ip link set enp3s0 up   
```

2. 获取IP地址
```bash
dhcpcd enp3s0   
```

### 第四步：安装NetworkManager：
```bash
apt update
apt install network-manager
```

### 最终步：重启
```bash
reboot
```
