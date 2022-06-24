$Throttle = 20 #threads

#脚本块，对指定的计算机发送一个ICMP包测试，结果保存在一个对象里面

$ScriptBlock = {
    Param (
        [string]$Computer
    )
    $a = test-connection -ComputerName $Computer -Count 1

    $RunResult = New-Object PSObject -Property @{
        IPv4Adress   = $a.ipv4address.IPAddressToString
        ComputerName = $Computer

    }
    Return $RunResult
}


#创建一个资源池，指定多少个runspace可以同时执行

$RunspacePool = [RunspaceFactory]::CreateRunspacePool(1, $Throttle)
$RunspacePool.Open()
$Jobs = @()


#获取Windows 2012服务器的信息，对每一个服务器单独创建一个job，该job执行ICMP的测试，并把结果保存在一个PS对象中

(get-adcomputer -filter { operatingsystem -like "*2012*" }).name | % {

    #Start-Sleep -Seconds 1
    $Job = [powershell]::Create().AddScript($ScriptBlock).AddArgument($_)
    $Job.RunspacePool = $RunspacePool
    $Jobs += New-Object PSObject -Property @{
        Server = $_
        Pipe   = $Job
        Result = $Job.BeginInvoke()
    }
}


#循环输出等待的信息.... 直到所有的job都完成

Write-Host "Waiting.." -NoNewline
Do {
    Write-Host "." -NoNewline
    Start-Sleep -Seconds 1
} While ( $Jobs.Result.IsCompleted -contains $false)
Write-Host "All jobs completed!"


#输出结果
$Results = @()
ForEach ($Job in $Jobs) {
    $Results += $Job.Pipe.EndInvoke($Job.Result)
}

$Results