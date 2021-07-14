##############################  Powerline & CLI Settings  ##############################

## Powershell Line
# https://docs.microsoft.com/en-us/windows/terminal/tutorials/powerline-setup
try {
    Import-Module posh-git
    Import-Module oh-my-posh
} catch {
    Install-Module posh-git -Scope CurrentUser -Force
    Install-Module oh-my-posh -Scope CurrentUser -RequiredVersion 2.0.496 -Force

    ## oh-my-posh v3 setting (V3 powerline display error.)
    # Install-Module oh-my-posh -Scope CurrentUser -Force

    Import-Module posh-git
    Import-Module oh-my-posh

    # Install-Module -Name PSReadLine -Scope CurrentUser -Force -SkipPublisherCheck
    # link: https://ohmyposh.dev/docs/upgrading/
    # Update-Module -Name oh-my-posh -AllowPrerelease -Scope CurrentUser
}

$_ps = $PSVersionTable
$_psVersion = $_ps.PSVersion
$_psEdition = $_ps.PSEdition

if ($_psVersion.Major -eq 5) {
    $theme = "Honukai" # powershell v5
} else {
    $theme = "Emodipt" # powershell v7
}

try {
    Set-Theme $theme # oh-my-posh v2
} catch {
    Set-PoshPrompt $theme # oh-my-posh v3
}

# Set the prediction text source to history
try { Set-PSReadLineOption -PredictionSource History }catch {}

## install gsudo, allow the current CLI to elevate administrator authority.
# Set-ExecutionPolicy RemoteSigned -scope Process;
# iwr -useb https://raw.githubusercontent.com/gerardog/gsudo/master/installgsudo.ps1 | iex

## Display powershell version
Write-Host "==> Powershell Version: $_psEdition $_psVersion`n" -ForegroundColor Green

## CLI encoding use utf8.
# [System.Console]::OutputEncoding = [System.Text.Encoding]::GetEncoding(65001)
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8


##############################  Paramters  ##############################

### profile.ps1 file.
$myProfile = $PROFILE.CurrentUserAllHosts

## Terminal
$wtJsonFile = "$HOME\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json"
$wtDefaultJsonFile = "C:\Program Files\WindowsApps\Microsoft.WindowsTerminal_1.0.1401.0_x64__8wekyb3d8bbwe\defaults.json"

$desk = "$HOME\desktop"

## Git directory.
$gitMainDir = "D:\git"
$starGit = Join-Path $gitMainDir "0star"
$learnGit = Join-Path $gitMainDir "learn-career"
$nocResourceGit = Join-Path $gitMainDir "noc.resource"
$qcloudGit = Join-Path $nocResourceGit '0project\qcloud.sdk'
$nocWikiGit = Join-Path $gitMainDir "noc.wiki"

## Python Dir
$pythonPkg = "C:\python38\Lib\site-packages\"


##############################  Functions  ##############################

## encoding & decoding.
function ET {
    param (
        [string]$text
    )
    $bytes = [System.Text.Encoding]::Unicode.GetBytes($text)
    $encodedText = [Convert]::ToBase64String($bytes)
    return $encodedText
}
function DT {
    param (
        [string]$text
    )
    $bytes = [Convert]::FromBase64String($text)
    $encodingText = [System.Text.Encoding]::Unicode.GetString($bytes)
    return $encodingText
}

## Ps remote settings
function Get-Cred {
    # get the ps-credential by name.
    param(
        [string]$user
    )
    # local
    $userAdmin = "administrator"
    $passwdAdmin = DT $env:passwdAdmin | ConvertTo-SecureString -asPlainText -Force
    $passwdAdmin1 = DT $env:passwdAdmin1 | ConvertTo-SecureString -asPlainText -Force
    $passwdAdmin3 = DT $env:passwdAdmin3 | ConvertTo-SecureString -asPlainText -Force
    $passwdAdminQ = DT $env:passwdAdminQ | ConvertTo-SecureString -asPlainText -Force
    # domain
    $userDomain = "ehai\administrator"
    $userDomainC = "ehaic\administrator"
    $userDomainCar = "ehicar\administrator"
    $passwdDomain = DT $env:passwdDomain | ConvertTo-SecureString -asPlainText -Force
    # domain web
    $userDomainWebSH = 'ehi\webadmin'
    $userDomainWebCar = 'callcenter\webadmin'
    $passwdDomainWeb = DT $env:passwdDomainWeb | ConvertTo-SecureString -asPlainText -Force


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
        domainwebcar = $userDomainWebCar, $env:passwdDomainWeb
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
        if (!($port)) { $port = $env:winPort }
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
        $port,
        $cred
    )
    $credDict = @{
        admin  = $env:passwdAdmin
        admin1 = $env:passwdadmin1
        admin3 = $env:passwdAdmin3
        aaa    = $env:passwdAaa
    }

    if (!($cred)) {
        if (!($port)) {
            # eg: leps 1.1.1.1
            $cred = "admin"
            $port = $env:linPort
        }
        if ($port.GetTypeCode() -eq "Int32") {
            # eg: leps 1.1.1.1 12345
            $cred = "admin"
        } else {
            # eg: leps 1.1.1.1 admin
            $cred = $port
            $port = $env:linPort
        }
    }
    while ($true) {
        if ($credDict.Keys -contains $cred) {
            $passwd = DT $credDict.$cred
            $user = "root"
        } else {
            $user = $cred
            $passwd = Read-Host "Enter a Password"
        }

        bash -c "sshpass -p '$passwd' ssh -p $port $user@$ip -o StrictHostKeyChecking=no"
        if ($?) {
            break
        } else {
            $cred = Read-Host "Enter a credential or user"
        }
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
        admin  = $env:passwdAdmin
        admin1 = $env:passwdadmin1
        admin3 = $env:passwdAdmin3
        aaa    = $env:passwdAaa
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

    if (!($port)) { $port = $env:linPort }
    if (!($cred)) { $cred = "admin" }
    $passwd = DT $credDict.$cred

    # Write-Host "sshpass -p '$passwd' scp -P $port $source $destination"
    bash -c "sshpass -p '$passwd' scp -P $port $source $destination"
}
function SangUn-Centos {
    # My Centos Server.
    ssh -p $env:myCentosHostPort $env:myCentosHost
}
function Ipy3 {
    # use wsl launch ipython3.
    bash -c 'ipy3'
}
function Qt { exit }


### -------------------vim settings-------------------------###
# There's usually much more than this in my profile!
$SCRIPTPATH = "D:\0Program Files\Vim"
$VIMPATH = $SCRIPTPATH + "\vim82\vim.exe"
Set-Alias vi $VIMPATH
Set-Alias vim $VIMPATH
# for editing your PowerShell profile
Function Edit-Profile { vim $profile }
# for editing your Vim settings
Function Edit-Vimrc { vim $home\_vimrc }

