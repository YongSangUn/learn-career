<span id ="jump"><font size=5>目录：</font></span>

[toc]

<a href="#bottom" target="_self"><p align="right"><u>前往底部</u></p></a>

- 官方安装说明：

```c
https://git-scm.com/book/zh/v2/起步-安装-Git
```

- 下载安装包

```c
$ wget -O git-2.20.1.tar.gz https://github.com/git/git/archive/v2.20.1.tar.gz
```

- 安装依赖包

```c
$ yum install -y curl-devel expat-devel gettext-devel openssl-devel zlib-devel
# 为了能够添加更多格式的文档（如 doc, html, info），你需要安装以下的依赖包：
$ yum install -y asciidoc xmlto docbook2x
$ yum install -y autoconf automake libtool
# 软链接
$ sudo ln -s /usr/bin/db2x_docbook2texi /usr/bin/docbook2x-texi
$ sudo ln -s /usr/bin/db2x_docbook2man /usr/bin/docbook2x-man
```

- 安装

```c
$ tar -zxf git-2.20.1.tar.gz
$ cd git-2.20.1
$ make configure
$ ./configure --prefix=/usr/local/git2.20.1
$ make all doc info
$ sudo make install install-doc install-html install-info
```

- 安装完成后,因为安装 `gettext-devel` yum会自动安装 `yum 1.8.3.1`, 简单处理下

```c
$ ls /usr/bin/git*
git  git-receive-pack  git-shell  git-upload-archive  git-upload-pack
# 把原本的git备份下
$ cd /usr/bin && mkdir bak && mv git* bak/ && mv bak/ git_bak/
# 然后再从/usr/local/git2.20.1/bin/ 创建软链到 /usr/bin/
$ for file in `ls -1 /usr/local/git2.20.1/bin/`;do ln -s /usr/local/git2.20.1/bin/$file /usr/bin/$file ;done
```

- 查看版本

```c
$ git --version
git version 2.20.1
```

<a href="#jump" target="_self"><p align="right"><u>返回顶部</u></p></a>
<span id="bottom"></span>










