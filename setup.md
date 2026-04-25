# 为最小化安装的Debian恢复网络 

### 第 1 步： 确认网卡接口名称
```bash
ip a   
```

### 第 2 步：启用网卡并获取 IP 地址(将enp3s0替换为第一步看到的网卡名称)

启动网卡

```bash
ip link set enp3s0 up   
```

获取IP地址

```bash
dhcpcd enp3s0   
```

### 第 3 步：安装NetworkManager：
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

### 第 1 步：开启非自由软件源 (Non-free)

在每个源条目后面添加: non-free

```bash
vi /etc/apt/sources.list
```

### 第 2 步：刷新源并安装内核头文件(编译驱动),然后安装驱动

```bash
sudo apt update
sudo apt install linux-headers-$(uname -r) broadcom-sta-dkms
```

### 最终步：重启并检查 Wi-Fi

重启电脑，使驱动生效

```bash
reboot
```

检查无线网卡(如果出现wlan，wlp等开头的即可正常工作)：

```bash
ip a
```

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

---

# Debian 把用户添加到 sudo 组

### 第 1 步：安装 sudo 软件包
更新软件源并安装 `sudo`：
```bash
apt update
apt install sudo -y
```

### 第 2 步：将你的用户添加到 sudo 组 (把 `your_username` 换成实际的用户名)

```bash
usermod -aG sudo your_username
```

### 最终步：重启

```bash
reboot
```

---

# 为最小化安装的Debian安装i3wm作为基础桌面

### 第 1 步：安装显示服务器 (Xorg)

```bash
sudo apt update && sudo apt upgrade -y
sudo apt install xserver-xorg xinit -y
```

### 第 2 步：安装 i3wm 及核心组件

```bash
sudo apt install i3 i3status i3lock -y
```

### 第 3 步：安装必备的日常软件
i3 只是一个窗口管理器，它不包含终端、文件管理器或中文字体。如果你不装这些，进入 i3 后你将面对黑屏且无法操作。

建议安装以下基础软件：
```bash
# 安装终端 (lxterminal比较轻量且对新手友好，你也可以选 alacritty 或 kitty)
# 安装中文字体 (防止中文显示为方块)
# 安装 rofi (比自带的 dmenu 更好看、更好用的应用启动器)
sudo apt install alacritty fonts-wqy-microhei rofi -y
```

---

### 第 4 步：选择如何进入 i3wm
你有两种方式进入桌面，选择其中**一种**即可：

#### 选项 A：使用显示管理器（推荐新手）
显示管理器就是开机后的“图形化登录界面”。如果你希望开机就有个漂亮的输入密码的界面，可以安装 `LightDM`：
```bash
sudo apt install lightdm -y
```
安装完成后，重启电脑 (`sudo reboot`)，你就会看到图形登录界面，输入密码即可进入 i3。

#### 选项 B：使用 startx（极致轻量、纯命令行启动）
如果你连登录界面都不想要，想在黑框框登录后手动输入命令进入桌面：
1. 切换到你的普通用户（如果你当前是 root 的话）。
2. 在普通用户的家目录下创建一个 `.xinitrc` 文件：
```bash
echo "exec i3" > ~/.xinitrc
```
3. 以后每次登录命令行后，只需输入以下命令即可进入桌面：
```bash
startx
```

---

### 第 5 步：i3wm 的初次配置（重要！）
当你第一次成功进入 i3wm 时，屏幕上会弹出一个配置向导（全英文）：

1. 它会问你是否生成配置文件（Generate config），按 **Enter** 键同意。
2. 它会让你选择 **Modifier 键 (Mod键)**（这是 i3 最重要的键，所有的快捷键都要配合它使用）：
   * 选择 **Win键** (Super) 或者 **Alt键**。
   * **强烈建议选择 Win 键**，因为 Alt 键经常和很多软件（如浏览器、编辑器）的快捷键冲突。使用方向键选择，按 **Enter** 确认。

---

---

### 第 6 步：进阶完善系统 (强烈建议)
因为是最小化安装，你现在没有网络图标、没有声音控制、没有壁纸。建议在终端里继续安装以下工具：

**2. 声音控制与音量调节**
```bash
sudo apt install pulseaudio pavucontrol alsa-utils
```

**3. 设置壁纸工具**
```bash
sudo apt install feh
```

**4. 修改 i3 配置文件**
i3 的配置文件在 `~/.config/i3/config`。你可以用 `nano` 或 `vim` 编辑它：
```bash
nano ~/.config/i3/config
```
* **修改默认终端：** 找到 `bindsym $mod+Return exec i3-sensible-terminal`，把 `i3-sensible-terminal` 改为 `lxterminal`。
* **修改启动器为 rofi：** 找到 `bindsym $mod+d exec dmenu_run`，把它改为 `bindsym $mod+d exec rofi -show drun`。
* **设置开机启动网络图标：** 在文件最末尾添加一行：`exec --no-startup-id nm-applet`

修改完成后，按下 **Win + Shift + C** 即可重新加载配置文件，立即生效！

祝你在 i3wm 的平铺窗口世界里折腾愉快！如果有哪一步卡住了，随时问我。
