$ARecord = Get-WmiObject -Namespace root\MicrosoftDNS -class microsoftdns_atype | ? { $_.OwnerName -eq "$using:name" }; $ARecord.delete()

Add-DnsServerResourceRecordA -zonename 1hai.cn -name $using:name -ipaddress $using:ip
dnscmd . /RecordAdd 1hai.cn $using:name A $using:ip

$dnsClass = [WMIClass]"ROOT\MicrosoftDNS:MicrosoftDNS_AType"
$containerName = "bookingmgmt.1hai.cn"
$dnsServerName = $containerName
[string]$ip = "193.112.238.242"
$dnsClass.CreateInstance(

)
Ivk-C 172.31.40.10 admin {
    $ip = ((route print | findstr "0.0.0.0.*0.0.0.0") -replace "\s{2,}", " ").split()[4]
    $sites = (Get-WmiObject -Namespace root\MicrosoftDNS -class microsoftdns_atype |
        ? { $_.ownername -match ".1hai.cn$" })
    $count = $sites.count
    "`n--- $ip, Total Sites: $count"
    $sites | % { ($_.ownername + "`t" + $_.recordData) }
}
Ivk-C 172.31.40.10 admin {
    $ip = ((route print | findstr "0.0.0.0.*0.0.0.0") -replace "\s{2,}", " ").split()[4]
    $sites = (Get-WmiObject -Namespace root\MicrosoftDNS -class microsoftdns_atype |
        ? { $_.ownername -match ".1hai.cn$" })
    $count = $sites.count
    #$sites | % { ($_.ownername) }
    #"`n--- $ip, Total Sites: $count"
    $sites | % { ($_.ownername + "`t" + $_.recordData) }
}

$all = ($ssDns | % {
        foreach ($site in $sqDns) {
            $_ | ? { $site.split()[0] -contains $_.split()[0] }
        }
    })