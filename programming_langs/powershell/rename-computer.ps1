param(
    [Parameter(Mandatory = $true, Position = 0)]
    [string]$name
)

function Set-Cred {
    param(
        [string]$user
    )
    # local
    $userAdmin = "administrator"
    $passwdAdmin = "ehi!!Pd@)!)" | ConvertTo-SecureString -asPlainText -Force
    $passwdAdminQ = "Qehi!!Pd@)!)" | ConvertTo-SecureString -asPlainText -Force
    # domain
    $userDomain = "ehai\administrator"
    $userDomainC = "ehaic\administrator"
    $passwdDomain = "Ehi!!MainXchange" | ConvertTo-SecureString -asPlainText -Force

    $creds = @{
        Admin   = $userAdmin, $passwdAdmin
        AdminQ  = $userAdmin, $passwdAdminQ
        Domain  = $userDomain, $passwdDomain
        DomainC = $userDomainC, $passwdDomain
    }

    $cred = New-Object System.Management.Automation.PSCredential($creds.$user[0], $creds.$user[1])
    return $cred
}

function Get-ServerRoom {
    param (
        [Parameter(Mandatory = $true,
            HelpMessage = "Please enter the IpV4 address.")]
        [string]$Ip
    )
    $server = @{
        SH = "192.168.5", "192.168.9", "172.17.30"
        SS = "172.20"
        SQ = "192.168.7", "172.21"
        QS = "172.31"
        QG = "172.29"
    }
    foreach ($name in $server.Keys) {
        if ($server.$name -is [array]) {
            $server.$name | ForEach-Object {
                if ($ip -match $_) { return $name }
            }
        }
        else {
            if ($ip -match $server.$name) { return $name }
        }
    }
}


$ip = (cmd /c "FOR /F "tokens=4 " %i in ('route print^|findstr "0.0.0.0.*0.0.0.0"') do @echo %i" | Select-Object -Index 0)
$serverRoom = Get-ServerRoom -Ip $ip

$ip34 = "{0:d3}{1:d3}" -f [int]$ip.Split("\.")[2], [int]$ip.Split("\.")[3]
$domain = (Get-WmiObject Win32_ComputerSystem).Domain
if ($domain -eq "ehai.com") { $user = "domain" }
elseif ($domain -eq "ehaic.com") { $user = "domainC" }
else { throw "Unknown domain or domain not joined." }
$cred = Set-Cred -user $user
$hostname = $serverRoom + $ip34 + $name


$cred ; $hostname
#Rename-Computer -NewName $hostname -DomainCredential $cred -Force -PassThru