# grep sed awk 部分基础原理解析

[toc]

> 本文参考：
> 陈皓叔的 [CoolShell SED 简明教程](https://coolshell.cn/articles/9104.html)
> 以及 《O'Reilly sed & awk 2nd Edition》。

理解 grep sed awk 三个文字处理工具的基本原理和共通之处，目前处于学习阶段，不一定面面俱到，理解错误和疏漏之处，还请指出、开放交流。

本文需要对三个工具有一定的使用基础，不会过多的叙述命令的基础指令。

## 共同点

- 相似的语法
- 都是面向字符流，从文本中一次一行读取，将输出直接送到标准输出流
- 都使用正则表达式进行匹配
- 都允许用户在脚本中指定指令

而这么多的共同点原因之一是，它们都起源与行处理器--ed。

sed 和 grep 起源于 ed，awk 起源于 sed 和 grep 而不是 ed，之所以这么说可以往后看。

## 行处理器 ed 简述

ed (editor), 交互式编辑器，具体使用可以查看[菜鸟教程](https://www.runoob.com/linux/linux-comm-ed.html)，这里不再过多叙述 ed 使用。

可以来看看 **ed 的几个处理示例**，其中包含一定的个人理解，如果有问题欢迎指正。

### 基本的语法模块

基本的模式可以简化为：

```linux
[address] [command]
```

`address` 又可以定义为地址区间（也就是行的区间）：`[address1,address2]`（逗号分隔），所以 `address` 确定 `command` 的执行范围。

执行过程是：先匹配 `address1`，后执行 `command`，然后在持续执行到 `address2`，`address 1, 2` 有任意一个不匹配都会抛出异常。

### address 的几种指定方式

`d` 命令表示删除行。

- 用数字来表示具体的行数，例如 `1,3d`，表示删除 1-3 行 (首行和尾行分别用 数字 `1` 和 `$` 表示)。
- 使用正则表达式 `/regular/` 来匹配地址，例如 `/name/d`，表示匹配到 `name` 所在行并删除。
- 使用 `g` 表示全局命令，例如 `g/reguler/d`，表示删除 匹配到 `/regular/` 的所有行。

### 替换命令 s

通过替换命令的模式里加深下理解，模式如下：

`[address]s/pattern/replacement/flag`

不指定 `address` 的话，只处理当前行，`parrern` 是一个正则表达式，`relacement` 表示 替换行中出现的 `pattern`，`falg` 可以理解为处理行中出现 `pattern` 的范围，不指定则只处理出现的第一个，g 表示替换所有出现的 `pattern`。

> `falg` 中的 `g` 区别于 `[address]` 中的 `g`。开始出的 `g` 表示全局，意味着对所有地址执行。结尾出的 `g` 是一个标志，意味着改变一行上的每个出现，不只是第一个。

看几个示例：

```linux
# 用 complex 替代当前行中出现的第一个 regulr
s/regular/complex/

# 用 complex 替代 1-3 行中出现的所有 regulr，这里的 g 区别于 地址中的 g。
1,3s/regular/complex/g

# 在包含 regular expression 的任意行上，用 complex 替换 regular。
g/regular expression/s/regular/complex/g
```

## grep

在 `ed` 中有诸多的命令实现各种各样的功能，包括上述提到的 删除命令 `d`，替换命令 `s`, 而 `p` 表示打印。

`grep` 就 来源于 `ed` 的全局命令：

```linux
g/re/p
# 它表示 “全局正则表达式打印”。

# 下面的命令就表示从 world 文件中打印所有匹配 country 的行。
grep 'country' world
```

## sed
