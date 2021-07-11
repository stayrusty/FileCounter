Function Test-MyPath ($path) {
    if (Test-Path -Path $path) { 
        Write-Host -NoNewLine $path -ForegroundColor Green
        Write-Host " found! Now counting files..."
        ""

        $global:Path = $path
    }
    else {   
        Write-Host -NoNewLine $path -ForegroundColor Red
        Write-Host -NoNewLine " is not a valid directory! Enter new directory to count (blank = list of directories) or Ctrl+C to exit: " 
        $path = $Host.UI.ReadLine()
        ""

        if ($path) { Test-Item $path }
        else { $global:Path = $null }
    }
}

Function Get-FileSizeString ($item) {
    if ($item -gt 1TB) {
        $str_size = [string][math]::Round(($item) / 1TB, 2) + " TB"
    }
    elseif ($item -gt 1GB) {
        $str_size = [string][math]::Round(($item) / 1GB, 2) + " GB"
    }
    elseif ($item -gt 1MB) {
        $str_size = [string][math]::Round(($item) / 1MB, 2) + " MB"
    }
    elseif ($item -gt 1KB) {
        $str_size = [string][math]::Round(($item) / 1KB, 2) + " KB"
    }
    else {
        $str_size = [string][math]::Round(($item), 2) + " B"
    }
    return $str_size
}