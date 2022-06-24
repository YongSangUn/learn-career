# Vbird: bash & shell scripts

## 10. 认识和学习 Bash

### 10.1 认识 bash 这个 shell

我们必须透过 【shell】 将我们输入的指令，与 `Kernel` 沟通，`kernel` 可以控制硬件来正确无误的工作。

- bash shell 的功能
  **命令维修能力 (history)**
  history 默认记录在 ~/.bash_histroy, 但是只是记录上一次登录前的命令，当前的命令被暂存在内存中，注销后，才会被记录。

**命令与文件补全功能 (tab)** - 可以少打字 - 确定输入正确

**命令别名功能（alias）**
将遗传命令简化，例如需要输入 `ls -al`, 则可以在 `.bashrc` 文件中 添加：
`alias ll='ls -al'`

**job、以及前后台作业**
详见第十六章

**shell scripts**
详见第十二章

**通配符**
详见第十三章，正则匹配。

- 查询指令是否是 bash shell 的内建命令 ： type

```bash
$ type [-tpa] name
-t :    显示 name 指令的意义。（file 外部命令，alias 或者 builtin 内建命令）
-p :    只有外部的命令时才会显示完整文件名
-a ：   由 PATH 变量定义的路径中，将所有包含 name 的指令都列出来，包含 alias
$ type ls
ls is aliased to `ls --color=auto'

# 示例
$ type -t ls
alias
$ type -a ls
ls is aliased to `ls --color=auto'
ls is /usr/bin/ls
$ type cd
cd is a shell builtin       # cd 是内建命令
$ type -p ifconfig
/usr/sbin/ifconfig
```

- 指令的下达与快速编辑按钮
  指令太长可以使用反斜杠 (\\) 换行：

```bash
$ cp /var/spool/mail/root /etc/crontab \
> /etc/fstab /root      # 将三个文件复制到 /root 目录

** 命令太长，利用的是 [ \[Enter] ] 来跳脱，使 [Enter] 不再具有 开始执行 的功能，
** 需要注意的是 (\) 紧接着必须是 [Enter] ，中间没有任何字符，例如空白 [ \ [Enter] ] ,
** 这样是错误的示范，因为 (\) 仅跳脱一个字符而已。
```

- 快速的删除错误的指令

| 组合键            | 功能与示范                                                            |
| ----------------- | --------------------------------------------------------------------- |
| [ctrl]+u/[ctrl]+k | 分别是从光标处向前删除指令串 ([ctrl]+u) 及向后删除指令串 ([ctrl]+k)。 |
| [ctrl]+a/[ctrl]+e | 分别是让光标移动到整个指令串的最前面 ([ctrl]+a) 或最后面 ([ctrl]+e)。 |

### 10.2 shell 的变量功能

变量就是以一组文字或符号等，来取代一些设定或者是一串保留的数据！ - 影响 bash 环境操作的变量
在 `Linux System` 下面，所有的线程都是需要一个执行码。系统变量 例如 PATH 等，通常用大写来表示，区别于自定义变量。 - Shell scripts 程序设计好帮手

- 变量的取用与设定：echo ， 变量的设定规则：unset

```shell
$ myname=Dragon         # 等号两边不能有空格
$ echo $myname
Dragon
$ myname="Dragon"       # 可以使用单引号或者双引号将字符串包括起来，但是单引号表
$ name='$myname'         ##示强引用，会转义所有的字符。
$ echo $name
$myname


## 可以使用 跳脱字符 [\] ，转义特殊字符。
$ var="\$abc\'\bcd\[Enter]"


## 如果命令需要使用其他 额外的命令 所提供的信息,可以使用, [` `] 或者  [$( )]
$ var=`command`
$ var=$(command)


## 若该变量为扩增变量内容时,则可用 "$变量名称" 或 ${变量} 累加内容
$ PATH="$PATH":/home/bin        # 或者
$ PATH=${PATH}:/home/bin


## 若该变量需要在其他子程序执行，则需要以 export 来使变量变成环境变量：
export PATH


## 取消变量的方法为使用 unset ：『unset 变量名称』例如取消 myname 的设定：
$ unset myname
```

- 环境变量的功能

用 env 观察环境变量与常见环境变量说明

