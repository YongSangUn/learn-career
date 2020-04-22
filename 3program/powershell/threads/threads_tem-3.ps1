$MaxThreads = 5
 
$RunspacePool = [RunspaceFactory]::CreateRunspacePool(1, $MaxThreads)
$RunspacePool.Open()

$ScriptBlock = {
    Param (
        [int]$RunNumber
    )
    $RanNumber = Get-Random -Minimum 1 -Maximum 10
    Start-Sleep -Seconds $RanNumber
    $RunResult = New-Object PSObject -Property @{
        RunNumber = $RunNumber
        Sleep     = $RanNumber
    }
    Return $RunResult
}

$Jobs = @()

$Job = [powershell]::Create().AddScript($ScriptBlock).AddArgument($argument1)
$Job.RunspacePool = $RunspacePool
$Jobs += New-Object PSObject -Property @{
    Pipe   = $Job
    Result = $Job.BeginInvoke()
}

Write-Host "Waiting.." -NoNewline
Do {
   Write-Host "." -NoNewline
   Start-Sleep -Seconds 1
} While ( $Jobs.Result.IsCompleted -contains $false )
Write-Host "All jobs completed!"

$Results = @()
ForEach ($Job in $Jobs )
{   $Results += $Job.Pipe.EndInvoke($Job.Result)
}