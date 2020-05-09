# powershell

```powershell
# mountvol 删除驱动号
mountvol [<Drive>:]<Path> /d
mountvol D: /d

# 驱动器号从Y更改为Z。
Set-Partition -DriveLetter Y -NewDriveLetter Z
# 删除盘符
Remove-Partition -DriveLetter Y
# 获取所有盘符
[Environment]::GetLogicalDrives()


# 设置盘符大小

Resize-Partition -DiskNumber 0 -PartitionNumber 2 -Size (80GB)
#Get the partition sizes.
$size = (Get-PartitionSupportedSize -DiskNumber 0 -PartitionNumber 2)
#Resize to the maximum size.
Resize-Partition -DiskNumber 0 -PartitionNumber 2 -Size $size.SizeMax

#This example creates a new partition on disk 1, using the maximum available space, and automatically assigning a drive letter.:、

ew-Partition -DiskNumber 0 -UseMaximumSize -NewDriveLetter D

# 获取凭证
$c = Get-Credential     # 弹出输入账户和密码
Get-WmiObject Win32_DiskDrive -ComputerName Server01 -Credential $c
Enter-PSSession -ComputerName Server01 -Port 90 -Credential Domain01\User01
Enter-PSSession -HostName UserA@LinuxServer02:22 -KeyFilePath c:\<path>\userAKey_rsa
Enter-PSSession :
连接到远程服务器失败，错误消息如下: WinRM 客户端无法处理该请求。如果身份验证方案与 Kerberos 不同，或
者客户端计算机未加入到域中， 则必须使用 HTTPS 传输或者必须将目标计算机添加到 TrustedHosts 配置设置。
使用 winrm.cmd 配 置 TrustedHosts。请注意，TrustedHosts 列表中的计算机可能未经过身份验证。

上一般都是说要添加一个TrustedHosts表，相当于一个信任列表。
执行如下命令，将IP为192.168.3.*的主机都加入信任列表
Set-Item wsman:\localhost\Client\TrustedHosts -value 192.168.3.*
注意这个命令需要在 客户端上执行 不是在服务端执行 且客户端需要已管理员权限执行，这一点许多教程没有说，走了不少弯路。
之后再用 Enter-PSSession 192.168.3.1 -Credential abc\administrator 命令就可以完成连接了。


# 格式化输出
"{0}`t{1,-15}{2,-15}{3,-15}" -f "Locale", "Jar", "HelpSet", "Exception"

Get-ChildItem $pshome | ForEach-Object -Process {if (!$_.PSIsContainer) {$_.Name; $_.Length / 1024; " " }}
此命令获取PowerShell安装目录中的文件和目录$pshome，并将它们传递给ForEach-Objectcmdlet。如果对象不是目录，则脚本块获取文件的名称，将其Length属性的值除以1024，然后添加一个空格（“”）将其与下一个条目分开。该cmdlet使用PSISContainer属性确定对象是否为目录。

$Events = Get-EventLog -LogName System -Newest 1000
$events | ForEach-Object -Begin {Get-Date} -Process {Out-File -FilePath Events.txt -Append -InputObject $_.Message} -End {Get-Date}
此命令从系统事件日志中获取1000个最新事件，并将它们存储在$Events变量中。然后，它将事件通过管道传递到ForEach-Objectcmdlet。


bindings属性是一个集合，因此您必须使用ExpandProperty参数：
Get-Website -Name "Default Web Site" | select -ExpandProperty Bindings
要进一步深化：
get-website -name "Default Web Site" | select -ExpandProperty Bindings | Select -ExpandProperty Collection

获取属性值
Get-Module -ListAvailable | ForEach-Object -MemberName Path
Get-Module -ListAvailable | Foreach Path


将模块名称拆分为组件名称
"Microsoft.PowerShell.Core", "Microsoft.PowerShell.Host" | ForEach-Object {$_.Split(".")}
"Microsoft.PowerShell.Core", "Microsoft.PowerShell.Host" | ForEach-Object -MemberName Split -ArgumentList "."
"Microsoft.PowerShell.Core", "Microsoft.PowerShell.Host" | Foreach Split "."
Microsoft
PowerShell
Core
Microsoft
PowerShell
Host
这些命令将两个点分隔的模块名称拆分为它们的组件名称。这些命令调用字符串的Split方法。这三个命令使用不同的语法，但是它们是等效的并且可以互换。


