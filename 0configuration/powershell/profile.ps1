### profile.ps1 file.
$myProfile = "$HOME\Documents\WindowsPowerShell\profile.ps1"
$wtJsonFile = "$HOME\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json"
$wtDefaultJsonFile = "C:\Program Files\WindowsApps\C:\Program Files\WindowsApps\Microsoft.WindowsTerminal_*\defaults.json"
$learnGit = "D:\4learn\1git\learn-career"
$gitDir = "D:\4learn\1git"

### set credential.

### new pssesion

function Ipy3 {
    bash -c "ipython3"
}

function NPS {
    param (
        [string]$ip,
        [string]$credName
    )
    try { New-PSSession $ip -Credential (Get-Cred $credName) }
    catch { New-PSSession $ip -Credential $credName }
}


### set enter-pssession.
function EPS {
    param (
        [string]$ip,
        [string]$credName
    )
    try { Enter-PsSession $ip -Credential (Get-Cred $credName) }
    catch { Enter-PsSession $ip -Credential $credName }
}


### set invoke-command
function Ivk-C {
    param (
        [string]$ip,
        [string]$credName,
        [scriptblock]$scripts
    )
    try { Invoke-Command $ip -Credential (Get-Cred $credName) -ScriptBlock $scripts }
    catch { Invoke-Command $ip -Credential $credName -ScriptBlock $scripts }
}


### copy item remote.
# Usages:
#     scp 172.20.1.1,c:\test.txt c:\ admin
#               -eq
#     Copy-Item C:\test.txt -Destination c:\ -ToSession (EPS 172.20.1.1 admin)
function SCP {
    param (
        [string]$file,
        [string]$destination,
        [string]$credName,
        [switch]$f
    )
    # judge session style.
    if ($file.Split()[0] -eq $file) { $sessionStyle = "To" }
    elseif ($destination.Split()[0] -eq $destination) { $sessionStyle = "From" }

    if ( $sessionStyle -eq "To" ) {
        $ip = $destination.Split()[0]
        $session = NPS $ip $credName
        if ($f) {
            Copy-Item $file -Destination $destination.Split()[1] -ToSession $session -Recurse -Force
        }
        else {
            Copy-Item $file -Destination $destination.Split()[1] -ToSession $session -Recurse
        }
    }
    elseif ($sessionStyle -eq "From") {
        $ip = $file.Split()[0]
        $session = NPS $ip $credName
        if ($f) {
            Copy-Item $file.Split()[1] -Destination $destination -FromSession $session -Recurse -force
        }
        else {
            Copy-Item $file.Split()[1] -Destination $destination -FromSession $session -Recurse
        }
    }
}


### vim settings
# There's usually much more than this in my profile!
$SCRIPTPATH = "D:\0Program Files\Vim"
$VIMPATH = $SCRIPTPATH + "\vim82\vim.exe"
Set-Alias vi $VIMPATH
Set-Alias vim $VIMPATH
# for editing your PowerShell profile
Function Edit-Profile { vim $profile }
# for editing your Vim settings
Function Edit-Vimrc { vim $home\_vimrc }


### run powershell as administrator
function Pws-Admin {
    start-process PowerShell -verb runas
}


### powershell line
Import-Module posh-git
Import-Module oh-my-posh
Set-Theme Honukai
