<span id ="jump"><font size=5>目录：</font></span>
[toc]

## 一、查看磁盘或目录的容量 df和du

### df：查看已挂载磁盘的总容量、使用容量、剩余容量等。

>常用参数有:  
–i （使用inodes显示结果）  
-h(合适的单位)  
-k –m（分别用K，M）等；

```c
[root@nginx-1-180 ~]# df -h
Filesystem      Size  Used Avail Use% Mounted on
/dev/xvda2      112G  104G  8.8G  93% /
devtmpfs        1.9G     0  1.9G   0% /dev
tmpfs           1.9G   12K  1.9G   1% /dev/shm
tmpfs           1.9G  209M  1.7G  12% /run
tmpfs           1.9G     0  1.9G   0% /sys/fs/cgroup
tmpfs           377M     0  377M   0% /run/user/0
You have new mail in /var/spool/mail/root
```

<a href="#jump" target="_self"><p align="right">返回顶部</p></a>

### du: 用来查看某个目录所占空间大小

du [-abckmsh] [文件或者目录名] 
>参数说明：  
>-a：全部文件与目录大小都列出来。如果不加任何选项和参数只列出目录（包含子目录）大小。

```shell
[root@VM_0_17_centos ~]# du test/
4	test/file1/file2
8	test/file1
12	test/
[root@VM_0_17_centos ~]# du -a test/
0	test/file1/file2/2.txt
4	test/file1/file2
0	test/file1/1.txt
8	test/file1
12	test/
```

-b：列出的值以bytes为单位输出，默认是以Kbytes  
-c：结尾输出总空间占用量  
-k：以KB为单位输出  
-m：以MB为单位输出  
-s：显示每个参数的总空间占用量  
-h：以人类易读的方式输出结果  
-Bx     以x指定的单元作为单位计算空间占用情况，如-BM,则以1M为单位进行显示  

- 查看磁盘空间惯用法：

```shell
[root@VM_0_17_centos ~]# df -h 
文件系统        容量  已用  可用 已用% 挂载点
/dev/vda1        50G  4.3G   43G   10% /
devtmpfs        487M     0  487M    0% /dev
tmpfs           497M   24K  497M    1% /dev/shm
tmpfs           497M  332K  496M    1% /run
tmpfs           497M     0  497M    0% /sys/fs/cgroup
tmpfs           100M     0  100M    0% /run/user/0
[root@VM_0_17_centos ~]# du -sc -BM /root/*
1M	/root/0python_work
588M	/root/1file
1M	/root/test
589M	总用量
[root@VM_0_17_centos ~]# du -sh /root/*
92K	/root/0python_work
588M	/root/1file
12K	/root/test
```

- 按照大小排序：

```shell
du -s * | sort -nr    #-h参数会影响排序，所以不加
du -s * | sort -nr |  head  #选出排在前面的10个，
du -s * | sort -nr |  tail  #选出排在后面的10个。
```

- 查看各文件夹大小:

```bash
# du -h --max-depth=1
```

--max-depth=n表示只深入到第n层目录，此处设置为0，即表示不深入到子目录。

<a href="#jump" target="_self"><p align="right">返回顶部</p></a>
