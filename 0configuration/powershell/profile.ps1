# [System.Console]::OutputEncoding = [System.Text.Encoding]::GetEncoding(65001)
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

### profile.ps1 file.
$myProfile = "$HOME\Documents\WindowsPowerShell\profile.ps1"
$wtJsonFile = "$HOME\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json"
$wtDefaultJsonFile = "C:\Program Files\WindowsApps\Microsoft.WindowsTerminal_1.0.1401.0_x64__8wekyb3d8bbwe\defaults.json"

$desk = "$HOME\desktop"

$starGit = "D:\2git\0star-repo"
$learnGit = "D:\2git\learn-career"
$pythonPkg = "C:\python38\Lib\site-packages\"

function EncT {
    param (
        [string]$text
    )
    $bytes = [System.Text.Encoding]::Unicode.GetBytes($text)
    $encodedText = [Convert]::ToBase64String($bytes)
    return $encodedText
}

function DecT {
    param (
        [string]$text
    )
    $bytes = [Convert]::FromBase64String($text)
    $encodingText = [System.Text.Encoding]::Unicode.GetString($bytes)
    return $encodingText
}

function Get-Cred {
    ### set credential.
    param(
        [string]$user
    )
    # local
    $userAdmin = "administrator"
    $passwdAdmin = DecT "xxxxxxxxx" | ConvertTo-SecureString -asPlainText -Force

    # User-list: key: userNicename; value1: username, values2: userpassword.
    $creds = @{
        admin = $userAdmin, $passwdAdmin
    }

    $cred = New-Object System.Management.Automation.PSCredential($creds.$user[0], $creds.$user[1])
    return $cred
}

function NPS {
    ### new pssesion
    param (
        [string]$ip,
        [string]$credName
    )
    try { New-PSSession $ip -Credential (Get-Cred $credName) }
    catch { New-PSSession $ip -Credential $credName }
}

function du($dir = ".") {
    get-childitem $dir | % {
        $f = $_
        get-childitem -r $_.FullName |
        measure-object -property length -sum |
        select @{Name = "Name"; Expression = { $f } }, sum }
}

function Ivk-C {
    ### set invoke-command
    param (
        [string]$ip,
        [string]$credName,
        [scriptblock]$scripts
    )
    try { Invoke-Command $ip -Credential (Get-Cred $credName) -ScriptBlock $scripts }
    catch { Invoke-Command $ip -Credential $credName -ScriptBlock $scripts }
}

function EPS {
    ### set enter-pssession.
    param (
        [string]$ip,
        [string]$credName
    )
    if (!($credName)) { $credName = "admin" }

    try { Enter-PsSession $ip -Credential (Get-Cred $credName) }
    catch { Enter-PsSession $ip -Credential $credName }
}

function WEPS {
    param (
        $ip,
        $port
    )
    if (($ip) -and ($port)) {
        mstsc /v:${ip}:${port}
    } else {
        "--> Please enter the correct parameters.`n`t$ Eps-Win 10.10.10.10 12345"
    }
}

function LEPS {
    param (
        [string]$ipAndPort,
        [string]$cred
    )
    $credDict = @{
        admin = "xxxxxxxxxxxx"
    }

    $ip = $ipAndPort.Split(":")[0]
    $port = $ipAndPort.Split(":")[1]
    if (!($port)) { $port = 27864 }

    if (!($cred)) { $cred = "admin" }
    $passwd = DecT $credDict.$cred

    bash -c "sshpass -p '$passwd' ssh -p $port root@$ip"
}

function WCP {
    ### copy item remote.
    # Usages:
    #     scp 172.20.1.1,c:\test.txt c:\ admin
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
    # $ LSCP 1.1.1.1:12345,/dir/file /dir2/ cred-name
    param (
        [string]$file,
        [string]$target,
        [string]$cred
    )
    $credDict = @{
        admin = "xxxxxxxxxxxxx"
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

    if (!($port)) { $port = 27864 }
    if (!($cred)) { $cred = "admin" }
    $passwd = DecT $credDict.$cred

    # Write-Host "sshpass -p '$passwd' scp -P $port $source $destination"
    bash -c "sshpass -p '$passwd' scp -P $port $source $destination"
}

# use wsl launch ipython3.
function Ipy3 { bash -c 'ipy3' }
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


### --------------------powershell line-------------------- ###
# Install-Module posh-git -Scope CurrentUser
# Install-Module oh-my-posh -Scope CurrentUser
Import-Module posh-git
Import-Module oh-my-posh
Set-Theme Honukai
