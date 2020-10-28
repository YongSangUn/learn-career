# How to sync the time

For those that still asking this question

1. To update, use the command below (2008 and 2012 server compatible)

   w32tm /config /manualpeerlist:"ntp_server" /syncfromflags:manual /reliable:yes /update
   change the ntp_server with your source

2. Restart the time service

   net stop w32time
   net start w32time

3. Resync the time

   w32tm /resync

4. Verify your sync status

   w32tm /query /status

Commands above should be fine if your sources are working correctly and/or your connection is OK (firewall or Microsoft Forefront can be an issue also). The commands below can help with troubleshooting

- To list out peers

  w32tm /query /peers

- To list out NTP Sources:

  w32tm /query /source
