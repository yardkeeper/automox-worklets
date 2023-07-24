$list=Get-Content "1.txt"

foreach ($user in $list) {
if (Test-Path -Path "C:\Users\$user\AppData\Local\slack") {


    $slk = Get-Process slack   -ErrorAction SilentlyContinue
    if ($slk) {
      $slk.CloseMainWindow()
      Sleep 1
      if (!$slk.HasExited) {
        $slk | Stop-Process -Force
      }
    }
    }
    #$slack_path="C:\Users\$user\AppData\Local\slack"
    
    echo $slack_path
    Start-Sleep -Seconds 2
    Start-Process "$slack_path\Update.exe" -ArgumentList --uninstall
    Remove-Item "$slack_path" -Recurse 
    msiexec /i ".\slack-standalone-4.32.122.0.msi"   INSTALLLEVEL=2 /qn /norestart

    }
    else {
    Exit 0
    }
