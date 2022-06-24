# awk 简明教程

[toc]

提取 netstat 的部分信息：

```bash
[root@sangun test]# cat netstat.txt
oecv-Q Send-Q Local-Address          Foreign-Address             State
tcp        0      0 0.0.0.0:3306           0.0.0.0:*                   LISTEN
tcp        0      0 0.0.0.0:80             0.0.0.0:*                   LISTEN
tcp        0      0 127.0.0.1:9000         0.0.0.0:*                   LISTEN
tcp        0      0 coolshell.cn:80        124.205.5.146:18245         TIME_WAIT
tcp        0      0 coolshell.cn:80        61.140.101.185:37538        FIN_WAIT2
tcp        0      0 coolshell.cn:80        110.194.134.189:1032        ESTABLISHED
tcp        0      0 coolshell.cn:80        123.169.124.111:49809       ESTABLISHED
tcp        0      0 coolshell.cn:80        116.234.127.77:11502        FIN_WAIT2
tcp        0      0 coolshell.cn:80        123.169.124.111:49829       ESTABLISHED
tcp        0      0 coolshell.cn:80        183.60.215.36:36970         TIME_WAIT
tcp        0   4166 coolshell.cn:80        61.148.242.38:30901         ESTABLISHED
tcp        0      1 coolshell.cn:80        124.152.181.209:26825       FIN_WAIT1
tcp        0      0 coolshell.cn:80        110.194.134.189:4796        ESTABLISHED
tcp        0      0 coolshell.cn:80        183.60.212.163:51082        TIME_WAIT
tcp        0      1 coolshell.cn:80        208.115.113.92:50601        LAST_ACK
tcp        0      0 coolshell.cn:80        123.169.124.111:49840       ESTABLISHED
tcp        0      0 coolshell.cn:80        117.136.20.85:50025         FIN_WAIT2
tcp        0      0 :::22                  :::*                        LISTEN

```

> 单引号中被{} 括着的就是**awk**语句，**只能被单引号包含。** > $1..$n 表示第几列。注：\$0 表示整行。

## 简单输出特定行

```bash
[root@sangun test]# awk '{print $1,$4}' netstat.txt
oecv-Q Foreign-Address
tcp 0.0.0.0:3306
tcp 0.0.0.0:80
tcp 127.0.0.1:9000
tcp coolshell.cn:80
tcp coolshell.cn:80
tcp coolshell.cn:80
tcp coolshell.cn:80
tcp coolshell.cn:80
tcp coolshell.cn:80
tcp coolshell.cn:80
tcp coolshell.cn:80
tcp coolshell.cn:80
tcp coolshell.cn:80
tcp coolshell.cn:80
tcp coolshell.cn:80
tcp coolshell.cn:80
tcp coolshell.cn:80
tcp :::22
```

- 再来看看 awk 的格式化输出，和 C 语言的 printf 没什么两样：

```bash
[root@sangun test]# awk '{printf "%-8s %-8s %-8s %-18s %-22s %-15s\n",$1,$2,$3,$4,$5,$6}' netstat.txt
oecv-Q   Send-Q   Local-Address Foreign-Address    State
tcp      0        0        0.0.0.0:3306       0.0.0.0:*              LISTEN
tcp      0        0        0.0.0.0:80         0.0.0.0:*              LISTEN
tcp      0        0        127.0.0.1:9000     0.0.0.0:*              LISTEN
tcp      0        0        coolshell.cn:80    124.205.5.146:18245    TIME_WAIT
tcp      0        0        coolshell.cn:80    61.140.101.185:37538   FIN_WAIT2
tcp      0        0        coolshell.cn:80    110.194.134.189:1032   ESTABLISHED
tcp      0        0        coolshell.cn:80    123.169.124.111:49809  ESTABLISHED
tcp      0        0        coolshell.cn:80    116.234.127.77:11502   FIN_WAIT2
tcp      0        0        coolshell.cn:80    123.169.124.111:49829  ESTABLISHED
tcp      0        0        coolshell.cn:80    183.60.215.36:36970    TIME_WAIT
tcp      0        4166     coolshell.cn:80    61.148.242.38:30901    ESTABLISHED
tcp      0        1        coolshell.cn:80    124.152.181.209:26825  FIN_WAIT1
tcp      0        0        coolshell.cn:80    110.194.134.189:4796   ESTABLISHED
tcp      0        0        coolshell.cn:80    183.60.212.163:51082   TIME_WAIT
tcp      0        1        coolshell.cn:80    208.115.113.92:50601   LAST_ACK
tcp      0        0        coolshell.cn:80    123.169.124.111:49840  ESTABLISHED
tcp      0        0        coolshell.cn:80    117.136.20.85:50025    FIN_WAIT2
tcp      0        0        :::22              :::*                   LISTEN
```

## 过滤记录

（下面过滤条件为：第三列的值为 0 && 第 6 列的值为 LISTEN）

