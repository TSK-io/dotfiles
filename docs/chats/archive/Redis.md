User-1:
``````text
请教我redis(我是redis初学者,我的操作系统是debian),我希望类似codecademy那样的极小微代码项目每个小节,(一开始讲解然后是作业,对于作业请给我每一步要做什么风格就像codecademy一样,它的作业风格类似一个作业拆分成多个检查点每个检查点都有明确的指令指向去引导我完成,每个小节完成了我把作业给你检查,你不要一小节太多东西,我的水平很差可能接受不了,我们开始第一个小节, 什么时候毕业你下定论
``````
Model-1:
``````markdown
# Redis 教程 🚀

## 第 1 节：安装 Redis 并说"你好"

---

### 📖 讲解

**Redis 是什么？**

你可以把 Redis 想象成一个**超级快的记事本**。它把数据存在内存里（RAM），而不是硬盘上，所以读写速度极快。

它最基本的用法就是：**存一个值，取一个值**。就像这样：

```
存：name → "小明"
取：name → 得到 "小明"
```

这就是 Redis 最核心的概念：**键值对（Key-Value）**。

今天我们只做两件事：**安装 Redis** 和 **存取一个值**。

---

### ✏️ 作业

#### ✅ 检查点 1：安装 Redis

打开你的终端，输入以下命令：

```bash
sudo apt update
sudo apt install redis-server -y
```

#### ✅ 检查点 2：启动 Redis 服务

```bash
sudo systemctl start redis
```

然后确认它在运行：

```bash
sudo systemctl status redis
```

> 你应该看到一行绿色的 **`active (running)`**。

#### ✅ 检查点 3：进入 Redis 命令行

```bash
redis-cli
```

> 你会看到提示符变成 `127.0.0.1:6379>`，这说明你已经连上 Redis 了。

#### ✅ 检查点 4：存一个值

在 `127.0.0.1:6379>` 提示符下输入：

```
SET myname "hello redis"
```

> 你应该看到 Redis 回复 **`OK`**。

#### ✅ 检查点 5：取出这个值

```
GET myname
```

> 你应该看到 Redis 回复 **`"hello redis"`**。

---

### 📋 提交作业

把你**检查点 2 到检查点 5** 的终端输出复制粘贴给我看。

大概长这样就对了：

```
$ sudo systemctl status redis
...（一些输出）...

$ redis-cli
127.0.0.1:6379> SET myname "hello redis"
...
127.0.0.1:6379> GET myname
...
```

完成后发给我，我帮你检查，然后我们进入第 2 节 ✨
``````

---

User-2:
``````text
docs/chats/archive on git main
> sudo systemctl status redis
● redis-server.service - Advanced key-value store
     Loaded: loaded (/usr/lib/systemd/system/redis-server.service; enabled>
     Active: active (running) since Sat 2026-02-14 07:10:56 EST; 7s ago
 Invocation: d040bd3b8b984c4bb69936b512cfdb48
       Docs: http://redis.io/documentation,
             man:redis-server(1)
   Main PID: 18812 (redis-server)
     Status: "Ready to accept connections"
      Tasks: 6 (limit: 9228)
     Memory: 6.4M (peak: 7M)
        CPU: 152ms
     CGroup: /system.slice/redis-server.service
             └─18812 "/usr/bin/redis-server 127.0.0.1:6379"

Feb 14 07:10:56 debian systemd[1]: Starting redis-server.service - Advance>
Feb 14 07:10:56 debian systemd[1]: Started redis-server.service - Advanced>

docs/chats/archive on git main
> redis-cli
127.0.0.1:6379> exit

docs/chats/archive on git main took 2s
> redis-cli
127.0.0.1:6379> SET myname "hello redis"
OK
127.0.0.1:6379> GET myname
"hello redis"
127.0.0.1:6379>
``````
Model-2:
``````markdown
# ✅ 第 1 节：完美通过！

所有检查点全部正确：

| 检查点 | 状态 |
|---|---|
| Redis 运行中 | ✅ `active (running)` |
| 进入 redis-cli | ✅ |
| SET | ✅ 返回 `OK` |
| GET | ✅ 返回 `"hello redis"` |

---

# 第 2 节：键的生死——覆盖、删除、存在？

### 📖 讲解

上节课你学会了 `SET` 和 `GET`。现在学三个新命令：

| 命令 | 作用 | 例子 |
|---|---|---|
| `SET` (再次) | **覆盖**旧值 | `SET myname "new"` |
| `DEL` | **删除**一个键 | `DEL myname` |
| `EXISTS` | **检查**键是否存在 | `EXISTS myname` |

关键点：

- `DEL` 成功删除返回 `(integer) 1`，键不存在返回 `(integer) 0`
- `EXISTS` 存在返回 `(integer) 1`，不存在返回 `(integer) 0`
- `GET` 一个不存在的键，返回 `(nil)`（意思是"空的，什么都没有"）

---

### ✏️ 作业

先进入 Redis（如果你已经退出了）：

```bash
redis-cli
```

#### ✅ 检查点 1：确认上节课的值还在

```
GET myname
```

> 你应该看到 `"hello redis"`（Redis 重启前数据不会丢失）

#### ✅ 检查点 2：覆盖它

```
SET myname "I am learning redis"
```

然后再取出来看看变了没：

```
GET myname
```

#### ✅ 检查点 3：检查键是否存在

```
EXISTS myname
```

> 应该返回 `(integer) 1`

#### ✅ 检查点 4：删除这个键

```
DEL myname
```

> 应该返回 `(integer) 1`

#### ✅ 检查点 5：验证它真的没了

```
GET myname
EXISTS myname
```

> `GET` 应该返回 `(nil)`，`EXISTS` 应该返回 `(integer) 0`

---

### 📋 提交作业

把检查点 1 到 5 的终端输出贴给我 ✨
``````

---

User-3:
``````text
127.0.0.1:6379> SET myname "I am learning redis"
OK
127.0.0.1:6379> get myname
"I am learning redis"
127.0.0.1:6379> EXISTS myname
(integer) 1
127.0.0.1:6379> DEL myname
(integer) 1
127.0.0.1:6379> GET myname
(nil)
127.0.0.1:6379> EXISTS myname
(integer) 0
127.0.0.1:6379>
``````
Model-3:
``````markdown
# ✅ 第 2 节：完美通过！

| 检查点 | 状态 |
|---|---|
| SET 覆盖 | ✅ 值变成了 `"I am learning redis"` |
| EXISTS 存在 | ✅ 返回 `1` |
| DEL 删除 | ✅ 返回 `1` |
| GET/EXISTS 验证已删除 | ✅ `(nil)` 和 `0` |

> 👀 顺便说一下，你用了小写的 `get`，也成功了——Redis 命令**不区分大小写**，`GET`、`get`、`Get` 都一样。

---

# 第 3 节：Redis 会数数——计数器

### 📖 讲解

Redis 可以把值当作**数字**来操作。两个新命令：

| 命令 | 作用 | 例子 |
|---|---|---|
| `INCR` | 值 **+1** | `INCR score` |
| `DECR` | 值 **-1** | `DECR score` |

神奇的地方：**如果键不存在，Redis 会当它是 0，然后再加减。**

```
INCR score    → (integer) 1    （0 + 1 = 1）
INCR score    → (integer) 2    （1 + 1 = 2）
DECR score    → (integer) 1    （2 - 1 = 1）
```

这在现实中超常用：网站访问量、点赞数、库存数量……

---

### ✏️ 作业

场景：你在给一篇文章记录**点赞数**。

#### ✅ 检查点 1：从零开始

不需要先 `SET`，直接：

```
INCR likes
```

> 应该返回 `(integer) 1`

#### ✅ 检查点 2：再点赞两次

连续输入两次 `INCR likes`：

```
INCR likes
INCR likes
```

> 最后一次应该返回 `(integer) 3`

#### ✅ 检查点 3：有人取消点赞了

```
DECR likes
```

> 应该返回 `(integer) 2`

#### ✅ 检查点 4：用 GET 看看它长什么样

```
GET likes
```

> 想一想：它返回的是数字还是字符串？

#### ✅ 检查点 5：清理现场

```
DEL likes
```

---

### 📋 提交作业

把检查点 1 到 5 的输出贴给我，特别注意**检查点 4** 的结果 ✨
``````

---

User-4:
``````text
127.0.0.1:6379> INCR likes
(integer) 1
127.0.0.1:6379> INCR likes
(integer) 2
127.0.0.1:6379> INCR likes
(integer) 3
127.0.0.1:6379> DECR likes
(integer) 2
127.0.0.1:6379> GET likes
"2"
127.0.0.1:6379> DEL likes
(integer) 1
127.0.0.1:6379>
``````
Model-4:
``````markdown
# ✅ 第 3 节：完美通过！

| 检查点 | 状态 |
|---|---|
| INCR 从零开始 | ✅ `1` |
| INCR 两次到 3 | ✅ `3` |
| DECR 减到 2 | ✅ `2` |
| GET 查看 | ✅ `"2"` |
| DEL 清理 | ✅ |

### 💡 检查点 4 的重点发现

`GET likes` 返回的是 **`"2"`**——带引号，是个**字符串**！

> Redis 内部**一切都是字符串**。`INCR`/`DECR` 只是聪明地把字符串当数字来算，算完再存回字符串。

---

# 第 4 节：数据会过期——TTL

### 📖 讲解

现实场景：验证码 5 分钟过期，登录状态 30 分钟过期。Redis 天生支持这个。

| 命令 | 作用 |
|---|---|
| `EXPIRE key 秒数` | 给一个键设定倒计时，到了就**自动删除** |
| `TTL key` | 查看这个键还剩几秒（**T**ime **T**o **L**ive） |

`TTL` 的返回值含义：

| 返回值 | 含义 |
|---|---|
| 正数 | 还剩几秒 |
| `-1` | 键存在，但**永不过期** |
| `-2` | 键**不存在**（已过期或已删除） |

---

### ✏️ 作业

场景：你存了一个验证码，它应该 10 秒后自动消失。

#### ✅ 检查点 1：存一个验证码

```
SET code "8842"
```

#### ✅ 检查点 2：看看它的 TTL

```
TTL code
```

> 应该返回 `-1`（永不过期，因为你还没设过期时间）

#### ✅ 检查点 3：设定 10 秒后过期

```
EXPIRE code 10
```

> 应该返回 `(integer) 1`

#### ✅ 检查点 4：赶紧查看倒计时

**快速**连续输入几次：

```
TTL code
TTL code
TTL code
```

> 你应该看到数字在**变小**（比如 8、6、5……）

#### ✅ 检查点 5：等它死

等大约 10 秒后，再输入：

```
GET code
TTL code
```

> `GET` 应该返回 `(nil)`，`TTL` 应该返回 `-2`

---

### 📋 提交作业

把检查点 1 到 5 的输出贴给我 ✨
``````

---

User-5:
``````text
127.0.0.1:6379> SET code "8842"
OK
127.0.0.1:6379> TTL code
(integer) -1
127.0.0.1:6379> EXPIRE code 10
(integer) 1
127.0.0.1:6379> TTL code
(integer) 6
127.0.0.1:6379> TTL code
(integer) 4
127.0.0.1:6379> GET code
"8842"
127.0.0.1:6379> TTL code
(integer) -2
127.0.0.1:6379> GET code
(nil)
127.0.0.1:6379>
``````
Model-5:
``````markdown
# ✅ 第 4 节：完美通过！

| 检查点 | 状态 |
|---|---|
| SET code | ✅ |
| TTL 永不过期 | ✅ `-1` |
| EXPIRE 10 秒 | ✅ |
| TTL 倒计时 | ✅ 6 → 4 不断减小 |
| 过期后消失 | ✅ `(nil)` 和 `-2` |

> 🎬 你还亲眼抓到了一个精彩瞬间——倒计时还剩几秒时 `GET code` 拿到了 `"8842"`，再一看 TTL 已经 `-2` 了，数据就这样在你眼前消失。

---

# 第 5 节：批量操作——一次存取多个

### 📖 讲解

到目前为止你都是**一次操作一个键**。Redis 支持批量：

| 命令 | 作用 |
|---|---|
| `MSET` | 一次设置**多个**键值对 |
| `MGET` | 一次获取**多个**键的值 |

```
MSET a "1" b "2" c "3"     ← 一条命令存了 3 个
MGET a b c                   ← 一条命令取了 3 个
```

为什么不一个个 SET？因为每条命令都是一次网络通信，批量操作**更快**。

---

### ✏️ 作业

场景：存储一个用户的基本资料。

#### ✅ 检查点 1：一次存三个键

```
MSET user:name "Tom" user:age "25" user:city "Beijing"
```

> 应该返回 `OK`

#### ✅ 检查点 2：一次取出来

```
MGET user:name user:age user:city
```

> 应该返回三个值，按顺序排列

#### ✅ 检查点 3：故意取一个不存在的

```
MGET user:name user:email user:city
```

> 注意观察：中间那个 `user:email` 会显示什么？

#### ✅ 检查点 4：清理

```
DEL user:name user:age user:city
```

> `DEL` 也可以一次删多个！应该返回 `(integer) 3`

---

### 📋 提交作业

把检查点 1 到 4 贴给我 ✨
``````
