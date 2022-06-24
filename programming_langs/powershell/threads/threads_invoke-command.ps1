# begin


function Set-Cred {
    param(
        [string]$type
    )
    # local
    $userAdmin = "administrator"
    $passwdAdmin = "ehi!!Pd@)!)" | ConvertTo-SecureString -asPlainText -Force
    $passwdAdminQ = "Qehi!!Pd@)!)" | ConvertTo-SecureString -asPlainText -Force
    # domain
    $userDomain = "ehai\administrator"
    $userDomainC = "ehaic\administrator"
    $passwdDomain = "Ehi!!MainXchange" | ConvertTo-SecureString -asPlainText -Force

    if ($type -eq "admin") {
        $user = $userAdmin; $passwd = $passwdAdmin
    }
    elseif ($type -eq "adminQ") {
        $user = $userAdmin; $passwd = $passwdAdminQ
    }
    elseif ($type -eq "domain") {
        $user = $userDomain; $passwd = $passwdDomain
    }
    elseif ($type -eq "domainC") {
        $user = $userDomainC; $passwd = $passwdDomain
    }
    $cred = New-Object System.Management.Automation.PSCredential($user, $passwd)

    return $cred
}


function Start-Threads {
    param (
        [string]$ip
        [string]$ipFile
        [string]$scripts
    )

    $throttleLimit = 20
    $iss = [system.management.automation.runspaces.initialsessionstate]::CreateDefault()
    $Pool = [runspacefactory]::CreateRunspacePool(1, $throttleLimit, $iss, $Host)
    $Pool.Open()
    $jobs = @()

    $threads = @()
    Get-Content $ipFile | ForEach-Object {
        $job = [powershell]::Create().AddScript($scripts).AddArgument($_)
        $job.RunspacePool = $Pool
        #$job.BeginInvoke()

        $jobs += New-Object PSObject -Property @{
            ipaddress = $_
            Pipe   = $job
            Result = $job.BeginInvoke()
        }
        $threads += $job
    }

    Write-Host "Waiting.." -NoNewline
    Do {
        Write-Host "." -NoNewline
        Start-Sleep -Seconds 1
    } While ( $jobs.Result.IsCompleted -contains $false)
    Write-Host "All jobs completed!"

    $Results = @()
    ForEach ($Job in $Jobs) {
        $Results += $Job.Pipe.EndInvoke($Job.Result)
    }
    #$Results
    $Results | Set-Content $HOME\Desktop\test\result.txt
}


$scripts = {
    Param (
        [string]$ip
    )
    $session = New-PSSession -ComputerName $ip -Credential $credQ
    Invoke-Command -Session $session -FilePath C:\Users\31216\Desktop\test\mk_qc-step2.ps1
}

$ipFile =
$resultFile = 

$start = Get-Date

$end = Get-Date
$seconds = ($end - $start).TotalSeconds
Write-Host "总耗时 $seconds 秒."

