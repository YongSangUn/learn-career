<span id ="jump"><font size=5>目录：</font></span>
[toc]

### 一、安装依赖包

```bash
[root@sangun ~]# yum -y install centos-release-scl \
gcc-c++ \
ncurses-devel \
python-devel
```

```bssh
yum install -y ruby ruby-devel lua lua-devel luajit \
luajit-devel ctags python-devel python3-devel tcl-devel \
perl perl-devel perl-ExtUtils-ParseXS perl-ExtUtils-XSpp \
perl-ExtUtils-CBuilder perl-ExtUtils-Embed
```

- 上需要这一步来纠正安装 XSubPP 时出现的问题：

从 /usr/bin 到 perl 目录做个 xsubpp (perl) 的符号链接

```bash
ln -s /usr/bin/xsubpp /usr/share/perl5/ExtUtils/xsubpp
```

### 二、卸载旧版本

```bash
# 查询已安装的vim包
[root@sangun ~]# rpm -qa | grep vim
vim-minimal-7.4.160-5.el7.x86_64
vim-enhanced-7.4.160-5.el7.x86_64
vim-filesystem-7.4.160-5.el7.x86_64
vim-common-7.4.160-5.el7.x86_64
# 删除对应的vim包
[root@sangun ~]# rpm -e `rpm -qa |grep vim` --nodeps
``` 

>--nodeps 忽略依赖关系

编译参数说明

```bash
-–with-features=huge			//支持最大特性
-–enable-rubyinterp				//打开对ruby编写的插件的支持
-–enable-pythoninterp			//打开对python编写的插件的支持
-–enable-python3interp			//打开对python3编写的插件的支持
-–enable-luainterp				//打开对lua编写的插件的支持
-–enable-perlinterp				//打开对perl编写的插件的支持
-–enable-multibyte				//打开多字节支持，可以在Vim中输入中文
-–enable-cscope				    //打开对cscope的支持
-–with-python-config-dir=/usr/lib64/python2.7/config 指定		//python 路径
-–with-python-config-dir=/usr/lib64/python3.5/config 指定		//python3路径
```

```bash
./configure --with-features=huge --enable-multibyte --enable-rubyinterp=yes --enable-python3interp=yes --with-python3-config-dir=/usr/local/python3.5.1/lib/python3.5/config-3.5m --enable-perlinterp=yes --enable-luainterp=yes --enable-gui=gtk2 --enable-cscope --prefix=/usr/local/vim81
```

<a href="#jump" target="_self">返回目录</a>
