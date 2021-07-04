Write-Host " ______ _ _         _____                  _            
|  ____(_) |       / ____|                | |           
| |__   _| | ___  | |     ___  _   _ _ __ | |_ ___ _ __ 
|  __| | | |/ _ \ | |    / _ \| | | | '_ \| __/ _ \ '__|
| |    | | |  __/ | |___| (_) | |_| | | | | ||  __/ |   
|_|    |_|_|\___|  \_____\___/ \__,_|_| |_|\__\___|_| " -ForegroundColor Yellow

""
Read-Host -Prompt "Press enter for a list of directories"

while (!$Exit) {
    $drives = Get-PSDrive -PSProvider FileSystem | Select-Object -ExpandProperty Root
    ForEach ($i in $drives) {
        Write-Host $i
        Write-Host "--------------------"
        Get-ChildItem $i -Directory | Select-Object Name | ForEach-Object { $_.Name } | Out-Host
        ""
    }

    $global:Path = Read-Host -Prompt "Enter directory to count (i.e. `"SomeDrive:\SomeFolder`")"
    if (!$global:Path) { $global:Path = Get-Location }

    while ($global:Path) {
        Test-Item $global:Path

        $global:Stopwatch.Restart()

        $counts = Get-Childitem $global:Path -Recurse -file | Group-Object Extension -NoElement | Sort-Object Count -desc

        $global:Stopwatch.Stop()

        $result = ""
        if(!$counts) {
            ""
            Write-Host -NoNewline "No files found! " -ForegroundColor Red
            $result = "Enter new directory to count (leave blank for list) or Ctrl+C to exit"
        }
        else {
            $counts | Out-Host
            Write-Host -NoNewLine "Count completed in "
            Write-Host -NoNewline "$($global:Stopwatch.Elapsed.ToString())" -ForegroundColor Yellow
            $result = ". Enter new directory to count (leave blank for list) or Ctrl+C to exit"
        }

        $global:Path = Read-Host -Prompt $result
        ""
    }
}