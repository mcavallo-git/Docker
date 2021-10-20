# ------------------------------------------------------------
#
# PowerShell - Start-Process ... -Verb RunAs  (run as admin)
#
# ------------------------------------------------------------


<# PowerShell/pwsh - Run as admin - Open a new terminal #>
If (GCM pwsh -ErrorAction SilentlyContinue) { SV PS ((GCM pwsh).Source); } Else { SV PS ((GCM powershell).Source); }; Start-Process -Filepath ((GV PS).Value) -Verb RunAs;


<# PowerShell - Run as admin - Run an AutoHotkey script #> 
Start-Process -Filepath ("${ENV:ProgramFiles}\AutoHotkey-v2\AutoHotkeyU64.exe") -ArgumentList ("${ENV:USERPROFILE}\Documents\GitHub\Coding\ahk\_WindowsHotkeys.ahkv2") -Verb RunAs;


<# PowerShell/pwsh - Run as admin (child terminal) - Run 'whoami' #>
PowerShell -Command "If (GCM pwsh -ErrorAction SilentlyContinue) { SV PS ((GCM pwsh).Source); } Else { SV PS ((GCM powershell).Source); }; Start-Process -Filepath ((GV PS).Value) -ArgumentList ('-Command Invoke-Expression ((GCM whoami).Source); Start-Sleep -Seconds 60;') -Verb RunAs -Wait -PassThru | Out-Null;";


<# PowerShell/pwsh - Run as admin (child terminal) - Install choco package manager #>
PowerShell -Command "If (GCM pwsh -ErrorAction SilentlyContinue) { SV PS ((GCM pwsh).Source); } Else { SV PS ((GCM powershell).Source); }; Start-Process -Filepath ((GV PS).Value) -ArgumentList ('-Command SV ProgressPreference SilentlyContinue; If ((GCM choco -ErrorAction SilentlyContinue) -Eq ((GV null).Value)) { Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString((Write-Output https://chocolatey.org/install.ps1))); }; Start-Sleep -Seconds 60;') -Verb RunAs -Wait -PassThru | Out-Null;";


<# PowerShell/pwsh - Run as admin (child terminal) - Install Google Chrome #>
PowerShell -Command "If (GCM pwsh -ErrorAction SilentlyContinue) { SV PS ((GCM pwsh).Source); } Else { SV PS ((GCM powershell).Source); }; Start-Process -Filepath ((GV PS).Value) -ArgumentList ('-Command SV LocalTempDir ((GCI env:\TEMP).Value); SV ChromeInstaller (Write-Output ChromeInstaller.exe); SV Process2Monitor ([IO.Path]::GetFileNameWithoutExtension((GV ChromeInstaller).Value)); (New-Object System.Net.WebClient).DownloadFile((Write-Output http://dl.google.com/chrome/install/latest/chrome_installer.exe), (((GV LocalTempDir).Value)+(Write-Output \)+((GV ChromeInstaller).Value)) ); & (((GV LocalTempDir).Value)+(Write-Output \)+((GV ChromeInstaller).Value)) /silent /install; Do { SV ProcessesFound (Get-Process | Where-Object { ((GV Process2Monitor).Value) -contains (((GV _).Value).Name); } | Select-Object -ExpandProperty Name); If ((GV ProcessesFound).Value) { ((Write-Output Still`` running:`` )+(((GV ProcessesFound).Value) -join (Write-Output ``,`` ))) | Write-Host; Start-Sleep -Seconds 2; } Else { Remove-Item -Verbose -Path (((GV LocalTempDir).Value)+(Write-Output \)+((GV ChromeInstaller).Value)) -ErrorAction SilentlyContinue; } } Until (!((GV ProcessesFound).Value)); Start-Sleep -Seconds 60;') -Verb RunAs -Wait -PassThru | Out-Null;";


# ------------------------------------------------------------
#
# Citation(s)
#
#   docs.microsoft.com  |  "Start-Process (Microsoft.PowerShell.Management) - PowerShell | Microsoft Docs"  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/start-process
#
# ------------------------------------------------------------