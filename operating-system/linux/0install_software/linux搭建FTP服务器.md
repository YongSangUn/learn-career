# centos7 搭建ftp 服务器

- 安装程序

```shell
$ yum install -y vsftpd
$ service vsftpd start      # 可以默认 21 端口匿名访问
$ systemctl enable vsftpd   # 设置开机启动
```

- 配置设置

```shell
# 目前只研究了主配置文件，搭建了一个简单的内网使用的 FTP 服务器。
$ cat /etc/vsftpd/vsftpd.conf | grep -v "^#"             主配置文件
anonymous_enable=YES            # 允许你用户访问，所有有关 匿名用户的设置，都需要这个选项 YES 才会生效
anon_world_readable_only=YES    # 匿名用户只能读取文件
local_enable=YES
write_enable=YES
local_umask=022
dirmessage_enable=YES
xferlog_enable=YES
connect_from_port_20=YES
xferlog_std_format=YES
listen=NO
listen_ipv6=YES

pam_service_name=vsftpd
userlist_enable=YES
tcp_wrappers=YES

use_localtime=YES               # 文件上传时间等于用户本地时间
```
