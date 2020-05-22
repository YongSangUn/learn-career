function Get-UserConfig {
    param (
        [string]$value
    )
    # create credential by user & passwd.
    $dcUser = 'ehi\31216'
    $secret = '01000000d08c9ddf0115d1118c7a00c04fc297eb0100000028676443ed3f814eb6f3571e1d29e44b0000000002000000000003660000c000000010000000bc3ef496a7fcf1f2d5a93b32b14182a30000000004800000a00000001000000086b4c4d19e0eebf4da24a26f662cced818000000f366c778e1faddc9bec283b30c400879ed6bc65f2c310d8f14000000704406f99364ef0cc0313c60e5afb56373ff2970'
    $dcPasswd = $secret | ConvertTo-SecureString
    $cred = New-Object System.Management.Automation.PSCredential($dcUser, $dcPasswd)

    # judgment parameter is employeeID or Name.
    try { [int]$employeeID = $value }
    catch { [string]$userName = $value }

    # determine query parameters.
    if ($employeeID) { $filter = "SamAccountName -like $employeeID" }
    if ($userName) { $filter = "Name -like '$userName'" }

    # query data
    Invoke-Command -ScriptBlock { Get-ADUser -Filter $using:filter | FT  SamAccountName, Name, DistinguishedName | Out-String } `
        -ComputerName 192.168.9.10 -Credential $cred
}

# stop until the input is empty.
$employeeID = Read-Host "Please enter a EmployeeID or Name: "
while ($employeeID) {
    Get-UserConfig $employeeID
    $employeeID = Read-Host "Please enter a EmployeeID or Name: "
}