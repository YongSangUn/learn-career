# python tips

[toc]

## linux 下查看 Python 的安装路径

```python
>>> import sys
>>> print sys.path      # python2

>>> print(sys.path)    # python3
```

## Linux 粘贴代码时会出现格式和注释错乱

解决办法：
在粘贴前先设置进入粘贴插入模式，即不会自动缩进和连续注释

```shell
set paste
# 下方会有一个插入（粘贴）模式
set nopaste
# 退出，为了方便设置快捷键:
set pastetoggle=<F9>

# 这样直接在插入模式按 F9 就会在“-- 插入 --”模式和“-- 插入（粘贴） --”模式中切换
```

## python3 安装依赖包

```shell
yum -y install zlib zlib-devel
yum -y install bzip2 bzip2-devel
yum -y install ncurses ncurses-devel
yum -y install readline readline-devel
yum -y install openssl openssl-devel
yum -y install openssl-static
yum -y install xz lzma xz-devel
yum -y install sqlite sqlite-devel
yum -y install gdbm gdbm-devel
yum -y install tk tk-devel
yum -y install libffi libffi-devel
yum -y install gcc make
```

## windows python2，3 共存

- 安装 pyhton2 以及 3
- 添加 path 环境变量

```powershell
C:\Python37\;C:\Python37\Scripts\;C:\Python27\;C:\Python27\Scripts\;
```

> 这里 python3 的环境变量在 python2 的上方，使用 pip -V 时会发现使用的时 上方的 pip ，也就是 pip3。

- 修改 2 个版本的可执行文件名称

```powershell
C:\Python37\python.exe  --> C:\Python37\python3.exe
C:\Python37\pythonw.exe --> C:\Python37\pythonw3.exe
```

这样在命令行中就可以
使用 `python` 打开 python2，
使用 `python3` 打开 python3。

- 最后重新归置一下 pip
  分别强制重新安装

```powershell
python2 -m pip install --upgrade pip --force-reinstall
python3 -m pip install --upgrade pip --force-reinstall
```

- 验证 pip

```powershell
PS D:\2Git\notes> pip2 -V
pip 19.2.2 from C:\python27\lib\site-packages\pip (python 2.7)
PS D:\2Git\notes> pip3 -V
pip 19.2.2 from c:\python37\lib\site-packages\pip (python 3.7)
```

## vscode 配置 python

- 安装插件
  python 、Visual Studio IntelliCode（智能补全）
- 选择解释器
  `Ctrl + Shift + P` 输入 `Python：Select Interpreter` 并选择使用哪一个解释器。
- 配置智能补全优化
  `setting.json` 中添加以优化补全：

```vscode
"python.autoComplete.extraPaths": [
    "C:\\python38\\",
    "C:\\python38\\Lib",
    "C:\\python38\\Lib\\site-packages",
    "C:\\python38\\Dlls",
```

- pip 安装插件

```c
pip3 install yapf
pip3 install flake8

# setting.json 中添加
"python.formatting.provider": "yapf",
"python.linting.flake8Enabled": true,
```

## Centos 卸载 python

```shell
# python
rpm -qa|grep python|xargs rpm -e --allmatches --nodeps
whereis python|xargs rm -frv

mkdir /usr/local/src/python && cd /usr/local/src/python

wget http://vault.centos.org/7.2.1511/os/x86_64/Packages/python-2.7.5-34.el7.x86_64.rpm && \
wget http://vault.centos.org/7.2.1511/os/x86_64/Packages/python-iniparse-0.4-9.el7.noarch.rpm && \
wget http://vault.centos.org/7.2.1511/os/x86_64/Packages/python-pycurl-7.19.0-17.el7.x86_64.rpm && \
wget http://vault.centos.org/7.2.1511/os/x86_64/Packages/python-devel-2.7.5-34.el7.x86_64.rpm && \
wget http://vault.centos.org/7.2.1511/os/x86_64/Packages/python-libs-2.7.5-34.el7.x86_64.rpm && \
wget http://vault.centos.org/7.2.1511/os/x86_64/Packages/python-urlgrabber-3.10-7.el7.noarch.rpm && \
wget http://vault.centos.org/7.2.1511/os/x86_64/Packages/rpm-python-4.11.3-17.el7.x86_64.rpm

# rpm -ivh python-* rpm-python-*
# 如果上面的出现依赖关系，则使用下面的忽略。
rpm -ivh python-* rpm-python-* --nodeps --force

# yum
rpm -qa|grep yum|xargs rpm -e --allmatches --nodeps
# rm -rf /etc/yum.repos.d/*
whereis yum|xargs rm -fr

mkdir /usr/local/src/yum && cd /usr/local/src/yum

wget http://vault.centos.org/7.2.1511/os/x86_64/Packages/yum-3.4.3-132.el7.centos.0.1.noarch.rpm && \
wget http://vault.centos.org/7.2.1511/os/x86_64/Packages/yum-metadata-parser-1.1.4-10.el7.x86_64.rpm && \
wget http://vault.centos.org/7.2.1511/os/x86_64/Packages/yum-plugin-fastestmirror-1.1.31-34.el7.noarch.rpm

rpm -ivh yum-*

wget -O $yum_dir"CentOS-Base.repo" https://mirrors.163.com/.help/CentOS7-Base-163.repo
yum -y update && yum clean all && yum makecache
```

## 更换 pip 源

### pip 切换阿里云

```python
### 方法一：pip直接执行
pip config set global.trusted-host mirrors.aliyun.com
pip config set global.index-url https://mirrors.aliyun.com/pypi/simple

### 方法二：创建文件
mkdir ~/.pip
vim ~/.pip/pip.conf

# 然后将下面这两行复制进去就好了

[global]
index-url = https://mirrors.aliyun.com/pypi/simple

#--------------------------------------------------------------------
国内其他 pip 源

    清华：https://pypi.tuna.tsinghua.edu.cn/simple
    中国科技大学 https://pypi.mirrors.ustc.edu.cn/simple/
    华中理工大学：http://pypi.hustunique.com/
    山东理工大学：http://pypi.sdutlinux.org/
    豆瓣：http://pypi.douban.com/simple/

```

### 获取本机真实 ip

```python
# 通过 udp 抓取包头部
python -c "import socket;print([(s.connect(('8.8.8.8', 0)), s.getsockname()[0], s.close()) for s in [socket.socket(socket.AF_INET, socket.SOCK_DGRAM)]][0][1])"
```
