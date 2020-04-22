$ARecord=Get-WmiObject -Namespace root\MicrosoftDNS -class microsoftdns_atype | ? {$_.OwnerName -eq "$using:name"};$ARecord.delete()

Add-DnsServerResourceRecordA -zonename 1hai.cn -name $using:name -ipaddress $using:ip
dnscmd . /RecordAdd 1hai.cn $using:name A $using:ip

$dnsClass = [WMIClass]"ROOT\MicrosoftDNS:MicrosoftDNS_AType"
$containerName = "bookingmgmt.1hai.cn"
$dnsServerName = $containerName
[string]$ip = "193.112.238.242"
$dnsClass.CreateInstance(