```shell
$ env       # 列出目前的 shell 环境下的所有环境变量与其内容。
XDG_SESSION_ID=263935
HOSTNAME=DragonFlyCloud
TERM=xterm
SHELL=/bin/bash
HISTSIZE=3000                           # history 记录的历史命令数
SSH_CLIENT=114.92.38.231 9362 23139
SSH_TTY=/dev/pts/1
USER=root
......

### RANDOM 随机数变量
随机生成数字，介于 `0~32768` 之间，
$ echo $RANDOM
26957
$ echo $RANDOM
19095
# 如果想获取 0~9 之间的数， 可以利用 declare 宣告数值类型:
$ declare -i number=$RANDOM*10/32768 ; echo $number
#所有 可以生成 0~任何小于32768 之间的随机数.

### set 观察所有变量
$ set
BASH=/bin/bash                                                                  <== bash 的主程序放置路径
BASH_VERSINFO=([0]="4" [1]="2" [2]="46" [3]="1" [4]="release" [5]="x86_64-redhat-linux-gnu")
BASH_VERSION='4.2.46(1)-release'                                                <== 这两行是 bash 的版本啊！
COLUMNS=90                                                                      <== 在目前的终端机环境下，使用的字段有几个字符长度
HISTFILE=/home/dmtsai/.bash_history                                             <== 历史命令记录的放置文件， 隐藏档
HISTFILESIZE=1000                                                               <== 存起来(与上个变量有关)的文件之指令的最大纪录笔数。
HISTSIZE=1000                                                                   <== 目前环境下， 内存中记录的历史命令最大笔数。
IFS=$' \t\n'                                                                    <== 预设的分隔符
LINES=20                                                                        <== 目前的终端机下的最大行数
MACHTYPE=x86_64-redhat-linux-gnu                                                <== 安装的机器类型
OSTYPE=linux-gnu                                                                <== 操作系统的类型！
PS1='[\u@\h \W]\$ '                                                             <== PS1 就厉害了。 这个是命令提示字符，也就是我们常见的v
[root@www ~]# 或 [dmtsai ~]$ 的设定值啦！可以更动的！
PS2='> '                                                                        <== 如果你使用跳脱符号 (\) 第二行以后的提示字符也
$                                                                               <== 目前这个 shell 所使用的 PID
?                                                                               <== 刚刚执行完指令的回传值


# export 输出到环境变量
$ export 变量名
```

- locale 影响显示结果的变量

```shell
$ locale
LANG=en_US.UTF-8
LC_CTYPE="en_US.UTF-8"
LC_NUMERIC="en_US.UTF-8"
LC_TIME="en_US.UTF-8"
LC_COLLATE="en_US.UTF-8"
LC_MONETARY="en_US.UTF-8"
LC_MESSAGES="en_US.UTF-8"
LC_PAPER="en_US.UTF-8"
LC_NAME="en_US.UTF-8"
LC_ADDRESS="en_US.UTF-8"
LC_TELEPHONE="en_US.UTF-8"
LC_MEASUREMENT="en_US.UTF-8"
LC_IDENTIFICATION="en_US.UTF-8"
LC_ALL=

$ cat /etc/locale.conf
LANG="zh_CN.utf-8"
$ LANG=en_US.utf8; locale
$ export LC_ALL=en_US.utf8; locale
```

- **变量键盘读取、数组与宣告： read, array, declare**
  - read

## 12. 学习 Shell Scripts

### 12.1 什么是 shell

- 第一个脚本

```shell
$ vim hello.sh
#!/bin/bash
###############################################
# Author        : SangUn
# EMail         : SangUn.Yong@Gmail.com
# Created Time  : 2019-12-11 02:51:25
# File Name     : hello.sh
# Description   :
###############################################

echo -e "hello world! \n"
exit o
```

讨论一个命令是否成功，可以使用 `$?` 来观察，也可以利用 `exit` 命令来让程序中断，并返回一个数值给系统。

- 良好的习惯
  - script 的功能；
  - script 的版本信息；
  - script 的作者与联络方式；
  - script 的版权宣告方式；
  - script 的 History (历史纪录)；
  - script 内较特殊的指令，使用『绝对路径』的方式来下达；
  - script 运作时需要的环境变量预先宣告与设定。

### 12.2 简单的 Shell Scripts 练习
