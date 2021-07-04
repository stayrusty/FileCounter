Function Test-Item ($item) {
    if (Test-Path -Path $item) { 
        ""
        Write-Host -NoNewLine $item -ForegroundColor Green
        Write-Host -NoNewLine " found! Now counting files..."
        $global:Path = $item 
    }
    else {   
        ""
        Write-Host -NoNewLine $item -ForegroundColor Red
        Write-Host -NoNewLine " is not a valid directory! Enter new directory to count (leave blank for list) or Ctrl+C to exit: " -ForegroundColor White 
        $item = $Host.UI.ReadLine()
        Test-Item $item
    }
}