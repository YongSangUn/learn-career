$a = Get-WmiObject -Namespace root\MicrosoftDNS -class microsoftdns_atype  |Format-List -Property ownername,ipaddress
$ip = {
    "118.25.169.76",
    "212.64.99.110",
    "211.159.211.86",
    "212.64.99.201",
    "49.234.171.134",
    "118.25.165.119",
    "123.206.249.79"
}

$a | if ($_ -match $text[1]){
    $_
}

Get-WmiObject -Namespace root\MicrosoftDNS -class microsoftdns_atype | ? {$_.ipaddress -eq "123.206.249.79"}|Format-List -Property ownername
