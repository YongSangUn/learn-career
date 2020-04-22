$file = "C:\Users\31216\Desktop\test\change-hostname\hostname.yaml"
$config = Get-Content $file | Out-String | ConvertFrom-Yaml


foreach ($site in $config.sites) {
    $ip = $site.ip
    $hostname = $site.hostname
    #Write-Host "$ip, $hostname"
    # add credential
    $user = "administrator"
    $passwdQ = "Qehi!!Pd@)!)" | ConvertTo-SecureString -asPlainText -Force
    $passwd = "ehi!!Pd@)!)" | ConvertTo-SecureString -asPlainText -Force
    $credAdminQ = New-Object System.Management.Automation.PSCredential($user, $passwdQ)
    $credAdmin = New-Object System.Management.Automation.PSCredential($user, $passwd)
    $s2 = New-PSSession -ComputerName 172.29.10.10  -Credential $credAdmin
    $session = New-PSSession -ComputerName $ip -Credential $credAdminQ 
    
    if ($? -eq $false) { 
        $session = New-PSSession -ComputerName $ip -Credential $credAdmin
         
        $credP = $credAdmin
    }
    else {
        $credP = $credAdminQ
    }
    Write-Host "---- remote config ----"
    Invoke-Command -Session $session -ScriptBlock { $using:ip ; python --version; Write-Host "`n`n" } -ArgumentList $ip
    #Invoke-Command -Session $session -ScriptBlock { $using:ip ; Invoke-WebRequest -Uri "ftp://172.20.9.200/1scripts/en_mk_qc-step2.ps1" -OutFile "$HOME\desktop\step-2.ps1"; Write-Host "`n`n" } -ArgumentList $ip
    #Invoke-Command -Session $session -ScriptBlock { $using:ip ; [io.file]::ReadAllLines("C:\Users\administrator\desktop\log.txt") ; $using:ip ;pause; Write-Host "`n`n" } -ArgumentList $ip, $s2
     
    #Invoke-Command -Session $session -ScriptBlock { echo $using:ip ; hostname; Rename-Computer -NewName $using:hostname -Force -DomainCredential $using:credP ;Write-Host "`n`n"} -ArgumentList $hostname, $credP, $ip
    #Invoke-Command -Session $session -ScriptBlock { Restart-Computer -Force } -ArgumentList $ip
    Write-Host "###############         NEXT          ###################"
}
pause
