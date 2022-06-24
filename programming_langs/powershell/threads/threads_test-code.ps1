Clear-Host
$Throttle = 5 #threads

$ScriptBlock = {
   Param (
      [int]$RunNumber
   )
   $RanNumber = Get-Random -Minimum 1 -Maximum 10
   Start-Sleep -Seconds $RanNumber
   $RunResult = New-Object PSObject -Property @{
      RunNumber = $RunNumber
      Sleep = $RanNumber
   }
   Return $RunResult
}

$RunspacePool = [RunspaceFactory]::CreateRunspacePool(1, $Throttle)
$RunspacePool.Open()
$Jobs = @()

1..20 | % {
   #Start-Sleep -Seconds 1
   $Job = [powershell]::Create().AddScript($ScriptBlock).AddArgument($_)
   $Job.RunspacePool = $RunspacePool
   $Jobs += New-Object PSObject -Property @{
      RunNum = $_
      Pipe = $Job
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
ForEach ($Job in $Jobs)
{   $Results += $Job.Pipe.EndInvoke($Job.Result)
}

$Results | Out-GridView