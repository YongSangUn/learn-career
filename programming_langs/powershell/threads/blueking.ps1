$Throttle = 20 #threads

#脚本块，对指定的计算机发送一个ICMP包测试，结果保存在一个对象里面

$ScriptBlock = {
    Param (
        [string]$ip
    )
    #$a = test-connection -ComputerName $Computer -Count 1

    $user = "ehaic\administrator"
    $passwd = "Ehi!!MainXchange" | ConvertTo-SecureString -asPlainText -Force
    $cred = New-Object System.Management.Automation.PSCredential($user, $passwd)
    $session = New-PSSession -ComputerName $ip -Credential $cred
    Invoke-Command -Session $session -ScriptBlock{
        $ipv4 = python -c "import socket;print([(s.connect(('8.8.8.8', 0)), s.getsockname()[0], s.close()) for s in [socket.socket(socket.AF_INET, socket.SOCK_DGRAM)]][0][1])"
        Write-Output "`n`n########## $ipv4 ##########"
		Get-Process base*,pro*,gse*
		#get-service gse*
		#stop-service gse* -force
		#start-service gseDaemon
		#Restart-Service (Get-Service gse*).name -Force
		#C:\gse\plugins\bin\processbeat.exe -c C:\gse\plugins\etc\processbeat.conf
    }

}


#创建一个资源池，指定多少个runspace可以同时执行

$RunspacePool = [RunspaceFactory]::CreateRunspacePool(1, $Throttle)
$RunspacePool.Open()
$Jobs = @()


#获取Windows 2012服务器的信息，对每一个服务器单独创建一个job，该job执行ICMP的测试，并把结果保存在一个PS对象中

(Get-Content iphost.txt) | % {

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