问：我想把对象导出到xml如何做？
答：
Get-Process | Export-Clixml -Path a:\abc.xml
问：反过来从xml导入呢？
答：
$aaa = Import-Clixml -Path a:\abc.xml


# 显示windowsupdate.log 文件的最新5行日志
Get-Content -Path $env:windir\windowsupdate.log -ReadCount 0 -Tail 5


选出文件的第N行：
首先是要处理文件中的第一行和最后一行。如果有sed话可以
sed -n '1p;$p' data.txt
PowerShell里我是这样做的：
$lines = cat data.txt
$line_1 = $lines[0]
$line_end = $lines[-1]

Get-Content a.txt | Select-Object -Skip 1 | Set-Content b.txt


大多数情况下，我们使用如下方法来定义多行文本：
$text = @"
  I am safe here
  I can even use "quotes"
"@
$text | Out-GridView
注意两段的标志需要换行。

下面演示一种另类方法：
$text = {
  I am safe here
  I can even use "quotes"
}
$text.ToString() | Out-GridView

foreach ($file in Get-ChildItem $varPath*$varEnding) {
    $data = (Get-Content $file)
    If($data -match $varFindEscaped){
     $data | Where-Object {$_ -notmatch $varFindEscaped} | Set-Content $file
    }
}

# Import-Module : 无法加载文件 C:\Program Files\...  因为在此系统上禁止运行脚本。
查明了原因是由于操作系统默认禁止执行脚本，执行一次 `set-executionpolicy remotesigned -Force` 后脚本顺利执行

#yaml
class Purchaser {
    $Name
    [int]$Age
    $color
}
class Data {
    [Purchaser[]]$Purchaser
}
$r = @"
Purchaser :
    - Name : John
      Age : 10
      color : red
    - Name : Jane
      color : blue
"@ | ConvertFrom-Yaml
([Data]$r).Purchaser



#使本机器可以执行ps1文件
set-executionpolicy remotesigned
设置一下可以运行未签名的脚本或者为你的脚本签名。
set-executionpolicy Bypass
#是否要通过本计算机上的 WinRM 服务启用远程管理?
Set-WSManQuickConfig
#关闭防火墙
Enable-PSRemoting –Force
#添加信任IP
Set-Item wsman::localhost\client\TrustedHosts *
#远程该IP
Enter-PSSession -ComputerName 10.2.1.9 –Credential Administrator

#### 替换字符串，
PS C:\> $txt="{site}: https://www.pstips.net"
PS C:\> $txt.Replace("{site}","PowerShell")
PowerShell: https://www.pstips.net
# 也可以直接使用操作符replace
PS C:\> "{year}-%month%-day" -replace "{year}","1989" -replace "%month%","6" -replace "day","4"
1989-6-4
PS C:\> "Mr. Miller and Mrs. Meyer" -replace "(Mr.|Mrs.)", "Our client"     # 正则匹配多个模式替换。
# Our client Miller and Our client. Meyer

#加载文件，并过滤空行
$fullText=Get-Content .\a.txt | where { !([string]::IsNullOrWhiteSpace($_))}
(gc file.txt) | ? {$_.trim() -ne "" } | set-content file.txt

# 匹配字符串
PS C:\> $str="abc123abc"
PS C:\> $pattern="abc(\d{3})"
PS C:\> $str -match $pattern
Ture
PS C:\> $matches.Value
123


# 单个网卡信息查询ip
(ipconfig|select-string "IPv4"|out-string).Split(":")[-1].Trim()


# 格式化输出
'{0:d4}' -f 10
'数字的补零';{}
'{0:f4}' -f 10
'保留小数位数';{}
'{0:p2}' -f 0.4567
'转换为百分比';{}
'{0:x}' -f 255
'转换为十六进制';{}
'{0:X}' -f 255
'以大写字母方式转换为十六进制';{}
'{0:X8}' -f 255
'转换为十六进制并补零';{}
'{0:d}' -f (Get-Date)
'{0:D}' -f (Get-Date)
'格式化当前时间，只显示日期';{}
'{0:t}' -f (Get-Date)
'{0:T}' -f (Get-Date)
'格式化当前时间，只显示时间';{}
'{0:yyyy-MM-dd}' -f (Get-Date)
'指定格式输出当前时间，只显示年月日';{}



