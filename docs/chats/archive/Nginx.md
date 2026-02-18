User-1:
``````text
请教我nginx(我是nginx初学者,我的操作系统是debian),我希望类似codecademy那样的极小微项目每个小节,(一开始讲解然后是作业,对于作业请给我每一步要做什么风格就像codecademy一样,它的作业风格类似一个作业拆分成多个检查点每个检查点都有明确的指令指向去引导我完成,每个小节完成了我把作业给你检查,你不要一小节太多东西,我的水平很差可能接受不了,我们开始第一个小节, 什么时候毕业你下定论
``````
Model-1:
``````markdown
# 🎓 Nginx 微课程 —— 为你量身定制

欢迎！我会像 Codecademy 那样，一步步带你学 Nginx。每个小节很短，学完做作业，做完给我看，我帮你检查。全部学完我会告诉你「毕业 🎓」。

---

## 📚 课程大纲（预览）

我们大概会经历这些小节（可能根据你的进度微调）：

| 小节 | 主题 |
|------|------|
| 1 | 安装 Nginx |
| 2 | 认识 Nginx 文件结构 |
| 3 | 第一个静态网页 |
| 4 | server block 基础 |
| 5 | 多站点配置 |
| 6 | location 块与路由 |
| 7 | 反向代理 |
| 8 | HTTPS / SSL 基础 |
| 9 | 日志与排错 |
| 10 | 综合毕业项目 |

---

# 小节 1：安装 Nginx

## 📖 讲解

**Nginx 是什么？**
Nginx（读作 "engine-x"）是一个 **Web 服务器**。你可以把它想象成一个「服务员」——当有人访问你的网站时，Nginx 负责把网页「端」给他们。

**我们现在要做什么？**
在你的 Debian 系统上安装 Nginx，然后确认它在运行。就这么简单。

---

## ✏️ 作业

### ✅ 检查点 1 — 更新软件包列表

在终端中运行以下命令，让系统知道最新有哪些软件可以安装：

```bash
sudo apt update
```

> 💡 `apt update` 不是安装软件，它只是"刷新"可用软件的清单。

---

### ✅ 检查点 2 — 安装 Nginx

运行以下命令安装 Nginx：

```bash
sudo apt install nginx -y
```

> 💡 `-y` 的意思是「自动回答 yes」，省得它问你确不确认。

---

### ✅ 检查点 3 — 确认 Nginx 正在运行

安装完后，运行：

```bash
sudo systemctl status nginx
```

你应该会看到输出中有一行类似这样的绿色文字：

```
Active: active (running)
```

---

### ✅ 检查点 4 — 用浏览器验证

打开浏览器，在地址栏输入：

```
http://localhost
```

你应该看到一个页面，上面写着 **"Welcome to nginx!"**。

> 🖥️ 如果你的 Debian 没有图形界面，可以用这个命令代替：
> ```bash
> curl http://localhost
> ```
> 你应该能看到一段 HTML，里面包含 `Welcome to nginx!`。

---

## 📋 交作业方式

完成上面 4 个检查点后，把以下**两样东西**的输出贴给我：

1. `sudo systemctl status nginx` 的输出
2. `curl http://localhost` 的输出

我来帮你检查！✅ 通过了我们就进入小节 2。

---

> ⏳ 慢慢来，不着急。有任何报错直接贴给我，我帮你解决。
``````

---

User-2:
``````text

> sudo systemctl status nginx
● nginx.service - A high performance web server and a reverse proxy server
     Loaded: loaded (/usr/lib/systemd/system/nginx.service; enabled; prese>
     Active: active (running) since Thu 2026-02-12 23:22:42 EST; 1min 12s >
 Invocation: a7cbc09b54af441291b9d863cadf9763
       Docs: man:nginx(8)
    Process: 6947 ExecStartPre=/usr/sbin/nginx -t -q -g daemon on; master_>
    Process: 6948 ExecStart=/usr/sbin/nginx -g daemon on; master_process o>
   Main PID: 6980 (nginx)
      Tasks: 5 (limit: 9228)
     Memory: 4.5M (peak: 11M)
        CPU: 99ms
     CGroup: /system.slice/nginx.service
             ├─6980 "nginx: master process /usr/sbin/nginx -g daemon on; m>
             ├─6982 "nginx: worker process"
             ├─6983 "nginx: worker process"
             ├─6984 "nginx: worker process"
             └─6985 "nginx: worker process"

Feb 12 23:22:42 debian systemd[1]: Starting nginx.service - A high perform>
Feb 12 23:22:42 debian systemd[1]: Started nginx.service - A high performa>

~
> curl http://localhost
<!DOCTYPE html>
<html>
<head>
<title>Welcome to nginx!</title>
<style>
html { color-scheme: light dark; }
body { width: 35em; margin: 0 auto;
font-family: Tahoma, Verdana, Arial, sans-serif; }
</style>
</head>
<body>
<h1>Welcome to nginx!</h1>
<p>If you see this page, the nginx web server is successfully installed and
working. Further configuration is required.</p>

<p>For online documentation and support please refer to
<a href="http://nginx.org/">nginx.org</a>.<br/>
Commercial support is available at
<a href="http://nginx.com/">nginx.com</a>.</p>

<p><em>Thank you for using nginx.</em></p>
</body>
</html>

~
>
``````
Model-2:
``````markdown
# ✅ 小节 1 — 检查结果：全部通过！🎉

| 检查点 | 状态 | 说明 |
|--------|------|------|
| 1. `apt update` | ✅ | 已完成（否则装不上 nginx） |
| 2. `apt install nginx` | ✅ | 安装成功 |
| 3. `systemctl status` | ✅ | `Active: active (running)` ，完美 |
| 4. `curl localhost` | ✅ | 看到了 `Welcome to nginx!` 页面 |

**小彩蛋**：从你的输出能看到你的 Nginx 启动了 **4 个 worker 进程**（6982-6985），这是因为你的机器有 4 个 CPU 核心。以后我们会学到怎么配置这个。

---

# 小节 2：认识 Nginx 的文件结构

## 📖 讲解

Nginx 装好了，但它的「配置文件」在哪里？你需要知道几个关键位置：

| 路径 | 是什么 |
|------|--------|
| `/etc/nginx/` | Nginx 所有配置文件的「大本营」 |
| `/etc/nginx/nginx.conf` | **主配置文件**（老大） |
| `/etc/nginx/sites-available/` | 存放「准备好的」站点配置 |
| `/etc/nginx/sites-enabled/` | 存放「正式启用的」站点配置（其实是快捷方式） |
| `/var/www/html/` | 默认的网页文件存放目录 |

**一个重要概念**：
- `sites-available/` 就像「菜单上的菜」—— 写好了，但不一定端上桌。
- `sites-enabled/` 就像「客人点的菜」—— 只有放在这里的配置才会真正生效。
- 它们之间通过 **符号链接**（symlink，可以理解为"快捷方式"）连接。

---

## ✏️ 作业

### ✅ 检查点 1 — 查看 Nginx 配置目录

运行：

```bash
ls /etc/nginx/
```

> 💡 你会看到一堆文件和文件夹，先有个印象就行。

---

### ✅ 检查点 2 — 查看主配置文件

运行：

```bash
cat /etc/nginx/nginx.conf
```

> 💡 你现在**不需要看懂**它，只是知道它在哪里、长什么样。

---

### ✅ 检查点 3 — 看看 sites-available 里有什么

运行：

```bash
ls /etc/nginx/sites-available/
```

> 💡 你应该会看到一个叫 `default` 的文件，这就是你刚才看到的那个「Welcome to nginx!」页面的配置。

---

### ✅ 检查点 4 — 看看 sites-enabled 里有什么

运行：

```bash
ls -l /etc/nginx/sites-enabled/
```

> 💡 注意看输出中有个 `->` 箭头符号，它指向 `sites-available/default`，这就是「快捷方式」（符号链接）。

---

### ✅ 检查点 5 — 找到默认网页文件

运行：

```bash
cat /var/www/html/index.nginx-debian.html
```

> 💡 这就是你 `curl http://localhost` 时看到的那个 HTML 页面的源文件！

---

## 📋 交作业方式

把以下 **5 个命令**的输出贴给我：

1. `ls /etc/nginx/`
2. `cat /etc/nginx/nginx.conf`
3. `ls /etc/nginx/sites-available/`
4. `ls -l /etc/nginx/sites-enabled/`
5. `cat /var/www/html/index.nginx-debian.html`

贴过来我帮你检查，通过了就进入小节 3！🚀
``````

---

User-3:
``````text
``````
Model-3:
``````markdown
``````

---

User-4:
``````text
``````
Model-4:
``````markdown
``````

---

User-5:
``````text
``````
Model-5:
``````markdown
``````

---

User-6:
``````text
``````
Model-6:
``````markdown
``````

---

User-7:
``````text
``````
Model-7:
``````markdown
``````

---

User-8:
``````text
``````
Model-8:
``````markdown
``````

---

User-9:
``````text
``````
Model-9:
``````markdown
``````

---

User-10:
``````text
``````
Model-10:
``````markdown
``````

---

User-11:
``````text
``````
Model-11:
``````markdown
``````

---

User-12:
``````text
``````
Model-12:
``````markdown
``````

---
