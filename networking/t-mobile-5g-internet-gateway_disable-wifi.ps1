# ----------------------------------------------------------
# T-Mobile 5G Internet Gateway (Sagemcom Fast 5688W) - Disable Wi-Fi Antennas & Signal Broadcasting
# ----------------------------------------------------------

If ($True) {
  # Get the modem's administrator password from the user
  Write-Host "";
  $ModemPassword = (Read-Host -AsSecureString -Prompt "Enter Modem Administrator Password" | ConvertFrom-SecureString -AsPlainText);
  # Acquire a session token from the modem
  Write-Host "";
  Write-Host "[$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss.ffffff')]  Info:  Acquiring authentication token from the modem...";
  $ModemToken = (curl.exe -X POST http://192.168.12.1/TMI/v1/auth/login -d "{`"username`":`"admin`",`"password`":`"${ModemPassword}`"}" | ConvertFrom-Json | Select-Object -ExpandProperty auth | Select-Object -ExpandProperty token);
  # Download the current Wi-Fi config from the modem
  Write-Host "";
  Write-Host "[$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss.ffffff')]  Info:  Downloading the current Wi-Fi config from the modem...";
  $JsonConfig = (curl.exe "http://192.168.12.1/TMI/v1/network/configuration?get=ap" -H "Authorization: Bearer ${ModemToken}");
  # Modify the downloaded config
  $JsonConfigObj = (${JsonConfig} | ConvertFrom-Json);
  @("2.4ghz","5.0ghz") | ForEach-Object {
    $Each_Bandwidth = (${_});
    # Disable Wi-Fi antennas
    @("isMUMIMOEnabled","isRadioEnabled","isWMMEnabled") | ForEach-Object {
      ${JsonConfigObj}.("${Each_Bandwidth}").("${_}") = $False;
    }
    # Disable Wi-Fi signal broadcasting    
    @("ssid","ssidGuest") | ForEach-Object {
      ${JsonConfigObj}.("${Each_Bandwidth}").("${_}").("isBroadcastEnabled") = $False;
    }
  }
  # Upload the modified config back to the modem
  Write-Host "";
  Write-Host "[$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss.ffffff')]  Info:  Please wait - Uploading config to the modem...";
  $JsonConfigObj | ConvertTo-Json -Compress | curl.exe -d "@-" "http://192.168.12.1/TMI/v1/network/configuration?set=ap" -H "Authorization: Bearer ${ModemToken}";
}


# ------------------------------------------------------------
#
# Citation(s)
#
#   pastebin.com  |  "NaterTater T-Mobile Arcadyan KVD21 Settings - Pastebin.com"  |  https://pastebin.com/N4W3asVL
#
#   www.youtube.com  |  "✅ HACKED - Hidden Settings - Arcadyan KVD21 T-Mobile 5G Home Internet - Turn Off Wifi - YouTube"  |  https://www.youtube.com/watch?v=_hqN7PMRyes
#
# ------------------------------------------------------------