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

## Usage

### Application Start

<a href="https://postimg.cc/4KfpHtCt" target="_blank"><img src="https://i.postimg.cc/pd8C7Yq0/1-Application-Start.jpg" alt="1-Application-Start"/></a>

### List Directories

<a href="https://postimg.cc/0M3S4Bzd" target="_blank"><img src="https://i.postimg.cc/hv40XFgw/2-List-of-Directories.jpg" alt="2-List-of-Directories"/></a>

### Choose Directory

<a href="https://postimg.cc/HJ6XwxHN" target="_blank"><img src="https://i.postimg.cc/XJbL0GPn/3-Enter-directory.jpg" alt="3-Enter-directory"/></a>

### Results Display

<a href="https://postimg.cc/47ntBgxx" target="_blank"><img src="https://i.postimg.cc/L5h47PDk/4-Results.jpg" alt="4-Results"/></a>

## Contributing

Pull requests are welcome.