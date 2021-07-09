$filecounter = Get-Process -Name "filecounter" -ErrorAction SilentlyContinue
$scripts = "scripts\global.ps1", "scripts\functions.ps1", "scripts\main.ps1"

if ($filecounter) { Stop-Process -Name "filecounter" }

(Get-Item $scripts | ForEach-Object { 
    "`n{0}`n" -f (Get-Content -Raw $_.FullName) 
  }) -join "`n`n" > "combined.ps1"

Invoke-ps2exe .\combined.ps1 .\FileCounter.exe -iconFile .\resources\icon.ico -title "FileCounter" -version 1.0.1.0000
Remove-Item .\combined.ps1
#&.\FileCounter.exe