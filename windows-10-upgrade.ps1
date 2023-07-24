$udirectory = "c:\winupgrade"
$uurl = "https://go.microsoft.com/fwlink/?linkid=2171764"
$ufile = "$($udirectory)\winupgrade.exe"
$ErrorActionPreference = "SilentlyContinue"
$ucounter=0
$hostname = Get-WMIObject Win32_ComputerSystem| Select-Object -ExpandProperty Name

if ( -not ( Test-Path -Path $udirectory ) ) {
    
    mkdir -p $udirectory
}

else {
    Remove-Item -Path $ufile
}

$ComObj = New-Object System.Net.WebClient
$ComObj.DownloadFile($uurl,$ufile)
Start-Process -FilePath $ufile -ArgumentList "/quietinstall /skipeula /auto upgrade /copylogs $udirectory"

while ($true) {


$WinUpdateApp = Get-Process Windows10UpgraderApp -ErrorAction $ErrorActionPreference
$SHost = Get-Process setuphost -ErrorAction $ErrorActionPreference

if (($WinUpdateApp) -and  (!$SHost)) {

Start-Sleep -Seconds 60
   
}

elseif (($WinUpdateApp) -and  ($SHost) -and ($ucounter -ne "1")) {
    $ucounter++

    Start-Sleep -Seconds 60
}

elseif (($WinUpdateApp) -and  ($SHost) -and ($ucounter -eq "1")) {
   
    Start-Sleep -Seconds 60

}

elseif (($WinUpdateApp) -and  (!$SHost) -and ($ucounter -ne "1")) {
    Write-Output "Windows has updated to new version. Please restart your computer"
    Start-Sleep -Seconds 30

   Break

#Msg /server:$hostname/ * Message "Windows has updated to new version. Please restart your computer"

}


}

Exit 0
