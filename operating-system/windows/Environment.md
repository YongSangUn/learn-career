# windows 环境变量

[toc]

## powershell 与 环境变量

这里先提一下注册表；

powershell 中的操作注册表使用 `get-itemproperty, set-itemproperty` 等就可以了。

- 用户变量
  `HKEY_CURRENT_USER\Environment->Path`

- 系统变量

  - `HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\Session Manager\Environment` 或者
  - `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Environment`
  - ControlSet001：系统真实的配置信息。
  - CurrentControlSet：运行时配置。windows 启动时会从 ControlSet001 复制一份副本，作为操作系统当前的配置信息。

### 变量说明

我们对于计算机配置所作的修改都是直接写入到 CurrentControlSet
在重启过程中，windows 会用 CurrentControlSet 的内容覆盖掉 ControlSet001，以保证这两个控件组一致。

在我的电脑->系统设置->环境变量界面，用户变量或系统变量的 path 字段，手工添加，输入设置的路径，在注册表 `HKCU\Environment`(用户变量)、`ControlSet001` 或 `CurrentControlSet`(系统变量)会立即出现，且在新打开的命令行窗口立即有效;

而 powershell 窗口临时设置，可以使用 `$env:PATH += ";C:\softwaredir"` ，注意路径前的分号 ";" 。

### powershell 操作环境变量

```powershell
### 临时使用，在当前进程和窗口适用。
## 例如我需要使用 appcmd 这个软件，我需要在环境变量 PATH 里添加路径临时使用下，
# 实际上就是在原有 PATH 的基础上新加了内容，当前工作区会将变量指向新定义的 PATH，不会影响到系统内的数据。
$env:PATH += ";c:\windows\system32\inetsrv"


### 获取 用户 和 系统 的变量：
Get-ItemProperty HKCU:\Environment\
Get-ItemProperty 'HKLM:\SYSTEM\ControlSet001\Control\Session Manager\Environment\'
(Get-ItemProperty 'HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Environment\').path -split ";"
# 单独获取 PATH 可以使用
(Get-ItemProperty 'HKLM:\SYSTEM\ControlSet001\Control\Session Manager\Environment\').path -split ";"


### 永久修改环境变量
## 先说说 Environment 类
GetEnvironmentVariable(String)                                          # 从当前进程检索环境变量的值。
GetEnvironmentVariables()                                               # 从当前进程检索所有环境变量名及其值。
SetEnvironmentVariable(String, String)                                  # 创建、修改或删除当前进程中存
SetEnvironmentVariable(String, String, EnvironmentVariableTarget)       # 创建、修改或删除当前进程中或者为当前用户或本地计算机保留的 Windows 操作系统注册表项中存储的环境变量。

## 修改变量 调用类方法
# 修改系统环境变量
[Environment]::SetEnvironmentVariable
     ("Path", $env:Path, [System.EnvironmentVariableTarget]::Machine)
# 修改用户环境变量
[Environment]::SetEnvironmentVariable
     ("INCLUDE", $env:INCLUDE, [System.EnvironmentVariableTarget]::User)
# 也可以使用基于字符串的命令
[Environment]::SetEnvironmentVariable("Path", $env:Path + ";C:\bin", "Machine")


### 但是上面的命令必须使用管理员执行才能生效，所以做个判断最好。
```

### 添加环境变量 推荐使用的脚本

此脚本不需要用户交互，方便集成在脚本中：

- 更新 \$env:PATH 且在当前进程中适用
- 更新 \$env:PATH 会永久生效
- 不会添加已经存在的路径

```powershell

function Add-EnvPath {
    param(
        [Parameter(Mandatory=$true)]
        [string] $Path,

        [ValidateSet('Machine', 'User', 'Session')]
        [string] $Container = 'Session'
    )

    if ($Container -ne 'Session') {
        $containerMapping = @{
            Machine = [EnvironmentVariableTarget]::Machine
            User = [EnvironmentVariableTarget]::User
        }
        $containerType = $containerMapping[$Container]

        $persistedPaths = [Environment]::GetEnvironmentVariable('Path', $containerType) -split ';'
        if ($persistedPaths -notcontains $Path) {
            $persistedPaths = $persistedPaths + $Path | where { $_ }
            [Environment]::SetEnvironmentVariable('Path', $persistedPaths -join ';', $containerType)
        }
    }

    $envPaths = $env:Path -split ';'
    if ($envPaths -notcontains $Path) {
        $envPaths = $envPaths + $Path | where { $_ }
        $env:Path = $envPaths -join ';'
    }
}

# 示例
ps c:\ Add-EnvPath -Path "c:\temp" -Container Machine
```
