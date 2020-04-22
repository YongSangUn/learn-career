# 获取
# 172.20
param (
    [Parameter(Mandatory = $true,
        Position = 0,
        HelpMessage = "Please enter first & second & third digits of the IPv4.")]
    # Match ip address: 172.x.x & 192.x.x ,
    [ValidatePattern("^1[7-9]2\.(25[0-5]|2[0-4]\d|[0-1]?\d\d?)\.(25[0-5]|2[0-4]\d|[0-1]?\d\d?)$")]
    [String[]]
    $ip123
)

$ipTrue = @()           # create a new array for successful Ping.
$ipFlase = @()          # create a new array for failed Ping.

# start ping $ip
Write-Host -ForegroundColor Green "### Strat Ping $ip123.[1-255] ..... "
for ($i = 1; $i -le 255; $i += 1) {
    $ip = "$ip123.$i"                   # real ipAddress
    ping -w 2 -n 1 $ip
    #ping -w 2 -n 1 $ip | Out-Null       # ping without output.

    # if ping successful, add to [array]$ipTrue;
    # else ping failed , add to [array]$ipFalse.
    if ($? -eq $true) {
        $ipTrue += $ip
    }
    else {
        $ipFalse += $ip
    }
}
$count = $ipTrue.count
Write-Host -ForegroundColor Green "### Complate, the number of ipaddress used on the subnet $ip123.[1-255] is $count. "

# complate ,export ping-successful to file.
$ipTrue | Set-Content .\ping_successful.txt
Write-Host -ForegroundColor Green "### export to file ping_successful.txt. "


