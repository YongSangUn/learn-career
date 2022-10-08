## CLI encoding use utf8.
# [System.Console]::OutputEncoding = [System.Text.Encoding]::GetEncoding(65001)
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

## Display powershell version
# Write-Host "==> Powershell Version: $_psEdition $_psVersion`n" -ForegroundColor Green


##############################  Powerline & CLI Settings  ##############################

### Powershell Line

# https://docs.microsoft.com/en-us/windows/terminal/tutorials/powerline-setup
# https://ohmyposh.dev/docs/

## Install powerline fonts.
# winget install JanDeDobbeleer.OhMyPosh -s winget
# <CaskaydiaCove NF> in the Windows Terminal font settings.
# oh-my-posh font install CascadiaCode
if ($PSVersionTable.PSVersion.Major -eq 7) {
    $theme = "emodipt" # powershell v7
} else {
    $theme = "honukai" # powershell v5
}

try {
    oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\$theme.omp.json" | iex
} catch {
    $null
}

### Set the prediction text source to history
# Import-Module PSReadLine
Set-PSReadLineOption -EditMode Emacs
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -HistoryNoDuplicates
Set-PSReadLineKeyHandler -Key Tab -Function Complete
Set-PSReadlineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadlineKeyHandler -Key DownArrow -Function HistorySearchForward

### install gsudo, allow the current CLI to elevate administrator authority.
# Set-ExecutionPolicy RemoteSigned -scope Process
# iwr -useb https://raw.githubusercontent.com/gerardog/gsudo/master/installgsudo.ps1 | iex
try {
    Import-Module 'C:\Program Files (x86)\gsudo\gsudoModule.psd1'
} catch {
    $null
}


##############################  Paramters  ##############################

# profile.ps1 file.
$myProfile = $PROFILE.CurrentUserAllHosts

# Terminal
$wtJsonFile = "$HOME\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json"
$wtDefaultJsonFile = "C:\Program Files\WindowsApps\Microsoft.WindowsTerminal_1.0.1401.0_x64__8wekyb3d8bbwe\defaults.json"

$desk = "$HOME\desktop"

# Git directory.
$gitMainDir = "D:\git"
$starGit = Join-Path $gitMainDir "0star"
$learnGit = Join-Path $gitMainDir "learn-career"
$nocResourceGit = Join-Path $gitMainDir "noc.resource"
$qcloudGit = Join-Path $nocResourceGit '0project\qcloud.sdk'
$nocWikiGit = Join-Path $gitMainDir "noc.wiki"

# Python Dir
$pythonPkg = "C:\python38\Lib\site-packages\"

## Aes Encryption
# $AesKeyEhi = $env:AesKeyEhi
$AesKeyEhi = irm 'http://consulmain.1hai.cn/v1/kv/keys/aeskeyehi?raw'

$passwdAdmin = "o6jaCyf1llJrNDeLfsfPogGczv+JIatnMA9wr0pVfEw="
$passwdAdmin1 = "tPWGX2RqgzUe6FH2xiVQ3e/BK9gxY+Ib/LHypRqa8po="
$passwdAdmin3 = "QPvNS1PL/nB7b4eIP2kNMtORo4AZkk2OIjUpYl1bL+c="
$passwdDomain = "1xPBFgbHbDyXlbiDzWYuEt4WahkEv9Ihlly2hE2oUNI="
$passwdDomainWeb = "K79hWOsm9GoM47/nOsIv+/ZdvVU2a6OFrdMRiMD4seY="
$passwdAaa = "0nPEKZJanQ/pyU8n3FHY7tRpZf4HypuZjyDHZZyhLlQ="
$winPort = "5pbtwxnirkAV9jawgIYZSOP5Iqr6ZWeLpjl9hryrfeE="
$linPort = "M3xjhiCTg+zEsIavs2qXLNrQkWSwtlHSJQ/0jajSqZE="

$myCentosHostPort = "WMs+0vL/rPDOrWKE+0HrclLkwQH4Hl2wu8V1k2iiRcY="
$myCentosHost = "x9p2D3w9Y8foVAaEYBzWaqkbECW7OTWRhP7XWpNFKCU="

