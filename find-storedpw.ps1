###Created:Mar 25 2021###
###Modified:Mar 25 2021###
###Author:Kristopher Roy###
###Company:Belltechlogix###

#Variables for output and scan location
$rptfolder = "c:\reports\"
$report = "clearinfo.log"
$Drives = Get-PSDrive -PSProvider 'FileSystem'

#creates the report folder if it doesn't exist
if(!(Test-Path -Path $rptfolder)){
    New-Item -ItemType directory -Path $rptfolder
}

#loops through each drive on the filesystem
foreach($Drive in $drives) {
$Drive
#limits the file types to scan
$files = Get-ChildItem $Drive.Root -Recurse -File -include "*.ps1","*.bat","*.txt","*.doc","*.rtf","*.vbs"|where{$_.fullname -notlike "*.ps1x"}
$i = 0
FOREACH($file in $files){
    $count = $files.count
        $i++
        Write-Progress -Activity ("files read...") -Status "read $i of $($count) files" -PercentComplete ($i/$Count*100) 
        
		#Checks each file for the string inside of the content
		If($file|Get-Content| Select-String -Pattern "AsPlainText")
        {
            "--------------------------File:--------------------------"| Add-Content $report
            ($file|select fullname).fullname|Add-Content $report
            $file|Get-Content| Select-String -Pattern "AsPlainText"| Add-Content $report
        }
        If($file|Get-Content| Select-String -Pattern "password")
        {
            "--------------------------File:--------------------------"| Add-Content $report
            ($file|select fullname).fullname|Add-Content $report
            $file|Get-Content| Select-String -Pattern "password"| Add-Content $report
        }
         If($file|Get-Content| Select-String -Pattern "pw=")
        {
            "--------------------------File:--------------------------"| Add-Content $report
            ($file|select fullname).fullname|Add-Content $report
            $file|Get-Content| Select-String -Pattern "pw="| Add-Content $report
        }
         If($file|Get-Content| Select-String -Pattern "pwd=")
        {
            "--------------------------File:--------------------------"| Add-Content $report
            ($file|select fullname).fullname|Add-Content $report
            $file|Get-Content| Select-String -Pattern "pwd="| Add-Content $report
        }
         If($file|Get-Content| Select-String -Pattern "pwd=")
        {
            "--------------------------File:--------------------------"| Add-Content $report
            ($file|select fullname).fullname|Add-Content $report
            $file|Get-Content| Select-String -Pattern "set/p"| Add-Content $report
        }
         If($file|Get-Content| Select-String -Pattern "pwd=")
        {
            "--------------------------File:--------------------------"| Add-Content $report
            ($file|select fullname).fullname|Add-Content $report
            $file|Get-Content| Select-String -Pattern "pass="| Add-Content $report
        }
    }
}