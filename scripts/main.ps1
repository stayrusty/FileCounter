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
        Write-Host $("-" * 20)
        Get-ChildItem $i -Directory | Select-Object Name | ForEach-Object { $_.Name } | Out-Host
        ""
    }

    $global:Path = Read-Host -Prompt "Enter directory to count (i.e. `"SomeDrive:\SomeFolder`")"
    ""
    if (!$global:Path) { $global:Path = Get-Location }

    while ($global:Path) {
        Test-MyPath $global:Path
        if (!$global:Path) { break }

        $global:Stopwatch.Restart()

        $totalcount = 0
        $totalsize = 0
        $counts = Get-Childitem $global:Path -Recurse -File | Group-Object Extension | ForEach-Object {
            $size = ($_.Group | Measure-Object Length -Sum).Sum
            New-Object PsObject -Property @{ 
                Count        = $_.Count
                Extension    = $_.Name
                Size         = $size
                "Total Size" = Get-FileSizeString $size
            }
            $totalcount += $_.Count
            $totalsize += $size
        } | Sort-Object Size -Descending | Format-Table -Property Extension, Count, "Total Size"

        $global:Stopwatch.Stop()

        $result = ""
        if (!$counts) {
            Write-Host -NoNewline "No files found! " -ForegroundColor Red
            $result = "Enter new directory to count (blank = list of directories) or Ctrl+C to exit: "
        }
        else {
            $linepart = "Totals for "
            Write-Host -NoNewLine $linepart
            Write-Host $global:Path -ForegroundColor Green
            Write-Host $("-" * ($linepart.Length + $global:Path.Length))
            ""
            Write-Host "Files: " $totalcount
            Write-Host "Size:  " $(Get-FileSizeString $totalsize)
            ""
            $counts | Out-Host
            Write-Host -NoNewLine "Count completed in "
            Write-Host -NoNewline "$($global:Stopwatch.Elapsed.ToString())" -ForegroundColor Yellow
            $result = ". Enter new directory to count (blank = list of directories) or Ctrl+C to exit: "
        }

        Write-Host -NoNewLine $result
        $global:Path = $Host.UI.ReadLine()
        ""
    }
}