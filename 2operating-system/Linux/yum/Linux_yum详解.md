<span id ="jump"><font size=5>目录：</font></span>

[toc]

> **yum**（全称为 Yellow dog Updater, Modified）,是一个在Fedora和RedHat以及SUSE中的Shell前端软件包管理器。  基於RPM包管理，能够从指定的服务器自动下载RPM包并且安装，可以自动处理依赖性关系，并且一次安装所有依赖的软体包，无须繁琐地一次次下载、安装。yum提供了查找、安装、删除某一个、一组甚至全部软件包的命令，而且命令简洁而又好记。

### 安装

```bash
yum install             全部安装
yum install package1    安装指定的安装包package1
yum groupinsall group1  安装程序组group1
```

### 更新和升级

```bash
yum update              全部更新
yum update package1     更新指定程序包package1
yum check-update        检查可更新的程序
yum upgrade package1    升级指定程序包package1
yum groupupdate group1  升级程序组group1
```

### 查找和显示

```bash
yum info package1       显示安装包信息package1
yum list                显示所有已经安装和可以安装的程序包
yum list package1       显示指定程序包安装情况package1
yum groupinfo group1    显示程序组group1信息
yum search string       根据关键字string查找安装包
```

### 删除程序

```bash
yum remove &#124; erase package1    删除程序包package1
yum groupremove group1              删除程序组group1
yum deplist package1                查看程序package1依赖情况
```

### 清除缓存

```bash
yum clean packages      清除缓存目录下的软件包
yum clean headers       清除缓存目录下的 headers
yum clean oldheaders    清除缓存目录下旧的 headers
yum clean, yum clean all (= yum clean packages; yum clean oldheaders) 
清除缓存目录下的软件包及旧的headers
```

### 删除过去版本

```bash
以上子命令是如下工作的：如果我们有 5 个事务——V，W，X，Y 和 Z，其中分别是安装各个软件包的。
yum history undo 2    #将删除软件包 W
yum history redo 2    #将重新安装软件包 W 
yum history rollback 2    #将删除软件包 X、 Y 和 Z
```

<a href="#jump" target="_self"><p align="right">返回顶部</p></a>









