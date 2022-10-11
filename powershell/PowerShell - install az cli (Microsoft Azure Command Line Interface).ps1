<# Install Az CLI #> PowerShell -Command "If (gcm pwsh -EA:0) { sv PS ((gcm pwsh).Source); } Else { sv PS ((gcm powershell).Source); }; Start-Process -Filepath ((gv PS).Value) -ArgumentList ('-Command Write-Host (write Downloading/Installing` Az` CLI...); Set-Location ((GCI env:\TEMP).Value); sv ProgressPreference SilentlyContinue; Invoke-WebRequest -UseBasicParsing -Uri (write https://aka.ms/installazurecliwindows) -OutFile (write .\AzureCLI.msi); Start-Process ((gcm msiexec).Source) -ArgumentList (write /I` AzureCLI.msi` /quiet) -Wait;') -Verb RunAs -Wait -PassThru | Out-Null; If (gcm az -EA:0) { az config set extension.use_dynamic_install=yes_without_prompt; } Else { Write-Host (write Close` and` reopen` terminal` to` use` az` command` -` Fresh` Az` installs` require` a` Windows` restart` to` update` Az` onto` the` PATH` environment` variable); }";