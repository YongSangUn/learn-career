# 域控管理

```powershell
# 测试并修复本地计算机及其域之间的安全通道。
Test-ComputerSecureChannel
> https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/test-computersecurechannel?view=powershell-5.1


Get-ADComputer -Filter 'name -like "QG001*Xapp"' -Properties * |Format-List name,dnshostname,ipv4address,sid