<span id ="jump"><font size=5>目录：</font></span>
[toc]

### 一、系统监控工具

- uptime 

```bash
[root@VM_0_17_centos ~]# uptime
 20:20:54 up 13 days,  5:10,  1 user,  load average: 0.00, 0.01, 0.05
```

>显示系统时间  系统启动到现在所经过的时间   上线用户数   平均负载  

- w 查看当前系统信息  

```bash
[root@VM_0_17_centos ~]# uptime
 15:38:57 up 17 days, 28 min,  1 user,  load average: 0.16, 0.07, 0.06
[root@VM_0_17_centos ~]# w
 15:38:59 up 17 days, 28 min,  1 user,  load average: 0.16, 0.07, 0.06
USER     TTY      FROM             LOGIN@   IDLE   JCPU   PCPU WHAT
root     pts/0    180.166.10.186   15:20    3.00s  0.03s  0.00s w
```

w 显示信息的含义：

>- JCPU:     以终端代号来区分，该终端所有相关的进程的进程执行时，所消耗的CPU时间会显示在这里  
>- PCPU:   cpu执行程序消耗的时间  
WHAT:    用户下在执行的操作  
>- load average :分别显示系统在过去1、5、15分钟内的平均负载程度。  
>- FROM:  显示用户从何处登录系统，":0"的显示代表该用户时人X Windows下，打开文本模式窗口登录的  
>- IDLE:   用户闲置的时间，这是一个计时器，一旦用户执行任何操作，该计时器便会被重置  
>- **查看个别用户信息：w [用户名]**

- free 查看内存信息

```bash
[root@VM_0_17_centos ~]# free -h
total        used        free      shared  buff/cache   available
Mem:           992M        109M         80M        348K        802M        696M
Swap:            0B          0B          0B
```

> -s n 刷新间隔为n秒  
-c n 刷新n次后即退出

- pmap 显示进程对应的内存映射  

- top

```c
[root@localhost upstream]# top
top - 08:19:03 up 346 days, 16:10,  0 users,  load average: 4.28, 4.72, 5.10
Tasks: 111 total,   2 running, 109 sleeping,   0 stopped,   0 zombie
Cpu0  : 98.3%us,  0.0%sy,  0.0%ni,  0.0%id,  0.0%wa,  0.0%hi,  0.0%si,  1.7%st
Cpu1  :100.0%us,  0.0%sy,  0.0%ni,  0.0%id,  0.0%wa,  0.0%hi,  0.0%si,  0.0%st

   PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND  
    2 root      20   0     0    0    0 S    0  0.0   0:23.59 kthreadd     
    1 root      20   0  125m 5048 3284 S    0  0.3 630:47.74 systemd   
    5 root       0 -20     0    0    0 S    0  0.0   0:00.00 kworker/0:0H  
    3 root      20   0     0    0    0 S    0  0.0  12:49.94 ksoftirqd/0  
    8 root      20   0     0    0    0 S    0  0.0   0:00.00 rcu_bh  
    9 root      20   0     0    0    0 S    0  0.0 167:00.87 rcu_sched  
    10 root      RT   0     0    0    0 S    0  0.0   2:21.29 watchdog/0              7 root      RT   0     0    0    0 S    0  0.0  14:22.10 migration/0    
    12 root      RT   0     0    0    0 S    0  0.0  15:07.51 migration/1 
```

#### 命令用法

>- 交互按键
l：是否显示首部信息  
t：task及cpu信息  
数字1：CPU显示方式  
m：内存显示方式  
P：以占据CPU百分比排序  
M：以占据Memory空间大小排序  
T：CPU累积占用时间排序  
s：修改延迟时长  
k：终止指定进程  
W：保存
q：退出命令  
>- 选项  
-d #：指定刷新间隔  
-n #：指定刷新次数  
-b：全部显示  

<a href="#jump" target="_self"><p align="right">返回顶部</p></a>

### 二、进程管理工具

#### linux进程的5种状态

>>D 不可中断 uninterruptible sleep (usually IO)  
R 运行 runnable (on run queue)  
S 中断 sleeping  
T 停止 traced or stopped  
Z 僵死 a defunct (”zombie”) process  

#### pstree    查看进程树

-p:显示PID  

#### ps 查看进程

常用选项：
>-a:显示所有用户的进程  
>-u:显示用户名和启动时间  
>-x:显示 没有控制终端的进程  
>-e:显示所有进程，包括没有控制终端的进程 
>-l:长格式显示
>-w:宽行显示，可以使用多个w进行加宽显示

- ps -ef 是用标准的格式显示进程的:

