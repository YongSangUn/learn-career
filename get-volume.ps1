$diskName = (Get-Volume | ? { $_.DriveType -match 'CD-ROM' })
if ($diskName) {
    "CD-ROM exists."
    $diskPart = $diskName.DriveLetter + ":"
    if ($diskName.DriveLetter) {
        Write-Output "Start remove $diskPart ."
        mountvol $diskPart /d
    }
    else { "But no driver letter." }

}
else { "No CD-ROM." }