# ------------------------------------------------------------
#
# PowerShell - Get-WmiObject Win32_PnPSignedDriver (view all installed drivers and their associated versions)
#


Get-WmiObject Win32_PnPSignedDriver | ForEach-Object { If ([String]::IsNullOrEmpty(${_}.DeviceName) -Eq $True) { ${_}.DeviceName="DeviceID=[$(${_}.DeviceID)]"; }; ${_}; } | Select-Object -Property @("DeviceName","DriverVersion") | Sort-Object -Property "DeviceName";


# ------------------------------------------------------------
#
# Citation(s)
#
#   docs.microsoft.com  |  "Get-WmiObject"  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/get-wmiobject
#
#   docs.microsoft.com  |  "Win32\_PnPSignedDriver class | Microsoft Docs"  |  https://docs.microsoft.com/en-us/previous-versions/windows/desktop/whqlprov/win32-pnpsigneddriver
#
#   itprotoday.com  |  "Check Installed Driver Versions Using PowerShell"  |  https://www.itprotoday.com/powershell/check-installed-driver-versions-using-powershell
#
# ------------------------------------------------------------