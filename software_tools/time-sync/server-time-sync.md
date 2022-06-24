# 服务器时间同步

> 思路是与阿里云的时间服务器同步 ntp.aliyun.com

## windows 时间同步

使用 w32tm 程序

```powershell
# 更新配置，命令兼容 2008 和 2012 server.
w32tm /config `
    /manualpeerlist:"ntp.aliyun.com ntp1.aliyun.com ntp2.aliyun.com" `
    /syncfromflags:manual `
    /update

# 重启服务，或者检测服务状态
if ((Get-Service W32Time).Status -eq "Running") {
    "restart service W32Time."
    Restart-Service W32Time -Force
} else {
    "Start service W32Time."
    Start-Service W32Time
}

# 同步时间
w32tm /resync

# 验证、查询状态
w32tm /query /status
w32tm /query /peers
w32tm /query /source
w32tm /query /configuration
```
