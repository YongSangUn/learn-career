param (
    [Parameter(Mandatory = $true,
        Position = 0,
        HelpMessage = "Please enter first & second & third digits of the IPv4.")]
    # Match ip address: 172.x.x & 192.x.x ,
    [ValidatePattern("^1[7-9]2\.(25[0-5]|2[0-4]\d|[0-1]?\d\d?)\.(25[0-5]|2[0-4]\d|[0-1]?\d\d?)$")]
    [String[]]
    $ip123
)

$ip123 = "172.20.1"
#Clear-Host
$Throttle = 100 #threads

$RunResult = @()
$ScriptBlock = {
    Param (
        $ip4, 
        $ip123,
        [array]$RunResult
    )
    $ip = "$ip123.$ip4"
    ping -w 2 -n 1 $ip
    if ($? -eq $true) {
        $pingResult = "pingSuccess"
    }
    else {
        $pingResult = "pingFail"
    }
    $RunResult += $pingResult
    Return $RunResult
}

$RunspacePool = [RunspaceFactory]::CreateRunspacePool(1, $Throttle)
$RunspacePool.Open()
$Jobs = @()

1..255 | % {
    #Start-Sleep -Seconds 1
    $Job = [powershell]::Create().AddScript($ScriptBlock).AddArgument($_).AddArgument($ip123).AddArgument($RunResult)
    $Job.RunspacePool = $RunspacePool
    $Jobs += New-Object PSObject -Property @{
        RunNum = $_
        Pipe   = $Job
        Result = $Job.BeginInvoke()
    }
}

Write-Host "Waiting.." -NoNewline
Do {
    Write-Host "." -NoNewline
    Start-Sleep -Seconds 1
} While ( $Jobs.Result.IsCompleted -contains $false)
Write-Host "All jobs completed!"

$Results = @()
ForEach ($Job in $Jobs) {
    $Results += $Job.Pipe.EndInvoke($Job.Result)
}
