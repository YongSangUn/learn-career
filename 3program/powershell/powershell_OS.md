<!-- TOC -->

- [powershell 操作系统相关](#powershell-操作系统相关)
    - [服务器远程配置](#服务器远程配置)
        - [空实例远程服务基础: `winrm`](#空实例远程服务基础-winrm)
        - [防火墙、脚本执行限制等](#防火墙脚本执行限制等)
        - [创建凭证](#创建凭证)
        - [远程管理](#远程管理)

<!-- /TOC -->

# powershell 操作系统相关

> 总结一些用 powershell 对操作系统调整的基础命令，提供一些脚本编写思路。

## 服务器远程配置

### 空实例远程服务基础: `winrm`

winrm服务，相当于 linux 的 ssh。

```powershell
## win-server(2016 但其他的不确定) 默认开启 winrm服务，如果没有，则需在服务器上手动开启
winrm e winrm/config/listener       # 先查看状态；如无返回信息，则是没有启动
winrm quickconfig                   # 针对winrm service 进行基础配置
Get-Service WinRM                   # 检查 WinRM 服务
Enable-PSRemoting                   # 配置系统接受远程命令,Enable-PSRemoting 命令不仅启动了 WinRM 服务，还帮我们设置好了防火墙规则。

# 未加入域的计算机，还需要进行信任设置。
Set-Item WSMan:\localhost\Client\TrustedHosts -Value * -Force
Clear-Item WSMan:\localhost\Client\TrustedHosts -Force      # 删除信任主机
Restart-Service WinRM               # 重启服务
Test-WsMan xxx.xxx.xxx.xxx          # 使用 IP 测试远程连接
```

### 防火墙、脚本执行限制等

```powershell
# 设置本机脚本执行权限
Set-ExecutionPolicy RemoteSigned -Force         # 使本机可以执行 ps1 文件
set-executionpolicy Bypass -Force               # 使本机可以执行未签名的脚本或者为脚本签名
Enable-PsRemoting -force                        # 同 winrm，也可以关闭防火墙
```

### 创建凭证

有多个命令可以远程操作服务器，但是基础都需要凭证，且网络互通，可以使用上面的 Test-WsMan 测试连通性。

```powershell
$user = "admin"
# 密码由于安全性，需要使用 ConvertTo-SecureString 通过明文的字符串创建 SecureString 对象，比如你使用一个密码字符串创建 SecureString 对象，你无法通过这个对象还原出原来的密码字符串，但是却可以把 SecureString 对象当做密码使用。
$passwd = "XXXXXXXXXXX" | ConvertTo-SecureString -asPlainText -Force        # 但是这样脚本中还是会存在明文密码
$cred = New-Object System.Management.Automation.PSCredential($user, $passwd)    # 创建凭证

# 把 SecureString 转为加密字符串
$passwd = "XXXXXXXXXXX" | ConvertTo-SecureString -asPlainText -Force
ConvertFrom-SecureString $passwd | Set-Content "D:\pwd.txt"          # 输出加密字符串到文本。

# 把加密字符串转换成 SecureString 对象
$file = "D:\pwd.txt"
$passwd = get-content $file | ConvertTo-SecureString
$SecurePwd.Length       # 可以检查密码的长度但是不能查看内容。

# 比较安全和靠谱的做法，是手动输入密码（密码会隐藏），然后转换为txt，但是不适合远程。
Read-Host "Enter Password" -AsSecureString |  ConvertFrom-SecureString | Out-File "D:\pwd.txt"


### 正确做法
# 生成并保存密码文件
Read-Host "Enter Password" -AsSecureString | ConvertFrom-SecureString | Out-File "D:\pwd.txt"
# 使用密码文件创建 Credential 信息
$f = "D:\pwd.txt"
$Cred = New-Object -TypeName System.Management.Automation.PSCredential `
    -ArgumentList UserName, (Get-Content $f | ConvertTo-SecureString)
# 这种用法也有不足之处，就是只能在生成 pwd.txt 文件的机器上使用这个文件。如果把它复制到其它的机器上，执行 Get-Content $f | ConvertTo-SecureString 时就会报错


### 高级玩法
##ConvertTo-SecureString 和 ConvertFrom-SecureString 命令都支持选项 -Key。使用 Key 可以提供额外的安全性，且允许不同环境使用。
# 生成 key
$keyFile = "D:\aes.key"
$key = New-Object Byte[] 32
[Security.Cryptography.RNGCryptoServiceProvider]::Create().GetBytes($key)
$key | out-file $keyFile
# 使用 key 生成并保存文件
Read-Host "Enter Password" -AsSecureString | ConvertFrom-SecureString -key $key | Out-File "D:\pwd.txt"
# 使用 key 和密码文件创建凭证：
$userName = "YourUserName"
$passwdFile = "D:\pwd.txt"
$keyFile = "D:\aes.key"
$key = Get-Content $keyFile
$Cred = New-Object -TypeName System.Management.Automation.PSCredential `
    -ArgumentList $userName, (Get-Content $passwdFile | ConvertTo-SecureString -Key $key)
```

### 远程管理

```powershell



```