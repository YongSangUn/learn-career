$throttleLimit = 100
$SessionState = [system.management.automation.runspaces.initialsessionstate]::CreateDefault()
$Pool = [runspacefactory]::CreateRunspacePool(1, $throttleLimit, $SessionState, $Host)
$Pool.Open()

Remove-Item pingSuccess.txt -Force | Out-Null
Remove-Item pingFail.txt -Force | Out-Null

$ScriptBlock = {
    param($ip123, $ip4)
    $ip = "$ip123.$ip4"
    ping -w 3 -n 1 $ip
    if ($? -eq $true) {
        $ip >> .\pingSuccess.txt
    }
    else {
        $ip >> .\pingFail.txt
    }
}

$ip123 = "172.20.1"
$threads = @()
$handles = for ($x = 1; $x -le 256; $x++) {
    $powershell = [powershell]::Create().AddScript($ScriptBlock).AddArgument($ip123).AddArgument($x)
    $powershell.RunspacePool = $Pool
    $powershell.BeginInvoke()
    $threads += $powershell
}

do {
    $i = 0
    $done = $true
    foreach ($handle in $handles) {
        if ($null -ne $handle) {
            if ($handle.IsCompleted) {
                $threads[$i].EndInvoke($handle)
                $threads[$i].Dispose()
                $handles[$i] = $null
            }
            else {
                $done = $false
            }
        }
        $i++
    }
    if (-not $done) { Start-Sleep -Milliseconds 500 }
} until ($done)


#$pingSuccess | Set-Content pingSuccess.txt
#$pingFail | Set-Content pingFail.txt
