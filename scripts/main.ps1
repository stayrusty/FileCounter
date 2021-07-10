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
    ""
    if (!$global:Path) { $global:Path = Get-Location }

    while ($global:Path) {
        Test-Item $global:Path
        if (!$global:Path) { break }

        $global:Stopwatch.Restart()

        $totals = 0
        $counts = Get-Childitem $global:Path -Recurse -File | Group-Object Extension | ForEach-Object {
            $size = ($_.Group | Measure-Object Length -Sum).Sum
            if ($size -gt 1TB) {
                $str_size = [string][math]::Round(($size) / 1TB, 2) + " TB"
            }
            elseif ($size -gt 1GB) {
                $str_size = [string][math]::Round(($size) / 1GB, 2) + " GB"
            }
            elseif ($size -gt 1MB) {
                $str_size = [string][math]::Round(($size) / 1MB, 2) + " MB"
            }
            elseif ($size -gt 1KB) {
                $str_size = [string][math]::Round(($size) / 1KB, 2) + " KB"
            }
            else {
                $str_size = [string][math]::Round(($size), 2) + " B"
            }
            New-Object PsObject -Property @{ 
                Count        = $_.Count
                Extension    = $_.Name
                "Total Size" = $str_size
            }
            $totals += $_.Count
        } | Select-Object Count, Extension, "Total Size" | Sort-Object @{Expression = "Count"; Descending = $true }, Extension | Format-Table -Auto

        $global:Stopwatch.Stop()

        $result = ""
        if (!$counts) {
            Write-Host -NoNewline "No files found! " -ForegroundColor Red
            $result = "Enter new directory to count (blank = list of directories) or Ctrl+C to exit: "
        }
        else {
            Write-Host $totals "files found!"
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