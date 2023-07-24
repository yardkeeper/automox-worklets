.\CleanZoom.exe /silent
$oom=Get-WmiObject Win32_Product | Where-Object {$_.Name -like "*oom*"} |Format-Table  Name
if ($oom) {

if (Test-Path -Path C:\zoominstaller) {
Remove-Item 'C:\zoominstaller\ZoomDirect.msi'
} else {
New-Item -Path "c:\" -Name "zoominstaller" -ItemType "directory"
}

Invoke-WebRequest -Uri https://zoom.us/client/latest/ZoomInstallerFull.msi -UseBasicParsing -OutFile C:\zoominstaller\ZoomDirect.msi
Start-Process msiexec.exe  -ArgumentList  '/i C:\zoominstaller\ZoomDirect.msi /quiet /qn /norestart'
}
else {
Write-Output "Zooom not installed"
Exit 0
}
