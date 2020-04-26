# 获取真实 ipv4 地址

目的是想在 windows 上获取正确的 ip。

## python

这样获取 ip 地址是绝对正确的，但是需要安装 python，对于 windows 用户来说有局限。
linux 自带，所以推荐 linux 使用。

请参考的博文：<https://www.chenyudong.com/archives/python-get-local-ip-graceful.html>

- 不推荐：靠猜测去获取本地 IP 方法
- 不推荐：通过 hostname 来获取本机 IP
- 通过 UDP 获取本机 IP，目前见过最优雅的方法

通过 UDP 获取本机 IP，目前见过最优雅的方法:

> 这个方法是目前见过最优雅获取本机服务器的 IP 方法了。没有任何的依赖，也没有去猜测机器上的网络设备信息。
> 而且是利用 UDP 协议来实现的，生成一个 UDP 包，把自己的 IP 放如到 UDP 协议头中，然后从 UDP 包中获取本机的 IP。
> 这个方法并不会真实的向外部发包，所以用抓包工具是看不到的。但是会申请一个 UDP 的端口，所以如果经常调用也会比较耗时的，这里如果需要可以将查询到的 IP 给缓存起来，性能可以获得很大提升。

```python
# 可以在命令行获取，因为不会真的发送包，所以连接 ip 地址和端口都可以随意。
python -c "import socket;print([(s.connect(('8.8.8.8', 0)), s.getsockname()[0], s.close()) for s in [socket.socket(socket.AF_INET, socket.SOCK_DGRAM)]][0][1])"

# 可以封装成函数，方便 Python 的程序调用
import socket

def get_host_ip():
    try:
        s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
        s.connect(('8.8.8.8', 80))
        ip = s.getsockname()[0]
    finally:
        s.close()

    return ip
```

## powershell

我的目的是想通过原生的环境来找到正确的 ip ，但是还是可能会有缺点。

如果想要正确的获取，还是推荐 windows 安装 python ，使用 python 实现。

### 单网卡

如果是单网卡可以使用下面的命令：(如果是多个网卡(包括虚拟网卡)的话，还是推荐使用路由表)

```powershell
# ipconfig
PS C:\> (ipconfig | select-string "IPv4" | out-string).Split(":")[-1].Trim()
# 调用 wmi
PS C:\> (Get-WmiObject win32_networkadapterconfiguration -filter "ipenabled = 'true'").IPAddress -notlike "*:*"

# 通过 cmdlet 调用的方法还有很多，实现大同小异，当有多个虚拟网卡时，会不匹配。
```

### 路由表实现

> 目前测试下来没有问题，可以解决多个虚拟网卡的干扰，但是多个网卡未测试。

实现是通过 路由表 的方法实现，具体可以 google or baidu : windows 路由表。

```powershell
# 使用的 查询路由表中的数据
PS C:\> ((route print |findstr "0.0.0.0.*0.0.0.0") -replace "\s{2,}", " ").split()[4]
```

- 实现原理：

```powershell
# 首先调用 route print 查看所有列表：
PS C:\> route print
...
...
IPv4 Route Table
===========================================================================
Active Routes:
Network Destination        Netmask          Gateway       Interface  Metric
          0.0.0.0          0.0.0.0      192.168.7.1      192.168.7.4    261
        127.0.0.0        255.0.0.0         On-link         127.0.0.1    306
        127.0.0.1  255.255.255.255         On-link         127.0.0.1    306
  127.255.255.255  255.255.255.255         On-link         127.0.0.1    306
...
...
===========================================================================
Persistent Routes:
  Network Address          Netmask  Gateway Address  Metric
          0.0.0.0          0.0.0.0      192.168.7.1  Default
...
...

# 我们只需要关注 这两行，一个是 ipv4 路由表 和 静态路由表。
参数描述：
    Network Destination:    目的网段
    Netmask:                子网掩码，与目的网段共同定义了此条路由适用的网络地址
    Gateway:                网关，又称下一跳路由器，在发送IP数据包时，网关定义了针对特定的网络目的地址，数据包发送到的下一跳服务器
    Interface:              接口，接口定义了针对特定的网络目的地址，本地计算机用于发送数据包的网络接口
    Metric:                 跳数，跳数用于指出路由的成本，通常情况下代表到达目标地址所需要经过的跳跃数量，一个跳数代表经过一个路由器。跳数越低，代表路由成本越低，优先级越高
    Persistent Routes:      手动配置静态路由

# 下一步使用 findstr 找出 真实IP地址所在行，"0.0.0.0.*0.0.0.0" .*
PS C:\> route print | findstr "0.0.0.0.*0.0.0.0"
          0.0.0.0          0.0.0.0      192.168.7.1      192.168.7.4    261
          0.0.0.0          0.0.0.0      192.168.7.1     Default

# 后面字符去除多余空格,"\s{2,} "会把2个及以上的空格、制表符、换行符，都替换成 " "
PS C:\> (route print | findstr "0.0.0.0.*0.0.0.0") -replace "\s{2,}", " "
 0.0.0.0 0.0.0.0 192.168.7.1 192.168.7.4 261 0.0.0.0 0.0.0.0 192.168.7.1 Default

# 最后按空格筛选
PS C:\> ((route print | findstr "0.0.0.0.*0.0.0.0") -replace "\s{2,}", " ").split()[4]
192.168.7.4
```

## cmd

powershell 就是参考 cmd 的 bat 想出来的，dos 没什么研究，代码网络收集，具体出处忘了，供参考：

```powershell
## bat 脚本：
PS C:\> gc ip.bat
@echo off
for /f "tokens=4" %%a in ('route print^|findstr 0.0.0.0.*0.0.0.0') do (
 set IP=%%a
)
echo %IP%

# cmd 单行执行
c:\> for /f "tokens=4 " %i in ('route print^|findstr "0.0.0.0.*0.0.0.0"') do @echo %i

## 但是上面的有静态路由的时候会多出来字符串。
# 用 powershell 优化一下，调用 cmd 单行执行
PS C:\> cmd /c "FOR /F "tokens=4 " %i in ('route print^|findstr "0.0.0.0.*0.0.0.0"') do @echo %i" | Select-Object -Index 0
```
