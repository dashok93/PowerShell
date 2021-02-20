﻿# By Tom Chantler - https://tomssl.com/2019/04/30/a-better-way-to-add-and-remove-windows-hosts-file-entries/ 
param([string]$DesiredIP = "127.0.0.1" ,
[string]$Hostname = "gwsuathangfire.autodecisioningplatform.com" ,
[bool]$CheckHostnameOnly = $false) 
# Adds entry to the hosts file. 
#Requires -RunAsAdministrator 
$hostsFilePath = "$($Env:WinDir)\system32\Drivers\etc\hosts" 
$hostsFile = Get-Content $hostsFilePath 
Write-Host "About to add $desiredIP for $Hostname to hosts file" -ForegroundColor Gray 
$escapedHostname = [Regex]::Escape($Hostname) 
$patternToMatch = If ($CheckHostnameOnly) { ".*\s+$escapedHostname.*" } Else { ".*$DesiredIP\s+$escapedHostname.*" } 
If (($hostsFile) -match $patternToMatch) { 
Write-Host $desiredIP.PadRight(11," ") "$Hostname - not adding; already in hosts file" -ForegroundColor DarkYellow 
}
 Else { 
 Write-Host $desiredIP.PadRight(11," ") "$Hostname - adding to hosts file... " -ForegroundColor Yellow -NoNewline 
 Add-Content -Encoding UTF8 $hostsFilePath ("`n$DesiredIP".PadRight(11, " ") + "$Hostname") 
 Write-Host " done" 
 }