$consulToken = "JZn++t2j/sa2xMCU1Ws/WfnN15cmSDCXB7WH7h7dNuL3HBEhy1Eb3LPLt2dL8ayQ0/1zDB3F6gCHc8MhN7/AAw=="


##############################  Functions  ##############################

### AES Functions
function Create-AesManagedObject($key, $IV) {
    $aesManaged = New-Object "System.Security.Cryptography.AesManaged"
    $aesManaged.Mode = [System.Security.Cryptography.CipherMode]::CBC
    $aesManaged.Padding = [System.Security.Cryptography.PaddingMode]::Zeros
    $aesManaged.BlockSize = 128
    $aesManaged.KeySize = 256
    if ($IV) {
        if ($IV.getType().Name -eq "String") { $aesManaged.IV = [System.Convert]::FromBase64String($IV) } else { $aesManaged.IV = $IV }
    }
    if ($key) {
        if ($key.getType().Name -eq "String") { $aesManaged.Key = [System.Convert]::FromBase64String($key) } else { $aesManaged.Key = $key }
    }
    $aesManaged
}

function Create-AesKey() {
    $aesManaged = Create-AesManagedObject
    $aesManaged.GenerateKey()
    [System.Convert]::ToBase64String($aesManaged.Key)
}

function EncStr( $unencryptedString, $key = $AesKeyEhi) {
    $bytes = [System.Text.Encoding]::UTF8.GetBytes($unencryptedString)
    $aesManaged = Create-AesManagedObject $key
    $encryptor = $aesManaged.CreateEncryptor()
    $encryptedData = $encryptor.TransformFinalBlock($bytes, 0, $bytes.Length);
    [byte[]] $fullData = $aesManaged.IV + $encryptedData
    $aesManaged.Dispose()
    [System.Convert]::ToBase64String($fullData)
}

function DecStr($encryptedStringWithIV, $key = $AesKeyEhi) {
    $bytes = [System.Convert]::FromBase64String($encryptedStringWithIV)
    $IV = $bytes[0..15]
    $aesManaged = Create-AesManagedObject $key $IV
    $decryptor = $aesManaged.CreateDecryptor();
    $unencryptedData = $decryptor.TransformFinalBlock($bytes, 16, $bytes.Length - 16);
    $aesManaged.Dispose()
    [System.Text.Encoding]::UTF8.GetString($unencryptedData).Trim([char]0)
}

## ps remote
function Get-Cred {
    # get the ps-credential by name.
    param(
        [string]$user
    )
    # local
    $userAdmin = "administrator"
    $passwdAdmin = DecStr $passwdAdmin | ConvertTo-SecureString -asPlainText -Force
    $passwdAdmin1 = DecStr $passwdAdmin1 | ConvertTo-SecureString -asPlainText -Force
    $passwdAdmin3 = DecStr $passwdAdmin3 | ConvertTo-SecureString -asPlainText -Force
    # domain
    $userDomain = "ehai\administrator"
    $userDomainC = "ehaic\administrator"
    $userDomainCar = "ehicar\administrator"
    $passwdDomain = DecStr $passwdDomain | ConvertTo-SecureString -asPlainText -Force
    # domain web
    $userDomainWebSH = 'ehi\webadmin'
    $userDomainWebCar = 'callcenter\webadmin'
    $passwdDomainWeb = DecStr $passwdDomainWeb | ConvertTo-SecureString -asPlainText -Force

    # User-list: key: userNicename; value1: username, values2: userpassword.
    $creds = @{
        admin        = $userAdmin, $passwdAdmin
        admin1       = $userAdmin, $passwdAdmin1
        admin3       = $userAdmin, $passwdAdmin3
        adminq       = $userAdmin, $passwdAdminQ
        domain       = $userDomain, $passwdDomain
        domainc      = $userDomainC, $passwdDomain
        domaincar    = $userDomainCar, $passwdDomain
        domainweb    = $userDomainWebSH , $passwdDomainWeb
        domainwebcar = $userDomainWebCar, $passwdDomainWeb
    }

    $cred = New-Object System.Management.Automation.PSCredential($creds.$user[0], $creds.$user[1])
    return $cred
}

