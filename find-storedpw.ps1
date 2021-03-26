###Created:Mar 25 2021###
###Modified:Mar 26 2021###
###Author:Kristopher Roy###
###Company:Belltechlogix###

#Variables for output and scan location
$rptfolder = "c:\reports\"
$report = $rptfolder+"clearinfo.log"
$Drives = Get-PSDrive -PSProvider 'FileSystem'

#creates the report folder if it doesn't exist
if(!(Test-Path -Path $rptfolder)){
    New-Item -ItemType directory -Path $rptfolder
}

$stamp = get-date
'-------------------------'+$stamp+'--------------------------'| Add-Content $report

#loops through each drive on the filesystem
foreach($Drive in $drives) {
'--------------------'+$Drive+'---------------------'| Add-Content $report
$Drive
#limits the file types to scan
$files = Get-ChildItem $Drive.Root -Recurse -File -include "*.ps1","*.bat","*.txt","*.doc","*.rtf","*.vbs"|where{$_.fullname -notlike "*.ps1x"}
(($files|where-object{$_.fullname -like "*.ps1"}).count).tostring()+" Total ps1 files"| Add-Content $report
(($files|where-object{$_.fullname -like "*.bat"}).count).tostring()+" Total bat files"| Add-Content $report
(($files|where-object{$_.fullname -like "*.txt"}).count).tostring()+" Total txt files"| Add-Content $report
(($files|where-object{$_.fullname -like "*.doc"}).count).tostring()+" Total doc files"| Add-Content $report
(($files|where-object{$_.fullname -like "*.rtf"}).count).tostring()+" Total rtf files"| Add-Content $report
(($files|where-object{$_.fullname -like "*.vbs"}).count).tostring()+" Total vbs files"| Add-Content $report
$i = 0
FOREACH($file in $files){
    $count = $files.count
        $i++
        Write-Progress -Activity ("files read...") -Status "read $i of $($count) files" -PercentComplete ($i/$Count*100) 
        
		#Checks each file for the string inside of the content
		If($file|Get-Content| Select-String -Pattern "AsPlainText")
        {
            "------------------File:------------------"| Add-Content $report
            ($file|select fullname).fullname|Add-Content $report
            $file|Get-Content| Select-String -Pattern "AsPlainText"| Add-Content $report
        }
        If($file|Get-Content| Select-String -Pattern "password")
        {
            "------------------File:------------------"| Add-Content $report
            ($file|select fullname).fullname|Add-Content $report
            $file|Get-Content| Select-String -Pattern "password"| Add-Content $report
        }
         If($file|Get-Content| Select-String -Pattern "pw=")
        {
            "------------------File:------------------"| Add-Content $report
            ($file|select fullname).fullname|Add-Content $report
            $file|Get-Content| Select-String -Pattern "pw="| Add-Content $report
        }
         If($file|Get-Content| Select-String -Pattern "pwd=")
        {
            "------------------File:------------------"| Add-Content $report
            ($file|select fullname).fullname|Add-Content $report
            $file|Get-Content| Select-String -Pattern "pwd="| Add-Content $report
        }
         If($file|Get-Content| Select-String -Pattern "pwd=")
        {
            "------------------File:------------------"| Add-Content $report
            ($file|select fullname).fullname|Add-Content $report
            $file|Get-Content| Select-String -Pattern "set/p"| Add-Content $report
        }
         If($file|Get-Content| Select-String -Pattern "pwd=")
        {
            "------------------File:------------------"| Add-Content $report
            ($file|select fullname).fullname|Add-Content $report
            $file|Get-Content| Select-String -Pattern "pass="| Add-Content $report
        }
    }
}