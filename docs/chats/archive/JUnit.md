User-1:
``````text
请教我junit(我是junit初学者,我的PC是debian),我希望类似codecademy那样的极小微代码项目每个小节,(一开始讲解然后是作业,对于作业请给我每一步要做什么风格就像codecademy一样,它的作业风格类似一个作业拆分成多个检查点每个检查点都有明确的指令指向去引导我完成,每个小节完成了我把作业给你检查,你不要一小节太多东西,我的水平很差可能接受不了,我们开始第一个小节,什么时候毕业你下定论
``````
Model-1:
``````markdown
# JUnit 学习计划 🎓

欢迎！我会像 Codecademy 那样，用**极小步骤**带你从零学会 JUnit。

我帮你规划了完整的学习路线，一共大约 **12 个小节**，全部完成就「毕业」🎉

---

## 📋 课程大纲（总览）

| 小节 | 主题 |
|------|------|
| 1 | 环境搭建 + 第一个测试 |
| 2 | `@Test` 注解到底是什么 |
| 3 | `assertEquals` 断言 |
| 4 | 多个测试方法 |
| 5 | `assertNotEquals` / `assertTrue` / `assertFalse` |
| 6 | 测试一个你自己写的类 |
| 7 | `@BeforeEach` 准备工作 |
| 8 | `assertThrows` 测试异常 |
| 9 | `@AfterEach` 清理工作 |
| 10 | `@DisplayName` 让测试更可读 |
| 11 | `assertAll` 分组断言 |
| 12 | 毕业项目：完整测试一个小程序 |

---

# 📘 小节 1：环境搭建 + 第一个测试

## 讲解

JUnit 是 Java 世界里最流行的**测试框架**。

什么是测试？简单说：
> 你写了一段代码，你想**自动检查**它对不对，而不是每次都用眼睛看 `System.out.println` 的输出。

JUnit 就是帮你做这件事的工具。

我们先不搞复杂的 Maven/Gradle，用**最原始的方式**跑起来，这样你能理解底层发生了什么。

---

## 🏋️ 作业

### ✅ 检查点 1：确认 Java 已安装

打开终端，输入：

```bash
java -version
```

你应该看到类似 `openjdk version "17.x.x"` 的输出。

> 如果没有，运行 `sudo apt update && sudo apt install default-jdk -y` 来安装。

---

### ✅ 检查点 2：创建项目文件夹

在终端中运行以下命令：

```bash
mkdir -p ~/junit-course/lesson01
cd ~/junit-course/lesson01
```

---

### ✅ 检查点 3：下载 JUnit 的 jar 文件

我们需要两个 jar 文件。运行：

```bash
curl -L -o junit-platform-console-standalone.jar https://repo1.maven.org/maven2/org/junit/platform/junit-platform-console-standalone/1.10.2/junit-platform-console-standalone-1.10.2.jar
```

这一个 jar 里面**已经包含了**运行 JUnit 5 测试所需的一切。

---

### ✅ 检查点 4：创建你的第一个测试文件

用你喜欢的编辑器（`nano`、`vim`、`code` 都行）创建文件：

```bash
nano FirstTest.java
```

输入以下内容（**一个字都不要改**）：

```java name=FirstTest.java
import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.assertEquals;

class FirstTest {

    @Test
    void onePlusOneIsTwo() {
        assertEquals(2, 1 + 1);
    }
}
```

保存退出。

---

### ✅ 检查点 5：编译测试

在终端运行：

```bash
javac -cp junit-platform-console-standalone.jar FirstTest.java
```

如果**没有任何输出**，说明编译成功 ✅。

---

### ✅ 检查点 6：运行测试

```bash
java -jar junit-platform-console-standalone.jar --class-path . --scan-class-path
```

你应该看到输出中包含类似这样的内容：

```
✔ onePlusOneIsTwo
1 tests successful
```

---

## 📝 你需要交给我的东西

完成以上 6 个检查点后，把以下内容发给我：

1. `java -version` 的输出
2. 运行测试那一步（检查点 6）的**完整终端输出**

我来帮你检查，通过了我们就进入**小节 2** 🚀
``````

---

User-2:
``````text
~/junit-course/lesson01 via java v21.0.10 on aws (us-east-1)
> java -jar junit-platform-console-standalone.jar --class-path . --scan-class-path

💚 Thanks for using JUnit! Support its development at https://junit.org/sponsoring

╷
├─ JUnit Jupiter ✔
│  └─ FirstTest ✔
│     └─ onePlusOneIsTwo() ✔
├─ JUnit Vintage ✔
└─ JUnit Platform Suite ✔

Test run finished after 177 ms
[         4 containers found      ]
[         0 containers skipped    ]
[         4 containers started    ]
[         0 containers aborted    ]
[         4 containers successful ]
[         0 containers failed     ]
[         1 tests found           ]
[         0 tests skipped         ]
[         1 tests started         ]
[         0 tests aborted         ]
[         1 tests successful      ]
[         0 tests failed          ]


WARNING: Delegated to the 'execute' command.
         This behaviour has been deprecated and will be removed in a future release.
         Please use the 'execute' command directly.

~/junit-course/lesson01 via java v21.0.10 on aws (us-east-1)
> java -version
openjdk version "21.0.10" 2026-01-20
OpenJDK Runtime Environment (build 21.0.10+7-Debian-1deb13u1)
OpenJDK 64-Bit Server VM (build 21.0.10+7-Debian-1deb13u1, mixed mode, sharing)
``````
Model-2:
``````markdown
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