function NPS {
    ### new-pssession. google new-pssession.
    param (
        [string]$ip,
        [string]$credName
    )
    try { New-PSSession $ip -Credential (Get-Cred $credName) }
    catch { New-PSSession $ip -Credential $credName }
}
function Ivk-C {
    ### set invoke-command, powershell Execute commands remotely without logging into the server.
    param (
        [string]$ip,
        [string]$credName,
        [scriptblock]$scripts
    )
    try { Invoke-Command $ip -Credential (Get-Cred $credName) -ScriptBlock $scripts }
    catch { Invoke-Command $ip -Credential $credName -ScriptBlock $scripts }
}
function EPS {
    ### set enter-pssession. powershell login to remote server using winrm protocol.
    param (
        [string]$ip,
        [string]$credName
    )
    if (!($credName)) { $credName = "admin" }

    while ($true) {
        try {
            $cred = Get-Cred $credName
        } catch {
            $user = $cred = $credName
            $null = $user # this is credential's user, not credential :-).
        }

        Enter-PsSession $ip -Credential $cred
        if ($?) {
            break
        } else {
            $credName = Read-Host "Enter a credential or user"
        }
    }
}

function WEPS {
    ### powershell login to remote server using rdp protocol.
    param (
        $ip,
        $port
    )
    if ($ip) {
        if (!($port)) { $port = DecStr $winPort }
        mstsc /v:${ip}:${port}
    } else {
        "--> Please enter the correct parameters.`n`t$ Eps-Win 10.10.10.10 12345"
    }
}

function LEPS {
    ### windows login to remote linux server using wsl,
    # Need to install sshpass.
    param (
        $ip,
        $cred = "admin",
        $credTmp,
        [switch]$details = $false
    )
    $credDict = @{
        admin  = DecStr $passwdAdmin
        admin1 = DecStr $passwdadmin1
        admin3 = DecStr $passwdAdmin3
        aaa    = DecStr $passwdAaa
    }
    if (!($ip)) {
        "Please enter the host."
        return
    }

    if ($cred.GetTypeCode() -eq 'Int32') {
        $port = $cred
        if ($credTmp) {
            $cred = $credTmp
        } else {
            $cred = "admin"
        }
    }

    if (!($port)) {
        if ($ip -match '^172\.(21|20)\.12') {
            $port = DecStr "HbQ84iVmzASpT2ujUbHZe+dL4TPyQRnb0wB0ONLpoT0="
        } elseif ($ip -match '^172\.(31|20)\.') {
            $port = DecStr $linPort
        } elseif ($ip -match '^(172\.21|192\.168\.7)\.') {
            $port = DecStr "Bo0AHVqCnhTLnLKR/n9pA9bVaOXZrWjB3RM7yrnXxKk="
        } elseif ($ip -match '^(192\.168|172\.17\.30)') {
            $port = "aoJme8aFESCL/I9iDkcqkp5qgcrws44x2FlQOt/TMvY="
        } elseif ($ip -match '^192\.25') {
            $port = "trVsxsbnO74Ok214yoaiwtUS5adiGbyZz9v2e4R0OEs="
        } else {
            $port = Read-Host "Unknown Ip, please enter the ssh-port:"
        }
    }

    if ($details) {
        "Host: $ip`nPort: $port`nCred or User: $cred"
    }
    if ($credDict.Keys -contains $cred) {
        $passwd = DecStr $credDict.$cred
        $user = "root"
        bash -c "sshpass -p '$passwd' ssh -p $port $user@$ip -o StrictHostKeyChecking=no"
    } else {
        $user = $cred
        bash -c "ssh -p $port $user@$ip -o StrictHostKeyChecking=no"
    }
}