# 将字符串转换为数字
简单地将字符串转换为int将无法可靠地工作。您需要将其转换为int32。为此，您可以使用.NET转换类及其ToInt32方法。该方法需要一个字符串($ strNum)作为主要输入，而数字系统要转换的基数(10)。这是因为您不仅可以转换为十进制系统(10个基数)，还可以转换为二进制系统(基数2)。
[string]$strNum = "1.500"
[int]$intNum = [convert]::ToInt32($strNum, 10)
$intNum

### 终端
[Environment]::Exit(1)      # 终止此进程，并为基础操作系统提供指定的退出代码。
Break Script
throw "Error Message"       # 中断，抛出异常内容。


## 调用方法失败
>Method invocation failed because [System.Management.Automation.PSObject] doesn’t contain a method named ‘op_Addition’.

---
$jobs += New-Object PSObject -Property @{
    iphost = $iphost
    Pipe = $job
    result = $job.BeginInvoke()
}

need to be a collection of $obj objects, not another object identical to $obj. So If you want to add PSObjects to a PSObject as a collection, use the following code:

$jobs = @()
$jobs += New-Object PSObject -Property @{
    iphost = $iphost
    Pipe = $job
    result = $job.BeginInvoke()
---


ConvertTo-SecureString 和 ConvertFrom-SecureString 命令都支持选项 -Key。在处理密码时通过使用 Key 选项可以提供额外的安全性，并且允许在不同的环境中使用密码文件。
先生成 32 位的 Key 并保存在文件 AES.key 中：
$keyFile = "D:\aes.key"
$key = New-Object Byte[] 32
[Security.Cryptography.RNGCryptoServiceProvider]::Create().GetBytes($key)
$key | out-file $keyFile
使用 Key 生成并保存密码文件：
Read-Host "Enter Password" -AsSecureString | ConvertFrom-SecureString -key $key | Out-File "D:\pwd.txt"
使用密码文件创建和 Key 文件创建 Credential 信息：
$userName = "YourUserName"
$passwdFile = "D:\pwd.txt"
$keyFile = "D:\aes.key"
$key = Get-Content $keyFile
$Cred = New-Object -TypeName System.Management.Automation.PSCredential `
                   -ArgumentList $userName, (Get-Content $passwdFile | ConvertTo-SecureString -Key $key)
通过这种方法，把 pwd.txt 和 aes.key 文件拷贝到其它的机器上也是可以工作的。但是我们需要额外维护一个 key 文件的安全，这一般通过设置文件的访问权限就可以了。


#适用于 PowerShell 所有版本
这个简单的函数可以返回当前系统的启动时间：
function Get-Uptime
{
  $millisec = [Environment]::TickCount
  [Timespan]::FromMilliseconds($millisec)
}
2.115
2.254


## 设置环境变量，脚本中临时设置环境变量。
$env:path += ";C:\Windows\System32\inetsrv\"


# 获取外部访问 ip
(Invoke-WebRequest -uri "http://ifconfig.me/ip").Content

# 获取系统版本
Get-WmiObject -Class Win32_OperatingSystem | Select-Object -ExpandProperty Caption

# 获取本机 真实IP
(Get-NetIPAddress -InterfaceAlias 以太网 -AddressFamily IPv4).IPAddress

# 获取 powershell 版本
$PSVersionTable


[Environment]::


# 获取 .NET Framework 版本
.NET Framework 版本	最小值
.NET Framework 4.5	378389
.NET Framework 4.5.1	378675
.NET Framework 4.5.2	379893
.NET Framework 4.6	393295
.NET Framework 4.6.1	394254
.NET Framework 4.6.2	394802
.NET Framework 4.7	460798
.NET Framework 4.7.1	461308
.NET Framework 4.7.2	461808
.NET Framework 4.8	528040
(Get-ItemProperty "HKLM:SOFTWARE\Microsoft\NET Framework Setup\NDP\v4\Full").Release -ge 394802


# 获取脚本执行绝对路径
Split-Path -Parent $MyInvocation.MyCommand.Definition     # 脚本所在文件夹
$MyInvocation.MyCommand.Definition                        # 文件的绝对路径
$MyInvocation.MyCommand.name                              # 脚本名称
例如： c:\user\admin\test.ps1, 3 个输出依次为：
  c:\user\admin\test.ps1
  c:\user\admin\
  test.ps1

## The fileSyncDll.ps1 is not digitally signed. You cannot run this script on the current system.
- Set-ExecutionPolicy -ExecutionPolicy RemoteSigned
- PS C:\> Unblock-File -Path C:\Downloads\script1.ps1


## 获取内存中的函数，将源码复制到粘贴板
Get-Module | ForEach-Object { Get-Command -Module $_.Name -CommandType Function }
${function:format-hex} |clip


### powershell 设置执行脚本时间
    $start =Get-Date

    # enter scriptsBlock here.

    $end = Get-Date
    $runTime = ($end - $start).totalseconds
    Write-Output "runtime is $runTime S."


### powershell 获取操作系统
wmic os get caption             # os
wmic os get osarchitecture      # 架构
(Get-WmiObject win32_operatingsystem).version     # get-wmiobject 在 win8.1 中又bug ，建议用get-ciminstance
(Get-CimInstance Win32_OperatingSystem).Version
(Get-CimInstance Win32_OperatingSystem).Caption


### 查看环境变量
[environment]::ExpandEnvironmentVariables("%HomeDrive%%HomePath%")
[environment]::ExpandEnvironmentVariables("%Home%")


### 查找字符串
get-content updatelist.txt | findstr "29849"


### 下载
Invoke-WebRequest -Uri "http://xxx/xx.file" -OutFile "c:\download\xx.file"
$client = new-object System.Net.WebClient
$client.DownloadFile('http://xxx/xx.file', 'c:\download\xx.file')

### iex
# iex远程下载脚本执行

iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))


### 获取 domain
(Get-WmiObject Win32_ComputerSystem).Domain     # domain
(Get-WmiObject Win32_ComputerSystem).Name       # hostname


### choco install

@"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "[System.Net.ServicePointManager]::SecurityProtocol = 3072; iex ((New-Object System.Net.WebClient).DownloadString('http://ss-choco.1hai.cn/choco_install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"

Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString("http://ss-choco.1hai.cn/choco_install.ps1"))

```

## 字符串操作符

| 操作符               | 描述                                             | 示例                            |
| -------------------- | ------------------------------------------------ | ------------------------------- |
| \*                   | 代表一个字符串                                   | “PsTips.Net” -like “\*”         |
| +                    | 合并两个字符串                                   | “Power” + “Shell”               |
| -replace,-ireplace   | 替换字符串，大小写不敏感                         | “PsTips.Net” -replace “tip”,”1″ |
| -creplace            | 替换字符串，大小写敏感                           | “PsTips.Net” -replace “Tip”,”1″ |
| -eq, -ieq            | 验证是否相等，大小写不敏感                       | “Power” -eq “power”             |
| -ceq                 | 验证是否相等，大小写敏感                         | “Power” -eq “Power”             |
| -like, -ilike        | 验证字符串包含关系，允许模式匹配，大小写不敏感   | “PsTips.Net” -like “p\*”        |
| -clike               | 验证字符串包含关系，允许模式匹配，大小写敏感     | “PsTips.Net” – clike “P\*”      |
| -notlike,-inotlike   | 验证字符串不包含关系，允许模式匹配，大小写不敏感 | “PowerShell” -notlike “PS\*”    |
| -cnotlike            | 验证字符串不包含关系，允许模式匹配，大小写敏感   | “PowerShell” -cnotlike “PO\*”   |
| -match,-imatch       | 验证模式匹配，大小写不敏感                       | “PowerShell” -match “P\*”       |
| -cmatch              | 验证模式匹配，大小写敏感                         | “Hello” -match “[ao]”           |
| -notmatch,-inotmatch | 验证模式不匹配，大小写不敏感                     | “Hello” -notmatch “[ao]”        |
| -cnotmatch           | 验证模式不匹配，大小写敏感                       | “Hello” -cnotmatch “[ao]”       |

```powershell
### PowerShell脚本将一个变量当做命令执行
# 如果只是一条命令，可以用 & 执行命令
Write-Host "正在执行单条命令..."
& "Ping.exe" 'pstips.net'
& 'Get-Date'
# 如果是多条命令,使用 & 来执行脚本块
Write-Host "正在执行多条命令..."
$multipleLine = @"
ping pstips.net
get-Date
"@
$code = [scriptblock]::Create($multipleLine)
& $code
# 当然也可以使用  变量前加点 "."
& "Ping.exe" 'baidu.com'
."ping.exe" 'baidu.com'


### 异常捕获
($Error[0] | Select -Property *).Exception.GetType().FullName
$Error[0] | fl * -f

# 无需关闭shell 即可刷新环境变量
refreshenv
