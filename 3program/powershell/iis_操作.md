# iis 相关操作

[toc]

> 方便批量操作管理，本文将的都是命令行处理。
> 需要用到的工具有 appcmd.exe ，以及 WebAdministration 模块。

## 环境设置

powershell 管理 iis 相关需要用到两个工具，appcmd.exe 以及 WebAdministration 模块，这两个工具凡是安装了 iis 都服务器都会自带，也无需导入。

- appcmd 设置
  appcmd.exe 的路径在 `C:\Windows\System32\inetsrv\` 路径下，因为没有添加环境变量，我们在使用的时候还需使用绝对目录，所以添加环境变量即可。命令如下：

```powershell
### 第一条命令是把当前工作环境的变量附加一个值，原本的 $env:path 指向附加后的值，但是不会影响系统的变量。
### 下一条命令，调用 [.NET Framework], 直接修改注册表的值，直接修改系统的环境变量，永久生效。单独执行需重启当前工作环境。（包括蓝鲸，可能需要重启服务才是识别）
## 查看注册表中的值：
#(Get-ItemProperty 'HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Environment\').path -split ";"
$env:path += ";C:\Windows\System32\inetsrv\"            # 注意 路径前的 ";"
[Environment]::SetEnvironmentVariable("Path", $env:Path, "Machine")

# 所以 2 条命令加起来就可以立刻生效且永久保留。
```

- WebAdministration 模块
  WebAdministration 模块一般是不需要导入的，如果使用 `get-website` 命令不生效，检查 iis 是否安装；如果已安装未生效使用 `import-module WebAdministration` 即可。

### appcmd 详解

- 基础的
appcmd (命令) (对象类型) <标识符> </参数1:值1 ...>