```shell
[root@sangun test]# awk '$3==0 && $6=="LISTEN"' netstat.txt
tcp        0      0 0.0.0.0:3306           0.0.0.0:*                   LISTEN
tcp        0      0 0.0.0.0:80             0.0.0.0:*                   LISTEN
tcp        0      0 127.0.0.1:9000         0.0.0.0:*                   LISTEN
tcp        0      0 :::22                  :::*                        LISTEN
```

- '=='为过滤条件,比较运算符：!=,>,<.>=,<=

### 各种过滤条件

```bash
[root@sangun test]# awk '$3>=1 {print $0}' netstat.txt
oecv-Q Send-Q Local-Address          Foreign-Address             State
tcp        0   4166 coolshell.cn:80        61.148.242.38:30901         ESTABLISHED
tcp        0      1 coolshell.cn:80        124.152.181.209:26825       FIN_WAIT1
tcp        0      1 coolshell.cn:80        208.115.113.92:50601        LAST_ACK
```

- 如果我们需要表头的话，我们可以引入内建变量 NR：

```bash
[root@sangun test]# awk '$3==0 && $6=="LISTEN" || NR==1 ' netstat.txt
oecv-Q Send-Q Local-Address          Foreign-Address             State
tcp        0      0 0.0.0.0:3306           0.0.0.0:*                   LISTEN
tcp        0      0 0.0.0.0:80             0.0.0.0:*                   LISTEN
tcp        0      0 127.0.0.1:9000         0.0.0.0:*                   LISTEN
tcp        0      0 :::22                  :::*                        LISTEN
```

#### 内建变量

[8 Powerful Awk Built-in Variables – FS, OFS, RS, ORS, NR, NF, FILENAME, FNR](https://www.thegeekstuff.com/2010/01/8-powerful-awk-built-in-variables-fs-ofs-rs-ors-nr-nf-filename-fnr/)

| \$0      | en 示意                                               | 当前记录（这个变量中存放着整个行的内容）                                        |
| -------- | ----------------------------------------------------- | ------------------------------------------------------------------------------- |
| $1~$n    |                                                       | 当前记录的第 n 个字段，字段间由 FS 分隔                                         |
| FS       | Input field separator                                 | 输入字段分隔符 默认是空格或 Tab                                                 |
| NF       | Number of Fields in a record                          | 当前记录中的字段个数，就是有多少列                                              |
| NR       | Number of Records                                     | 已经读出的记录数，就是行号，从 1 开始，如果有多个文件话，这个值也是不断累加中。 |
| FNR      | Number of Records relative to the current input file  | 当前记录数，与 NR 不同的是，这个值会是各个文件自己的行号                        |
| RS       | record separator                                      | 输入的记录分隔符， 默认为换行符                                                 |
| OFS      | output field separator                                | 输出字段分隔符， 默认也是空格                                                   |
| ORS      | output record separator                               | 输出的记录分隔符，默认为换行符                                                  |
| FILENAME | Name of the current input file                        | 当前输入文件的名字                                                              |
| \$NF     | the last field in a record can be represented by \$NF |                                                                                 |

### awk_tips

## awk 中调用外部变量方法

1. `awk '{print a, b}' a=111 b=222 yourfile`
   变量位置必须要 file 名之前，否则不能调用，例如：
   `awk '{print a, b}' a=111 file1 b=222 file2`
   - file1 不能调用 `b=222`,
   - 于 BEGIN{} 中是不能调用这些的 variable. 要用之后所讲的第二种方法才可解决.
2. `awk –v a=111 –v b=222 ‘{print a,b}’ yourfile`
   注意, 对每一个变量加一个 –v 作传递.
3. `awk ‘{print “’”$LOGNAME”’”}’ yourfile`
   如果想调用 environment variable, 要用以上的方式调用, 方法是:(我加上空格让大家容易明白)
   `“ ‘ “ $LOGNAME “ ‘ “`

- 实例：

```bash
#!/bin/bash
#此作用列出文件名称中以日期开头，并且小于某个日期的文件名称。一般可以用于删除一些日志文件的筛选
curdate=20110715
Filename=`ls -l|awk -v cdate=$curdate 'NR!=1 && $8<cdate {print $8}'`
echo $Filename
```

### 数组

可以用来存储一组变量，awk 中所有的数组都是关联数组，意味着它的下标可以是一个字符串也可以是一个数字。

```bash
array[index] = value

# 使用 for 循环来读取所有元素
for (item in array)

# 数组的下标由 item 来确定，使用 array[item] 测试元素的值，也可以使用 delete删除。
# 统计每个用户的进程的占了多少内存（注：sum的RSS那一列）
$ ps aux | awk 'NR!=1{a[$1]+=$6;} END { for(i in a) print i ", " a[i]"KB";}'
dbus, 540KB
mysql, 99928KB
www, 3264924KB
root, 63644KB
hchen, 6020KB
```
