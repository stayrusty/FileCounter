# FileCounter

FileCounter is a simple tool used to count files in a given directory and group them by file extension.

## Installation

No installation necessary, just grab a release.

## Building

Build script is included.

### To build an executable:

Use ps2exe (Requires PowerShell 3.0 or higher)
```powershell
Install-Module -Name ps2exe
```

### To build a PowerShell script:

Remove the following lines from build.ps1
```powershell
Invoke-ps2exe .\combined.ps1 .\FileCounter.exe -iconFile .\resources\icon.ico -title "FileCounter" -version 1.0.0.0000
Remove-Item .\combined.ps1
```

## Contributing

Pull requests are welcome.