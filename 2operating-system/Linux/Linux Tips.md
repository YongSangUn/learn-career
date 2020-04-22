<span id ="jump"><font size=5>目录：</font></span>

[toc]

<a href="#bottom" target="_self"><p align="right"><u>前往底部</u></p></a>

# 工具源码

## vim

>git clone https://github.com/vim/vim.git

## Vundle

>git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim  
:PluginInstall

## molokai配色

>git clone https://github.com/tomasr/molokai.git  

可直接放入配色路径：
>/usr/local/vim81/share/vim/vim81/colors  

然后在.vimrc文件中加入：

```bash
#选择molokai配色
colorscheme molokai
set t_Co=256
set background=light
```

<a href="#jump" target="_self"><p align="right">返回顶部</p></a>

## ./configure 清除  

如果configure出错，先用make distclean清除之前configure产生的文件再configure。  
可以不指定VIMRUNTIMEDIR，则只要执行make就好。  
```make clean```  
清除上次的make命令所产生的object文件（后缀为“.o”的文件）及可执行文件。  
```make distclean```  
类似make clean，但同时也将configure生成的文件全部删除掉，包括Makefile。  

<a href="#jump" target="_self"><p align="right">返回顶部</p></a>

## Linux跨机器文件相互拷贝 ：scp

例如有两台机器 ：

```c
A：192.168.17.100  B：192.168.17.101 
```

