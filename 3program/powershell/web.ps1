Update:

 I got this now.


Param
(
 [String]$Name,    #The Name of the site
 [String]$Path="c:\inetpub\wwwroot",    #The Physical Path of the site
 [String]$AppPool="My Default Application Pool",  #The name of the appPool the default app is part of
 [Int]$SiteID

)
 
[System.Reflection.Assembly]::LoadWithPartialName("Microsoft.Web.Administration")
$iis = new-object Microsoft.Web.Administration.ServerManager
#$Site = $iis.Sites.Add($Name, $Path, 8080)
#$Site.ServerAutoStart = $true
$Site = $iis.Sites.CreateElement()
$Site.ID = $SiteID
$Site.Name = $Name
$Site.Applications.Add("/", $Path)
$Site.Applications["/"].ApplicationPoolName = $AppPool
$iis.Sites.Add($Site)
$iis.CommitChanges()

$objIIS = new-object System.DirectoryServices.DirectoryEntry("C:\test\test")
$objIIS | get-member("NewFolder","C:\test")






This first part creates a new Site:
$iis = new-object Microsoft.Web.Administration.ServerManager
$iis.Sites.Add("NewSite", "c:temp", 8080)
$iis.CommitChanges()

This actually deletes that new site:
$iis = new-object Microsoft.Web.Administration.ServerManager
$iis.Sites | where {$.Name -eq "NewSite"} | foreach{ $iis.Sites.Remove($) }
$iis.CommitChanges()


c:\windows\system32\inetsrv\appcmd list site /config /xml > c:\sites.xml
c:\windows\system32\inetsrv\appcmd add site /in < c:\sites.xml
c:\windows\system32\inetsrv\appcmd list apppool /config /xml > c:\apppools.xml
c:\windows\system32\inetsrv\appcmd add apppool /in < c:\apppools.xml

# 下面的同上面的一样，只用复制一个文件即可，（但是不能复制加密信息）
c:\windows\/System32/inetsrv/config/applicationHost.config  