```c
[root@VM_0_17_centos ~]# ps aef
  PID TTY      STAT   TIME COMMAND
10850 pts/0    Ss     0:00 -bash USER=root LOGNAME=root HOME=/root PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin MAIL=/var/mail/root SHELL=/bin/b
10925 pts/0    T      0:00  \_ man ls XDG_SESSION_ID=18773 HOSTNAME=VM_0_17_centos TERM=xterm SHELL=/bin/bash HISTSIZE=3000 SSH_CLIENT=180.166.10.186 5321
10934 pts/0    T      0:00  |   \_ less -s XDG_SESSION_ID=18773 HOSTNAME=VM_0_17_centos TERM=xterm SHELL=/bin/bash HISTSIZE=3000 SSH_CLIENT=180.166.10.186
```

>-e 显示所有进程  
>-f 选项显示进程树，相当于--forest(用ASCII字符显示树状结构，表达程序间的相互关系。 )

- ps aux 是用BSD的格式来显示

```bash
[root@VM_0_17_centos ~]# ps aux
USER       PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
root         1  0.0  0.2  41064  2872 ?        Ss   1月30   0:53 /usr/lib/systemd/systemd --system --deserialize 21
root         2  0.0  0.0      0     0 ?        S    1月30   0:00 [kthreadd]
root         3  0.0  0.0      0     0 ?        S    1月30   0:10 [ksoftirqd/0]
root         5  0.0  0.0      0     0 ?        S<   1月30   0:00 [kworker/0:0H]
root         7  0.0  0.0      0     0 ?        S    1月30   0:00 [migration/0]
root         8  0.0  0.0      0     0 ?        S    1月30   0:00 [rcu_bh]
root         9  0.0  0.0      0     0 ?        R    1月30   1:07 [rcu_sched]
root        10  0.0  0.0      0     0 ?        S    1月30   0:05 [watchdog/0]
```

>a 显示现行终端机下的所有程序，包括其他用户的程序。  
>u 以用户为主的格式来显示程序状况。  
>x 显示所有程序，不以终端机来区分。

**最常用的方法是ps -aux,然后再利用一个管道符号导向到grep去查找特定的进程,然后再对特定的进程进行操作。**

>o 属性...：选项显示定制的信息pid,cmd,%cpu,%me  

 -p pid：显示指定Pid进程  

##### 实例

- ps -u or -l  查看隶属于自己进程详细信息  
root@root:~# ps -u or -l  
- ps -le or -aux   查看所有用户执行的进程的详细信息  
root@root:~# ps le or -aux  
- ps -aux --sort pid   可按进程执行的时间、PID、UID等对进程进行排序  
root@root:~# ps -aux --sort pid  
- ps -uU fnngj 查看某个用记启动的进程  
root@root:~# ps -uU fnngj  
- ps -le | grep init 查看指定进程信息  
root@root:~# ps -le | grep init  

#### kill终止进程

- -n 指的是 信号编号

kill -l（查看Linux/Unix的信号变量）

```c
[root@VM_0_17_centos ~]# kill -l
 1) SIGHUP	 2) SIGINT	 3) SIGQUIT	 4) SIGILL	 5) SIGTRAP
 2) SIGABRT	 7) SIGBUS	 8) SIGFPE	 9) SIGKILL	10) SIGUSR1
1)  SIGSEGV	12) SIGUSR2	13) SIGPIPE	14) SIGALRM	15) SIGTERM
2)  SIGSTKFLT	17) SIGCHLD	18) SIGCONT	19) SIGSTOP	20) SIGTSTP
3)  SIGTTIN	22) SIGTTOU	23) SIGURG	24) SIGXCPU	25) SIGXFSZ
4)  SIGVTALRM	27) SIGPROF	28) SIGWINCH	29) SIGIO	30) SIGPWR
5)  SIGSYS	34) SIGRTMIN	35) SIGRTMIN+1	36) SIGRTMIN+2	37) SIGRTMIN+3
6)  SIGRTMIN+4	39) SIGRTMIN+5	40) SIGRTMIN+6	41) SIGRTMIN+7	42) SIGRTMIN+8
7)  SIGRTMIN+9	44) SIGRTMIN+10	45) SIGRTMIN+11	46) SIGRTMIN+12	47) SIGRTMIN+13
8)  SIGRTMIN+14	49) SIGRTMIN+15	50) SIGRTMAX-14	51) SIGRTMAX-13	52) SIGRTMAX-12
9)  SIGRTMAX-11	54) SIGRTMAX-10	55) SIGRTMAX-9	56) SIGRTMAX-8	57) SIGRTMAX-7
10) SIGRTMAX-6	59) SIGRTMAX-5	60) SIGRTMAX-4	61) SIGRTMAX-3	62) SIGRTMAX-2
11) SIGRTMAX-1	64) SIGRTMAX	
```