- 目标是把   A：/root/*  cp到    B:/root/localA   中  
  - 在B中操作 ，A下载到B  

  ```c
  scp root@192.168.17.100:/root/* /root/localA  
  ```

  - 在A中操作，A发送到B 

  ```c
  # scp /root/*  
  root@192.168.17.101:/root/localA  
  ```

观察得出 就是从
scp /源文件路径/ /目标路径  
路径中 包括 ： username@ip:/路径/  
然后输入root用户的密码即可  

默认是22端口 如果是其他端口，需要-P参数  

```c
# scp -P 32764 /root/*  root@192.168.17.101:/root/localA  
```

- scp启用压缩

```bash
scp -P port -C ufile user@host:~/ufile
```

```bash
scp -P port -r udir/ user@host:~/
```

<a href="#jump" target="_self"><p align="right">返回顶部</p></a>

## tar详解  

-c: 建立压缩档案  
-x：解压  
-t：查看内容  
-r：向压缩归档文件末尾追加文件  
-u：更新原压缩包中的文件  
这五个是独立的命令，压缩解压都要用到其中一个，可以和别的命令连用但只能用其中一个。下面的参数是根据需要在压缩或解压档案时可选的。  
-z：有gzip属性的  
-j：有bz2属性的  
-Z：有compress属性的  
-v：显示所有过程  
-O：将文件解开到标准输出  
下面的参数-f是必须的  
-f: 使用档案名字，切记，这个参数是最后一个参数，后面只能接档案名。  

```c
# tar -cf all.tar *.jpg  
```

这条命令是将所有.jpg的文件打成一个名为all.tar的包。-c是表示产生新的包，-f指定包的文件名。  

```bash
# tar -rf all.tar *.gif  
```

这条命令是将所有.gif的文件增加到all.tar的包里面去。-r是表示增加文件的意思。  

```bash
# tar -uf all.tar logo.gif  
```

这条命令是更新原来tar包all.tar中logo.gif文件，-u是表示更新文件的意思。  

```bash
# tar -tf all.tar  
```

这条命令是列出all.tar包中所有文件，-t是列出文件的意思  

```bash
# tar -xf all.tar  
```

这条命令是解出all.tar包中所有文件，-t是解开的意思  
> >
> 常用
> ```
> tar -zcvf  xxx.tar.gz  test
> tar -zxvf  xxx.tar.gz
> ```

<a href="#jump" target="_self"><p align="right">返回顶部</p></a>

## 查看各文件夹大小:

```bash
# du -h --max-depth=1
```

--max-depth=n表示只深入到第n层目录，此处设置为0，即表示不深入到子目录。.

<a href="#jump" target="_self"><p align="right">返回顶部</p></a>
  
## 更改Linux的系统语言

```bash
# echo $LANG            /查看当前系统语言
# locale -a | grep zh_CN        /查看系统是否安装了中文简体语言包
# yum install kde-l10n-Chinese  /如果上面的没有安装则yum安装下，在检查下是否安装。
# LANG="zh_CN.UTF-8"    /临时修改为中文
# LANG="en_US.UTF-8"    /临时修改为英文  

# vi /etc/locale.conf   /增加一行LANG=zh_CN.UTF-8即永久修改
更改完后更新下配置即可。
# source /etc/locale.conf 
```

<a href="#jump" target="_self"><p align="right">返回顶部</p></a>

## 解决linux下退格时，出现\^H\^H\^H\^H的问题

第一个办法  
输入命令：

```c
#  stty erase ^?
```

第二个办法：  
把stty erase ^? 添加到.bash_profile中。

```c
# echo stty erase ^? >> /root/.bash_profile
```

<a href="#jump" target="_self"><p align="right">返回顶部</p></a>

## JVM 三大性能调优参数-Xms -Xmx -Xss

**堆设置：**  

- Xmx   最大Heap的大小。 (最大可用内存)
- Xms   初始的Heap的大小。  
- Xss   规定了每个线程堆栈的大小。一般情况下256K是足够了。影响了此进程中并发线程数大小。  

>在很多情况下，-Xms和-Xmx设置成一样的。这么设置，是因为当Heap不够用时，会发生内存抖动，影响程序运行稳定性

<a href="#jump" target="_self"><p align="right">返回顶部</p></a>

## 更改计算机hostname

- 使用hostnamectl 查看主机信息：

```bash
[root@VM_0_17_centos sysconfig]# hostnamectl
   Static hostname: VM_0_17_centos
         Icon name: computer-vm
           Chassis: vm
        Machine ID: f9d400c5e1e8c3a8209e990d887d4ac1
           Boot ID: 4106fad59f5147c7b7a0393d9f17e785
    Virtualization: kvm
  Operating System: CentOS Linux 7 (Core)
       CPE OS Name: cpe:/o:centos:centos:7
            Kernel: Linux 3.10.0-514.26.2.el7.x86_64
      Architecture: x86-64
```

- 使用hostnamectl的set-hostname命令设置主机名。

```bash
[root@VM_0_17_centos sysconfig]# hostnamectl set-hostname sangun
[root@VM_0_17_centos sysconfig]# hostnamectl 
   Static hostname: sangun
         Icon name: computer-vm
           Chassis: vm
        Machine ID: f9d400c5e1e8c3a8209e990d887d4ac1
           Boot ID: 4106fad59f5147c7b7a0393d9f17e785
    Virtualization: kvm
  Operating System: CentOS Linux 7 (Core)
       CPE OS Name: cpe:/o:centos:centos:7
            Kernel: Linux 3.10.0-514.26.2.el7.x86_64
      Architecture: x86-64
```

- 设置瞬态主机名

```bash
hostnamectl set-hostname --transient transientName
```

- 设置静态主机

```c
hostnamectl set-hostname --static  staticName
```

>单独设置静态主机名，设置静态主机名为永久修改主机名，重启机器不会影响。  
设置静态主机名实际是会修改/etc/hostname文件的主机名，系统重启时会读取/etc/hostname来初始化内核主机名。

- 只想修改特定的主机名（静态，瞬态或灵活），你可以使用“--static”，“--transient”或“--pretty”选项。
- 要永久修改主机名，你可以修改静态主机名：  
`$ sudo hostnamectl --static set-hostname <host-name>`

<a href="#jump" target="_self"><p align="right">返回顶部</p></a>

## centos7修改ssh默认登陆端口

- 查看默认端口22

```bash
[root@sangun ~]# netstat -ntlp |grep ssh
tcp        0      0 0.0.0.0:22              0.0.0.0:*               LISTEN      22732/sshd
```

- 开放2个端口 默认的22以及需要修改的端口 （防止修改后无法登陆）

```bash
[root@sangun ~]# vim /etc/ssh/sshd_config
...
# SELinux about this change.
# semanage port -a -t ssh_port_t -p tcp #PORTNUMBER
Port 22
Port 23139   /添加新端口号
#AllowUsers root@172.20.0.106
#ALLowUsers coracle@172.20.0.106
#AllowUsers root@192.168.5.193
...
```

- 重启ssh服务 service sshd restart 或者/etc/init.d/sshd restart  第一个不行就换第二个

```c
[root@sangun ~]# service sshd restart 
Redirecting to /bin/systemctl restart sshd.service
```

- 查看监听端口  

```c
[root@sangun ~]# netstat -ntpl |grep ssh
tcp        0      0 0.0.0.0:22              0.0.0.0:*               LISTEN      6409/sshd       tcp        0      0 0.0.0.0:23139           0.0.0.0:*               LISTEN      6409/sshd
```

- 编辑防火墙配置：vi /etc/sysconfig/iptables  添加2018端口  

`-A INPUT -m state --state NEW -m tcp -p tcp --dport 2018 -j ACCEPT`
> centos7默认最小安装，需要手动安装iptables
> 因此/etc/sysconfig/iptables不存在，没有安装iptables防火墙。  
> 可以通过以下命令安装iptables防火墙：  

```c
systemctl  stop firewalld
systemctl mask firewalld
service iptables status /找到不到
yum install iptables-services   /安装
service iptables status   /找得到了
systemctl enable iptables//设置开机启动
```

- 重启iptables  

```c
[root@centos-linux-7 parallels]# service iptables restart
Redirecting to /bin/systemctl restart iptables.service
```  

- 测试

```c
[root@sangun ~]# ssh -p23139 root@62.234.73.88
root@62.234.73.88's password: 
```

- 关闭22端口和防火墙  并重启相关服务`service sshd restart` 和 `service iptables restart `
- 确认端口  `netstat -tnpl |grep ssh`
- 完成

<a href="#jump" target="_self"><p align="right">返回顶部</p></a>

## 删除空文件

```c
$ find . -name "*" -type f -size 0c | xargs -n 1 rm -f
```

## centos7 安装 mysql

- 下载 MySQL 所需要的安装包网址：  
https://dev.mysql.com/downloads/mysql/  
Select Operating System: 选择 Red Hat ，CentOS 是基于红帽的，Select OS Version: 选择 linux 7，  
选择 RPM Bundle 点击 Download。

- rpm -qa | grep mariadb 命令查看 mariadb 的安装包  
rpm -e 卸载
- 安装目录 /usr/local/mysql
- `tar -xvf mysql-8.0.11-1.el7.x86_64.rpm-bundle.tar`

```c
rpm -ivh mysql-community-common-8.0.11-1.el7.x86_64.rpm --nodeps --force 命令安装 common
rpm -ivh mysql-community-libs-8.0.11-1.el7.x86_64.rpm --nodeps --force 命令安装 libs
rpm -ivh mysql-community-client-8.0.11-1.el7.x86_64.rpm --nodeps --force 命令安装 client
rpm -ivh mysql-community-server-8.0.11-1.el7.x86_64.rpm --nodeps --force 命令安装 server
rpm -qa | grep mysql 
```

- 完成对 mysql 数据库的初始化和相关配置

```c
mysqld --initialize;
chown mysql:mysql /var/lib/mysql -R;
systemctl start mysqld.service;
systemctl  enable mysqld;
```

- cat /var/log/mysqld.log | grep password 命令查看数据库的密码
- mysql -uroot -p 敲回车键进入数据库登陆界面
- ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'root'; 命令来修改密码
- 通过以下命令，进行远程访问的授权

```c
create user 'root'@'%' identified with mysql_native_password by 'root';
grant all privileges on *.* to 'root'@'%' with grant option;
flush privileges;
```

- 命令修改加密规则，MySql8.0 版本 和 5.0 的加密规则不一样，而现在的可视化工具只支持旧的加密方式。  
ALTER USER 'root'@'localhost' IDENTIFIED BY 'root' PASSWORD EXPIRE NEVER;
- flush privileges;
命令刷新修该后的权限

- 关闭 firewall
systemctl stop firewalld.service;
systemctl disable firewalld.service;
systemctl mask firewalld.service;

- yum -y install iptables-services
- 通过以下命令启动设置防火墙
systemctl enable iptables;
systemctl start iptables;

- vim /etc/sysconfig/iptables 命令编辑防火墙，添加端口
- 在相关位置，写入以下内容

```c
-A INPUT -m state --state NEW -m tcp -p tcp --dport 80 -j ACCEPT
-A INPUT -m state --state NEW -m tcp -p tcp --dport 3306 -j ACCEPT
-A INPUT -m state --state NEW -m tcp -p tcp --dport 443 -j ACCEPT
-A INPUT -m state --state NEW -m tcp -p tcp --dport 8080 -j ACCEPT
-A INPUT -m state --state NEW -m tcp -p tcp --dport 8090 -j ACCEPT
```

![image](https://img-blog.csdn.net/20180702105636833?watermark/2/text/aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MjI2NjYwNg==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70)

- systemctl restart iptables.service
重启防火墙使配置生效

- 通过 systemctl enable iptables.service 命令设置防火墙开机启动

## ntpdate 同步时间

```c
ntpdate cn.pool.ntp.org
```
timedatectl set-timezone Asia/Shanghai          # 设置时区

注意：如果会出现以下提示：no server suitable for synchronization found
加入-u参数，来同步时间

```c
ntpdate -u cn.pool.ntp.org
```

- 定时任务

```c
[root@node1 ~]# crontab -e
# 每过半个小时同步一次
0 */30 * * * /usr/sbin/ntpdate -u cn.pool.ntp.org > /dev/null 2>&1; /sbin/hwclock -w
```

- 配置开启启动校验  
vim /etc/rc.d/rc.local,在文件末尾添加如下内容

```c
/usr/sbin/ntpdate -u cn.pool.ntp.org> /dev/null 2>&1; /sbin/hwclock -w
```

## 字体颜色

PS1的常用参数如下：  

复制代码  
\d ：#代表日期，格式为weekday month date，例如："Mon Aug 1"  
\H ：#完整的主机名称  
\h ：#仅取主机的第一个名字  
\t ：#显示时间为24小时格式，如：HH：MM：SS  
\T ：#显示时间为12小时格式  
\A ：#显示时间为24小时格式：HH：MM  
\u ：#当前用户的账号名称  
\v ：#BASH的版本信息  
\w ：#完整的工作目录名称  
\W ：#利用basename取得工作目录名称，所以只会列出最后一个目录  
\# ：#下达的第几个命令  
\$ ：#提示字符，如果是root时，提示符为：# ，普通用户则为：$  
复制代码  
颜色值设置： PS1中设置字符颜色的格式为：  
\e[F;Bm  
，其中“F“为字体颜色，编号为30-37，“B”为背景颜色，编号为40-47。颜色表如下  

复制代码  
F       B  
30      40      黑色  
31      41      红色  
32      42      绿色  
33      43      黄色  
34      44      蓝色
35      45      紫红色  
36      46      青蓝色  
37      47      白色  

## ssh修改端口后启动失败

关闭selinux

```shell
查看SELinux状态：
1、/usr/sbin/sestatus -v      ##如果SELinux status参数为enabled即为开启状态
SELinux status:                 enabled
2、getenforce                 ##也可以用这个命令检查
关闭SELinux：
1、临时关闭（不用重启机器）：
setenforce 0                  ##设置SELinux 成为permissive模式
                              ##setenforce 1 设置SELinux 成为enforcing模式
2、修改配置文件需要重启机器：
修改/etc/selinux/config 文件
将SELINUX=enforcing改为SELINUX=disabled
重启机器即可
```

# 脚本修改密码

```bash
$ echo "mytest" | passwd --stdin mytest
# 标记为红色的部分就是密码.passwd使用--stdin选项的意思是告诉passwd命令从标准输入读取新的密码.通过前面的管道读取标准输入.
--stdin
This option is used to indicate that passwd should read the new password from standard input, which can be a pipe.
```

<a href="#jump" target="_self"><p align="right">返回顶部</p></a>

<span id="bottom"></span>