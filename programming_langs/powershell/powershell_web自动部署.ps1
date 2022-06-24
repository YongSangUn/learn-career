#用powershell脚本实现web站点自动部署
#用户要求将原来的多个文件合并成一个ps1文件实现web站点的自动部署，在合并过程中遇到两个问题：
#
#1. powershell 不区分大小写，所以在变量命名时一定要注意；
#
#2. 在合并中遇到这个异常：
#
#Exception setting "Protocol": "The configuration object is read only, because it has been committed by a call to #ServerManager.CommitChanges(). If write access is required, use ServerManager to get a new reference."
#At C:\v-zhdu\code\WebsiteDeployment\Website_Deployment.ps1:76 char:11
#+                 $bind. <<<< Protocol = $Binding.Protocol
#    + CategoryInfo          : InvalidOperation: (:) [], RuntimeException
#    + FullyQualifiedErrorId : PropertyAssignmentException
#
#根据提示，查看脚本，发现对站点的设置提交变化后，需要重新获取新的引用才可以获得写的权限，具体参见下面的script。
#
Website_Deployment.ps1:

#Get the path where the script is running

$scriptDir = Split-Path (Resolve-Path $myInvocation.MyCommand.Path)
write-host "Script Location: " $scriptDir -foregroundColor Green


[System.Reflection.Assembly]::LoadWithPartialName("Microsoft.Web.Administration")
$iis = New-Object Microsoft.Web.Administration.ServerManager

#Load the config file
[xml]$Config = get-content ($scriptDir + "\Config.xml")
$AppPools = $Config.Script




##############################RemoveSitePool-begin
foreach ($AppPool in $AppPools.ApplicationPool) { 
    foreach ($Site in $AppPool.Site) {
         
        #RemoveSite $Site.Name
        $website = $iis.Sites[$Site.Name]
        if ($website -ne $null) {
            $website.Delete()
            $iis.CommitChanges()
            Write-Host "Site Removed" -foregroundColor Green
        }          
    }
 
    #RemoveAppPool
    $pool = $iis.ApplicationPools[$AppPool.Name]
    if ($pool -ne $null) {
        $pool.Delete()
        $iis.CommitChanges()
        Write-Host "App Pool Removed" -foregroundColor Green
    } 
}

##############################RemoveSitePool-end

##############################CreateSitePool-begin
foreach ($AppPool in $AppPools.ApplicationPool) {
    #CreateAppPool
    $iis.ApplicationPools.Add($AppPool.Name)
    $pool = $iis.ApplicationPools[$AppPool.Name]
    $pool.ProcessModel.UserName = $AppPool.UserName
    $pool.ProcessModel.Password = $AppPool.Password
    $iis.CommitChanges()
    Write-Host "App Pool Created" -foregroundColor Green
 
    foreach ($Site in $AppPool.Site) {
         
        #CreateSite
 
        $website = $iis.Sites.CreateElement()
        $website.ID = $Site.ID
        $website.Name = $Site.Name
        $website.Applications.Add("/", $Site.PhysicalPath)
        $website.Applications["/"].ApplicationPoolName = $AppPool.Name
        $iis.Sites.Add($website)
        #$iis.CommitChanges()         #should be comment out, or will throw exception like 2#
        Write-Host "Site Created" -foregroundColor Green   
   
        foreach ($Binding in $Site.Binding) {                 
            #CreateBindingOnSite
            $bind = $website.Bindings.CreateElement()
            $bind.Protocol = $Binding.Protocol
            $bind.BindingInformation = "*:" + $Binding.Port + ":" + $Binding.HostName
            $website.Bindings.Add($bind)
            $iis.CommitChanges()
            Write-Host "Binding Created" -foregroundColor Green
                 
        }
       
        foreach ($Folder in $Site.Folder) {
            if ($Folder -ne $null) {
                #Create the folder if it does not exist
                $objFSO = New-Object -ComObject Scripting.FileSystemObject    
                if ($objFSO.FileExists($Folder -eq $FALSE)) {
                    Mkdir ($Folder.Name)
                }
            
                foreach ($Permission in $Folder.Permission) {
                    if ($Permission -ne $null) {
                        #Set the ACL permission on the folder
                        Cacls $folder.Name “/E” “/G” “$($permission.User):$($Permission.Capability)”
                    }
                }
                Write-Host "Completed Permissions Configuration for "  $Folder.name -foregroundColor Green
            }

        }
        Write-Host "Completed Folder Configuration for all folders" -foregroundColor Green         
 
    }

}

##############################CreateSitePool-end