上面标注了每一个编号对应的含义,常用的就是下面两个：

```c
9) SIGKILL  
15) SIGTERM
```

**关闭进程(-15为正常关闭，有可能会被忽略；-9是强制性，直接关闭)** 

- >kill -15 [进程号]   （正常关闭，程序先释放自己的资源后关闭）  
kill -s 9 [进程号]  （强行关闭）  
kill -9   [进程号]  （强行关闭）  

- 重启进程  
kill -1 [进程号]  

>其它：  
结束所有进程：    killall  
查找服务进程号： pgrep  [服务名称]  
关闭进程：          pkill    [进程名称]  

<a href="#jump" target="_self"><p align="right">返回顶部</p></a>

#### 一些特殊目录

```c
[root@VM_0_17_centos proc]# ls /proc/
1     2083   263    504   8          execdomains  locks         stat
10    2088   27     505   874        fb           mdstat        swaps
12    216    28     508   9          filesystems  meminfo       sys
13    21676  29     509   97         fs           misc          sysrq-trigger
1327  22107  3      551   acpi       interrupts   modules       sysvipc
14    22564  30463  555   buddyinfo  iomem        mounts        timer_list
15    22638  338    556   bus        ioports      mtrr          timer_stats
1572  235    365    562   cgroups    irq          net           tty
16    237    367    60    cmdline    kallsyms     pagetypeinfo  uptime
17    238    37     697   consoles   kcore        partitions    version
18    239    388    7     cpuinfo    keys         sched_debug   vmallocinfo
19    241    39     702   crypto     key-users    schedstat     vmstat
2     25     40     703   devices    kmsg         scsi          zoneinfo
2064  257    41     7484  diskstats  kpagecount   self
2076  26     480    7496  dma        kpageflags   slabinfo
2082  262    5      7507  driver     loadavg      softirqs
```

上面的编号就是以**进程PID命名**的目录。  
这个目录比较特殊，他并不在我们磁盘上，而在我们的内存当中；当前系统运行的所有进程都动态的存放在这个目录中。  
**目录中的其他系统信息**

>- 当前CPU的信息
>
>```c
>root@root:~# cat /proc/cpuinfo
> ```
>
> - 查看内存信息  
>
> ```c
> root@root:~# cat /proc/meminfo
> ```
>
> - 查看当前分区的信息
>
> ```c
> root@root:~# cat /proc/partitions
> ```

#### 进程的优先级
系统在执行程序的时候会有先后顺序，可以同时运行很多程序；是因为cpu的运算极快，把每个程序排好队后，这个执行以下，那个执行一下。所以，看似各种程序是并行运行的。  

>- 优先级取值范围（-20，19)

>>默认为0，-20的优先级最高。

- nice 指定程序的运行优先级

>nice -n command

- renice 改变一个正在运行的程序的优先级

>renice -n pid  例如： 
>
>```c
>[root@bogon cron]# ps -le
>[root@bogon cron]# renice -20  [PID]
>```

- nohup 可以在用户退出时继续执行某一进程

一般的命令在用户退出后就停止执行，nohup可以使进程在用户退出登录后仍旧继续执行，nohup命令将执行后的数据信息和错误信息默认存储到文件nohup.out中
>nohup program & 例： 

```c
 [root@bogon cron]# nohup find / -name init* > /hzh/test/find.init.20120520 &
```

- 进程的挂起与恢复  
进程太慢或者输出内容太多，最常用的做法就是  
终止（ctrl+c）；或者  
挂起（ctrl+z），就是暂停。

>系统中有两种运行的进程，我们在前台是看不到的。一种是后台执行的命令，一种就是被暂停的。  
> > 查看被挂起的进程（jobs）
> > - 恢复到前台继续运行（fg）例：
> >
> >```c
> > [root@VM_0_17_centos ~]# jobs
> > [1]+  已停止               vim 0python_work/7while.py
> > [root@VM_0_17_centos ~]# fg %1
> > ```
> >
>>- 恢复到后台继续运行（bg）

<a href="#jump" target="_self"><p align="right">返回顶部</p></a>

### 三、计划任务

通常对系统进行一些操作时，不需要即时的去做，例如备份日志数据，会占用大量的系统资源，所以为了不影响用户使用，会在夜间访问量很少的时候操作。  

>- at 安排作业在某一时刻执行一次
>- batch 安排作业在系统负荷不重的时候执行一次
>- cron 安排周期性的运行作业

#### 一次性计划at&batch

- **at命令指定时间的方式**

>- 绝对计时方法

midnight noon teatime  
hh:mm [today]  
hh:mm tomorrow  
hh:mm 星期  
hh:mm MM/DD/YY  

