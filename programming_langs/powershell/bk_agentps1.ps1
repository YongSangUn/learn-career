Get-Process base*, pro*, gse*
Restart-Service (Get-Service gse*).name -Force




c:\gse\plugins\bin\restart.bat basereport
c:\gse\plugins\bin\restart.bat processbeat
C:\gse\gseagentw\restart.bat gse_win_agent

C:\gse\plugins\bin\processbeat.exe -c C:\gse\plugins\etc\processbeat.conf

$serviceName = (Get-Service -Name gse*).name
Restart-Service -name $serviceName

(gc .\Desktop\iphost.txt) | % {
    $s = new-PSSession $_ -Credential (Set-Cred domainc)
    Invoke-Command -Session $s -ScriptBlock { hostname ; Restart-Service (Get-Service gse*).name }
    Get-PSSession | Remove-PSSession
}