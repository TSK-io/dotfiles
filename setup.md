# 为最小化安装的Debian恢复网络 

### 第一步： 确认网卡接口名称
```bash
ip a   
```

### 第二步：启用网卡并获取 IP 地址(将enp3s0替换为第一步看到的网卡名称)

启动网卡

```bash
ip link set enp3s0 up   
```

获取IP地址

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

---

# 修复在MBA2015 上安装 Debian 后遇到无法使用 Wi-Fi (博通驱动)

### 第1步：开启非自由软件源 (Non-free)

在每个源条目后面添加: non-free

```bash
vi /etc/apt/sources.list
```

### 第2步：刷新源并安装内核头文件(编译驱动),然后安装驱动

```bash
sudo apt update
sudo apt install linux-headers-$(uname -r) broadcom-sta-dkms
```

### 第3步：清理冲突模块并加载新驱动
Linux 内核中可能内置了一些开源的博通驱动（如 `b43` 或 `brcmsmac`），它们与我们刚刚安装的专有驱动会产生冲突。我们需要先将它们卸载，然后加载新驱动：

1. 卸载冲突的开源驱动：
   ```bash
   sudo modprobe -r b44 b43 b43legacy ssb brcmsmac bcma
   ```
2. 加载刚刚编译好的专有驱动：
   ```bash
   sudo modprobe wl
   ```

### 最终步：检查 Wi-Fi

检查无线网卡(如果出现wlan，wlp等开头的即可正常工作)：

```bash
ip a
```
* **如果没有看到相关的无线接口**：说明驱动可能尚未完全生效，请直接**重启电脑** (`sudo reboot`)。重启后，`wl` 驱动通常会自动加载，Wi-Fi 即可正常工作。

---

# MBA2015 双系统 Linux 安装后 Windows 黑屏

### 适用症状

系统情况：原本单系统 Windows，后来安装 Debian
问题：装完 Debian 后，Windows 无法启动；无论从 GRUB 还是开机按 Option/Alt 选择 Windows，都会黑屏

### 第 1 步：进入 Linux 或 Linux Live USB

可以进入已安装的 Linux，Linux Live USB 启动。(root用户)

### 第 2 步：确认内置硬盘名称

运行：

```bash
lsblk -o NAME,SIZE,MODEL,TYPE,FSTYPE,PARTLABEL,MOUNTPOINTS
```

在本例中，内置硬盘是：

```text
/dev/sda
```

注意：后面的命令要操作**整块磁盘**，比如 `/dev/sda`，不是 `/dev/sda1`、`/dev/sda2` 这种分区。

### 第 3 步：检查分区表状态

运行：

```bash
apt -y install gdisk
gdisk -l /dev/sda
```

问题状态会类似：

```text
Partition table scan:
  MBR: hybrid
  BSD: not present
  APM: not present
  GPT: present

Found valid GPT with hybrid MBR; using GPT.
```

如果看到 `MBR: hybrid`，基本就对上了。

### 第 4 步：用 gdisk 把 Hybrid MBR 改回 Protective MBR

运行：

```bash
gdisk /dev/sda
```

进入 `gdisk` 后，依次输入：

```text
x
n
w
Y
```

写入成功后，屏幕会类似：

```text
OK; writing new GUID partition table (GPT) to /dev/sda.
The operation has completed successfully.
```

### 最终步：重启并选择 Windows

运行：

```bash
sync
reboot
```
按住 option 选择windows启动