>- 相对计时方法

now+n minutes  
now+n days

实例：  

```bash
[root@VM_0_17_centos ~]# at now+3 minutes
at>
```

at>后输入任务（可以输入多个任务），ctrl+d保存计划。

- 查看任务计划是否启动：  

```c
# at -l
# atq
```

- 删除at计划任务

```bash
[root@bogon test]# at -d
```

- 查看at计划任务

```bash
[root@bogon test]# ls /var/spool/at/
```

- **batch命令**  
作用：
安排一个或多个命令在系统负载较轻进运行一次（一般情况下负载较轻指平均负载降到0.8以下），用法同at。  

#### 周期性计划命令crontab

>**crontab语法：**  
crontab [-u username] [-l|-e|-r]  
选项与参数：  
-u  ：只有 root 才能进行这个任务，亦即帮其他使用者创建/移除 crontab 工作排程；  
-e  ：编辑 crontab 的工作内容  
-l  ：查阅 crontab 的工作内容  
-r  ：移除所有的 crontab 的工作内容，若仅要移除一项，请用 -e 去编辑    

##### crontab -e

规则：  
把知道的具体的时间添上，不知道的都添加上*  
每项工作 (每行) 的格式都是具有六个栏位，这六个栏位的意义为：

代表意义|分钟|小时|日期|月份|周|命令
---|---|---|---|---|---|---
数字范围|0-59|0-23|1-31|1-12|0-7|就命令啊

比较有趣的是那个『周』喔！周的数字为 0 或 7 时，都代表『星期天』的意思！另外， 还有一些辅助的字符，大概有底下这些：  

特殊字符|代表意义
---|---
*(星号)|代表任何时刻都接受的意思！举例来说，范例一内那个日、月、周都是 * ， 就代表著『不论何月、何日的礼拜几的 12:00 都运行后续命令』的意思！  
,(逗号)|代表分隔时段的意思。举例来说，如果要下达的工作是 3:00 与 6:00 时，就会是：<br>`0 3,6 * * * command`<br>时间参数还是有五栏，不过第二栏是 3,6 ，代表 3 与 6 都适用！  
-(减号)|代表一段时间范围内，举例来说， 8 点到 12 点之间的每小时的 20 分都进行一项工作：<br>20 8-12 * * * command<br>仔细看到第二栏变成 8-12 喔！代表 8,9,10,11,12 都适用的意思！
/n(斜线)|那个 n 代表数字，亦即是『每隔 n 单位间隔』的意思，例如每五分钟进行一次，则：<br>*/5 * * * * command<br>很简单吧！用 * 与 /5 来搭配，也可以写成 0-59/5 ，相同意思！

分钟 | 小时 | 天 | 月 | 星期 | 命令/脚本  
---|---|---|---|---|---
*|*|*|*|*|[具体操作]
01 |10 |05 |06| 3| echo "ok" > /root/cron.log

上述的意思就是在6月5日（这一天必须是星期3）的10点01分执行命令 `$ echo "ok" > /root/cron.log`  

>crontab -e 实际上是打开了 “/var/spool/cron/username” （如果是root则打开的是/var/spool/cron/root）这个文件。使用的是vim编辑器，所以要保存的话则在命令模式下输入:wq即可。  
但是，你千万不要直接去编辑那个文件，因为可能会出错，所以一定要使用 crontab -e 来编辑。

```bash
[root@VM_0_17_centos ~]# crontab -e
01 10 05 06 3 echo "ok" > /root/cron.log
#出现crontab: installing new crontab 表示创建计划成功
```

> - 有可能出现下面的报错
>
> ```c
> [root@VM_0_17_centos ~]# crontab -e
> /bin/sh: /usr/bin/vi: 没有那个文件或目录
> crontab: "/usr/bin/vi" exited with status 127
> ```
>
> 出错原因：  
> vim已替代了vi，机器上执行vi时一般是alias到vim，而crontab仍是调用vi，则显示报错。  
> 解决方法1：安装vi
>
> ```bash
> $ yum install vim-minimal -y
> ```
>
> 解决方法2：设置 vim 为默认编辑器
>
> ```c
> $ echo "export EDITOR=vim" >> ~/.bashrc
> $ source ~/.bashrc
> ```

查看已经设定的任务计划使用`crontab  -l` 命令:  

```bash
[root@localhost ~]# crontab -l
01 10 05 06 3 echo "ok" > /root/cron.log
```

删除计划任务要用 `crontab -r`

```bash
[root@localhost ~]# crontab -r
[root@localhost ~]# crontab -l
no crontab for root
```

<a href="#jump" target="_self"><p align="right">返回顶部</p></a>

