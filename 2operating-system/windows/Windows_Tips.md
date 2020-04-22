<span id="jump"><font size=5>目录：</font></span>
[toc]

### windows 中.msc 文件详解

**devmgmt.msc**：设备管理器程序，当需要更改硬件设置或升级硬件驱动程序的时候就可以运行它，可以直接打开“设备管理器”对话框，管理计算机中的硬件设备，且用这种方法打开显然比在“系统属性”对话框中打开方便多了。
**dfrg.msc**：磁盘碎片整理程序，磁盘上的碎片多了影响计算机的性能，所以这个命令用的比较多，它可以整理各个分区中的碎片。和依次点击“开始-所有程序-附件-系统工具-磁盘碎片整理程序”所完成的效果一样。
**compmgmt.msc**：计算机管理程序，可以对本机的“共享文件夹”、“用户”、“硬件”以及后台服务进行管理。
**diskmgmt.msc**：磁盘管理程序，可以为分区更改“驱动器名和路径，有些时候重装系统后会发现分区名称变了，或光驱的名称跑到硬盘分区的前面去了，这时硬盘管理程序就可以派上用场了。
**gpedit.msc**：组策略，可以进行“计算机配置”和“用户配置”，对操作系统熟练后，且此命令会比较多，初学者可以打开看看以熟悉其中的项目，在不清楚具体功能的情况下不建议随意更改设置，以免损坏系统。
**certmgr.msc** 证书服务
**ciadv.msc** 索引服务
**eventvwr.msc** 事件查看器
**fsmgmt.msc** 共享文件夹
**lusrmgr.msc** 本地用户和组
**ntmsmgr.msc** 可移动存储
**ntmsoprq.msc** 可移动存储管理员操作请求
**perfmon.msc** 计算机性能
**rsop.msc** 组策略的结果集
**secpol.msc** 本地安全设置
**services.msc** 服务
**wmimgmt.msc** Windows 管理体系结构(WMI)

> _mgmt:management 管理员_

### 查看 windows 开机时间

- cmd 中运行 systeminfo
- windows 日志中筛选 ID 为 6005 的事件

<a href="#jump" target="_self"><p align="right"><u>返回顶部</u></p></a>

### 使用 Windows 命令行启动关闭服务(net,sc 用法)

- net 用于打开没有被禁用的服务

```c
net start 服务名
net stop 服务名
```

> 注意:服务名是服务名称

- 用 sc 可打开被禁用的服务。(也可以查看服务状态)可以创建服务、删除服务、打开与关闭服务

```c
sc config 服务名 start= demand     //手动
sc config 服务名 start= auto       //自动
sc config 服务名 start= disabled //禁用
sc start 服务名　　开启服务
sc stop 服务名　　停止服务
sc query 服务名　　查看服务状态
sc  delete  服务名    删除服务
sc qc 服务名      查看服务的配置信息
sc create scname binPath=xxx.exe　　创建服务
```

### 如何取消远程桌面连接时“记住密码”？

- 开始-运行
- 输入：control userpasswords2
- 高级->管理密码
- 删掉对应的服务器

<a href="#jump" target="_self"><p align="right"><u>返回顶部</u></p></a>