function WCP {
    ### Copy files between windows & windows hosts.
    # Usages:
    #     WCP 172.20.1.1,c:\test.txt c:\ admin
    #               -eq
    #     Copy-Item C:\test.txt -Destination c:\ -ToSession (EPS 172.20.1.1 admin)
    param (
        [string]$file,
        [string]$destination,
        [string]$credName,
        [switch]$f
    )
    # judge session style.
    # NOTE:
    #   Incoming 172.20.1.1,c:\test.txt  will be recognized as an array
    #   The reason for using Split() is to turn a single string into an
    #   array to avoid judgment errors.
    if ($file.Split()[0] -eq $file) {
        $sessionStyle = "To"
    } elseif ($destination.Split()[0] -eq $destination) {
        $sessionStyle = "From"
    }

    if (!($credName)) { $credName = "admin" }

    if ( $sessionStyle -eq "To" ) {
        $ip = $destination.Split()[0]
        $session = NPS $ip $credName
        if ($f) {
            Copy-Item $file -Destination $destination.Split()[1] -ToSession $session -Recurse -Force
        } else {
            Copy-Item $file -Destination $destination.Split()[1] -ToSession $session -Recurse
        }
    } elseif ($sessionStyle -eq "From") {
        $ip = $file.Split()[0]
        $session = NPS $ip $credName
        if ($f) {
            Copy-Item $file.Split()[1] -Destination $destination -FromSession $session -Recurse -force
        } else {
            Copy-Item $file.Split()[1] -Destination $destination -FromSession $session -Recurse
        }
    }
}

function LCP {
    ### Copy files between windows & linux hosts.
    # Usages:
    #   $ LSCP 1.1.1.1:12345,/dir/file /dir2/ cred-name
    param (
        [string]$file,
        [string]$target,
        [string]$cred
    )
    $credDict = @{
        admin  = DecStr $passwdAdmin
        admin1 = DecStr $passwdadmin1
        admin3 = DecStr $passwdAdmin3
        aaa    = DecStr $passwdAaa
    }

    if ($file.Split()[0] -eq $file) {
        # $target is Array.
        $targetArray = $target.Split()

        $ip = $targetArray[0].Split(":")[0]
        if ($targetArray[0].Split(":").count -eq 2) {
            $port = $targetArray[0].Split(":")[1]
        }

        $destinationFile = $targetArray[1]

        $source = $file
        $destination = "${ip}:${destinationFile}"
    } elseif ($target.Split()[0] -eq $target) {
        # $file is Array.
        ""
        $fileArray = $file.Split()

        $ip = $fileArray[0].Split(":")[0]
        if ($fileArray.Split(":").count -eq 2) {
            $port = $fileArray[0].Split(":")[1]
        }

        $sourceFile = $fileArray[1]

        $source = "${ip}:${sourceFile}"
        $destination = $target
    } else {
        "==> Parameter error.
        $ LSCP 1.1.1.1:12345,/dir/file /dir2/ cred-name"
    }

    if (!($port)) { $port = DecStr $linPort }
    if (!($cred)) { $cred = "admin" }
    $passwd = DecStr $credDict.$cred

    # Write-Host "sshpass -p '$passwd' scp -P $port $source $destination"
    bash -c "sshpass -p '$passwd' scp -P $port $source $destination"
}

function SangUn-Centos {
    # My Centos Server.
    ssh -p (DecStr $myCentosHostPort) (DecStr $myCentosHost)
}

function Ipy3 {
    # use wsl launch ipython3.
    bash -c 'ipy3'
}
function Qt { exit }

function TimeToEnd() {
    $done = $true
    while ($done) {
        clear
        $endTime = get-date -Format "yyyy-MM-ddT18:00:00" | get-date
        $now = get-date
        $interval = ($endTime - $now).tostring().Split('.')[0]
        if ($interval -gt 0) {
            "Away from get off work: {0}" -f $interval
        } else {
            "Done."
            $done = $false
        }
        start-sleep -second 1
    }
}


