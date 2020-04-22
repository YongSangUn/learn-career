$Env:Path += ";C:\Temp"
Import-Module C:\Users\31216\Documents\WindowsPowerShell\Modules\set-cred.psm1


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