User-1:
``````text
请教我java命令行(注意请教命令行(编程基础语法我有学过了),我的PC是debian),我希望类似codecademy那样的极小微代码项目每个小节,(一开始讲解然后是作业,对于作业请给我每一步要做什么风格就像codecademy一样,它的作业风格类似一个作业拆分成多个检查点每个检查点都有明确的指令指向去引导我完成,每个小节完成了我把作业给你检查,你不要一小节太多东西,我的水平很差可能接受不了,我们开始第一个小节, 什么时候毕业你下定论
``````
Model-1:
``````markdown
# ☕ Java 命令行大冒险

欢迎！我会像 Codecademy 一样，带你一步步掌握 Java 命令行。每个小节都很小，不用怕！

---

## 📋 课程大纲（我会根据你的进度调整）

| 阶段 | 内容 |
|------|------|
| 1 | 环境确认 & 第一次编译运行 |
| 2 | `javac` 和 `java` 到底在干嘛 |
| 3 | 命令行参数 `args` |
| 4 | 编译多个文件 & 包(package) |
| 5 | classpath 是什么鬼 |
| 6 | 用 jar 打包你的程序 |
| 7 | 运行 jar & 可执行 jar |
| 8 | 读懂编译/运行时报错 |
| 9 | 综合小项目 |
| 🎓 | **毕业测试** |

> 我会在你全部完成后决定你是否毕业，毕业标准是：**能独立用命令行编译、打包、运行一个多文件 Java 项目，并能排查常见错误。**

---

# 📘 第 1 节：环境确认 & 你的第一次编译运行

## 讲解

在写 Java 之前，你需要确认你的 Debian 上装了 **JDK**（Java Development Kit）。

JDK 里有两个最核心的命令：

| 命令 | 作用 |
|------|------|
| `javac` | **编译器** — 把你写的 `.java` 文件变成 `.class` 文件（字节码） |
| `java` | **运行器** — 运行那个 `.class` 文件 |

流程就这么简单：

```
你写的代码        编译            运行
Hello.java  ──▶  Hello.class  ──▶  屏幕输出
            javac              java
```

---

## ✏️ 作业

### Checkpoint 1 — 确认 Java 已安装

在终端输入以下命令，然后把输出结果贴给我：

```bash
javac -version
```

> 🎯 **期望看到**：类似 `javac 17.x.x` 或 `javac 21.x.x` 的版本号。
> 如果报错 `command not found`，先告诉我，我教你装。

---

### Checkpoint 2 — 创建工作目录

在终端依次运行：

```bash
mkdir -p ~/java-learn
cd ~/java-learn
```

> 🎯 这会在你的 home 目录下创建一个 `java-learn` 文件夹，以后我们所有练习都在这里。

---

### Checkpoint 3 — 写你的第一个 Java 文件

用你喜欢的编辑器（`nano`、`vim`、VS Code 都行）创建文件：

```bash
nano Hello.java
```

然后输入**以下内容**（一字不差）：

```java name=Hello.java
public class Hello {
    public static void main(String[] args) {
        System.out.println("I am learning Java CLI on Debian!");
    }
}
```

保存并退出（nano 里是 `Ctrl+O` 回车保存，`Ctrl+X` 退出）。

---

### Checkpoint 4 — 编译它

```bash
javac Hello.java
```

然后运行：

```bash
ls
```

> 🎯 **期望看到**：目录下现在有 **两个文件**：`Hello.java` 和 `Hello.class`

---

### Checkpoint 5 — 运行它

```bash
java Hello
```

> 🎯 **期望看到**：屏幕输出 `I am learning Java CLI on Debian!`
>
> ⚠️ 注意：运行时写的是 `java Hello`，**不是** `java Hello.class`！

---

## 📬 交作业

完成后，把以下内容贴给我：

1. `javac -version` 的输出
2. `ls` 的输出（checkpoint 4 那步）
3. `java Hello` 的输出

三样都对了，我们进入第 2 节！🚀
``````
---

User-2:
``````text
> javac -version
javac 21.0.10

~
> mkdir -p ~/java-learn
  cd ~/java-learn

~/java-learn
> nano Hello.java

~/java-learn via java v21.0.10 took 11s
> ls
Hello.java

~/java-learn via java v21.0.10
> javac Hello.java

~/java-learn via java v21.0.10
> ls
Hello.class  Hello.java

~/java-learn via java v21.0.10
> java Hello
I am learning Java CLI on Debian!

~/java-learn via java v21.0.10
>
``````
Model-2:
``````markdown
# ✅ 第 1 节 — 完美通过！

| Checkpoint | 状态 |
|---|---|
| 1. `javac -version` → `javac 21.0.10` | ✅ |
| 2. 创建 `~/java-learn` 目录 | ✅ |
| 3. 创建 `Hello.java` | ✅ |
| 4. `javac` 编译 → 出现 `Hello.class` | ✅ |
| 5. `java Hello` → 正确输出 | ✅ |

你的 JDK 21，很新，很好。让我们继续！

---

# 📘 第 2 节：`javac` 和 `java` 到底在干嘛

## 讲解

上一节你成功跑起来了，但你可能会问：**为什么要分两步？** 直接运行 `.java` 不行吗？

答案是：Java 的设计就是**两阶段**的：

```
阶段 1：编译（javac）          阶段 2：运行（java）
┌──────────┐    javac     ┌──────────┐    java      ┌──────────┐
│ .java    │ ──────────▶  │ .class   │ ──────────▶  │ 屏幕输出  │
│ 人能读的  │              │ 机器读的  │    (JVM)     │          │
└──────────┘              └──────────┘              └──────────┘
```

### 关键概念

| | `javac` | `java` |
|---|---|---|
| **输入** | `.java` 源代码文件 | 类名（**不是**文件名） |
| **输出** | `.class` 字节码文件 | 程序的运行结果 |
| **加不加后缀** | ✅ 要写 `Hello.java` | ❌ 只写 `Hello`，不写 `.class` |

### 一个重要规则

> **文件名必须和 `public class` 的类名一模一样**（包括大小写）。
>
> 类叫 `Hello` → 文件必须叫 `Hello.java`
> 类叫 `MyApp` → 文件必须叫 `MyApp.java`

如果不一致，`javac` 会直接报错。这节作业我们就来**亲眼看看这些错误**。

---

## ✏️ 作业

### Checkpoint 1 — 看看 .class 文件里是什么

运行以下命令：

```bash
cat Hello.class
```

> 🎯 你会看到一堆乱码/奇怪的符号。这就是**字节码**，是给 JVM（Java 虚拟机）读的，不是给人读的。感受一下就好。

---

### Checkpoint 2 — 故意用错误的方式运行

试试以下命令：

```bash
java Hello.class
```

> 🎯 **期望**：会报错！把报错信息贴给我。
> 这是为了让你记住：`java` 后面跟的是**类名**，不是文件名。

---

### Checkpoint 3 — 故意让文件名和类名不一致

创建一个**新文件**，文件名故意写错：

```bash
nano Wrong.java
```

输入以下内容（注意：类名是 `Right`，但文件名是 `Wrong.java`）：

```java name=Wrong.java
public class Right {
    public static void main(String[] args) {
        System.out.println("Will this work?");
    }
}
```

保存退出后，尝试编译：

```bash
javac Wrong.java
```

> 🎯 **期望**：报错！把报错信息贴给我。

---

### Checkpoint 4 — 修复它

现在把文件名改正确：

```bash
mv Wrong.java Right.java
```

然后重新编译并运行：

```bash
javac Right.java
java Right
```

> 🎯 **期望**：输出 `Will this work?`

---

## 📬 交作业

完成后，贴给我：

1. `cat Hello.class` 的输出（截一小段就行，太长不用全贴）
2. `java Hello.class` 的报错信息
3. `javac Wrong.java` 的报错信息
4. `java Right` 的输出

四样都对了，进入第 3 节！🚀
``````