# add a consul kv about scripts content.
function Add-ScriptToConsulKv {
    param(
        $scriptPath,
        $apiKey = (DecStr $consulToken)
    )

    if (!(Test-Path $scriptPath)) {
        throw "The file $scriptPath is not existed."
    }

    # consul token.
    $key = (Get-ChildItem $scriptPath).Name
    $scriptFullPath = (Get-ChildItem $scriptPath).FullName # Actually not necessary

    $body = Get-Content -Encoding utf8 -Raw -Path $scriptFullPath

    $consulMainUrl = "http://consulmain.1hai.cn"
    $scriptUrl = $consulMainUrl + "/v1/kv/scripts/" + $key
    $scriptUiUrl = $consulMainUrl + "/ui/main/kv/scripts/" + $key + "/edit"

    $scriptUrlRaw = "$scriptUrl`?raw"
    Write-Output ("==> Add a consul key named <$key> `n" +
        "Remote exec script:`n" +
        "       win:   iex (irm $scriptUrlRaw)`n" +
        "       lin:   bash <(curl -s $scriptUrlRaw)`n" +
        "Script ui url: $scriptUiUrl")

    $headers = @{ "X-Consul-Token" = $apiKey }
    $resq = Invoke-WebRequest -Uri $scriptUrl `
        -Method 'PUT' `
        -headers $headers `
        -ContentType 'application/json; charset=utf-8' `
        -body $body `
        -UseBasicParsing

    if ($resq.statusCode -lt 400) {
        "Done"
    } else {
        throw "Registration failed."
    }
}

function GolangBuild {
    param (
        [switch]$window = $false,
        [switch]$linux = $false
    )
    if ($window) {
        go env -w CGO_ENABLED=1
        go env -w GOOS=windows
    }

    if ($linux) {
        go env -w CGO_ENABLED=0
        go env -w GOOS=linux
    }
}

function Batch-Ping {
    param (
        [string]$ipText
    )
    $ipList = $ipText.Split("`n")
    $result = @{}
    $ipList | % {
        $r = Test-Connection $_ -Count 1
        $status = $r.Status.ToString()
        if ($status) {
            $ttl = $r.Reply.Options.Ttl
            "$_`t$status, $ttl"
        } else {
            "$_`t$status"
        }
        $result[$_] = "$status, $ttl"
    }
    return $result
}

function Start-Resolve {
    param (
        $site,
        $server,
        $serverRoom
    )
    $res = Resolve-DnsName $site -Server $server 2> $null | ? { $_.name -eq $site }
    if ($res.Type -eq "A") {
        $record = $res.IPAddress
    } elseif ($res.Type -eq "CNAME") {
        $record = $res.NameHost
    } else { $record = $null }

    if (!($serverRoom)) { $serverRoom = "None" }

    return [PSCustomObject]@{
        ServerRoom = $serverRoom
        Server     = $server
        Site       = $res.Name
        TTL        = $res.TTL
        Type       = $res.Type
        Record     = $record
    }
}

function Get-Record {
    param(
        $site,
        $serverRoom,
        $server,
        [switch]$allDns = $false
    )
    $dnsServers = [ordered]@{
        YFB       = DecStr "ntz0Pa5PbqdMlcTtLiuicFsedPPY7HHtP7aPL+2l+gc="
        SH        = DecStr "dS/XKxqwQblxcZrfB9fJZvHj47Myc3ZaWOaSK6tdAt0="
        QS        = DecStr "LQnlQFnG5i9c8t880Kb7GBo1RUfAikuM8p+5LDhxgxU="
        SS        = DecStr "dEqtobJ5dQ5fFP3uPfT43MaeRMMnFuwWXZ55UxPC+To="
        SQ        = DecStr "zR48jCN8Z9Ibhb9vYM76Tx8fihahFOlcXVEtBaQh994="
        ZJ        = DecStr "B9Zs3PEoPz+dRh0NEca61rEtLnuuqizbM6ItOmC6G/0="
        QS_WS     = DecStr "nzJmr6RXBLFIg4SXVFlq1tGyDEcg/rnYySY+RT83Rmo="
        ZJ_OFFICE = DecStr "upcVaQC4w+OSxAMtN/8UhPJ58GW81tcvBdPonKiAAk4="
        TP_OFFICE = DecStr "yzGChAORXXwqo1Oz0sje9GzqFf+vtay0hjmyijkdr9U="
        OUTTER    = "114.114.114.114"
    }

    if (!($site)) {
        "Enter the site."
        return $null
    }

    if ($allDns) {
        # "==> Site ${site} dns record:"
        $allRes = @()
        foreach ($s in $dnsServers.Keys) {
            $allRes += Start-Resolve -site $site -server $dnsServers.$s -serverRoom $s
        }
        $allRes | Format-Table
        return
    }

    if (!($serverRoom) -or ($serverRoom -notin $dnsServers.Keys)) {
        if (!($server)) {
            "Wrong server-room or enter True DNS-server or server-room."
            return
        }
        Start-Resolve -site $site -server $server | Format-Table
        return
    }
    Start-Resolve -site $site -server $dnsServers.$serverRoom -serverRoom $serverRoom | Format-Table
}
