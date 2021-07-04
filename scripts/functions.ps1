Function Test-Item ($item) {
    if (Test-Path -Path $item) { 
        Write-Host -NoNewLine $item -ForegroundColor Green
        Write-Host " found! Now counting files..."
        ""

        $global:Path = $item 
    }
    else {   
        Write-Host -NoNewLine $item -ForegroundColor Red
        Write-Host -NoNewLine " is not a valid directory! Enter new directory to count (blank = list of directories) or Ctrl+C to exit: " 
        $item = $Host.UI.ReadLine()
        ""

        if ($item) { Test-Item $item }
        else { $global:Path = $null }
    }
}