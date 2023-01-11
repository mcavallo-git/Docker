If ($True) {

  $MANFILE = "${env:REPOS_DIR}/Coding/man/dism.exe.help.man";
  $DASH_NL = "------------------------------------------------------------`n";

  # $DISM_ARGS=@("/Online","/?");  Add-Content -Path ("${MANFILE}") -Value ("DISM ${DISM_ARGS}");  DISM ${DISM_ARGS} | Add-Content -Path ("${MANFILE}");  Add-Content -Path ("${MANFILE}") -Value ("${DASH_NL}");
  # $DISM_ARGS=@("/Online","/Cleanup-Image","/?");  Add-Content -Path ("${MANFILE}") -Value ("DISM ${DISM_ARGS}");  DISM ${DISM_ARGS} | Add-Content -Path ("${MANFILE}");  Add-Content -Path ("${MANFILE}") -Value ("${DASH_NL}");
  # $DISM_ARGS=@("/Online","/Enable-Feature","/?");  Add-Content -Path ("${MANFILE}") -Value ("DISM ${DISM_ARGS}");  DISM ${DISM_ARGS} | Add-Content -Path ("${MANFILE}");  Add-Content -Path ("${MANFILE}") -Value ("${DASH_NL}");
  # $DISM_ARGS=@("/Online","/Get-WimInfo","/?");  Add-Content -Path ("${MANFILE}") -Value ("DISM ${DISM_ARGS}");  DISM ${DISM_ARGS} | Add-Content -Path ("${MANFILE}");  Add-Content -Path ("${MANFILE}") -Value ("${DASH_NL}");

  $COMMANDS_ARRAY = @();
  $COMMANDS_ARRAY += "";
  $COMMANDS_ARRAY += "/Add-Capability";
  $COMMANDS_ARRAY += "/Add-Driver";
  $COMMANDS_ARRAY += "/Add-Package";
  $COMMANDS_ARRAY += "/Add-ProvisionedAppxPackage";
  $COMMANDS_ARRAY += "/Add-ProvisioningPackage";
  $COMMANDS_ARRAY += "/Append-Image";
  $COMMANDS_ARRAY += "/Apply-CustomDataImage";
  $COMMANDS_ARRAY += "/Apply-Ffu";
  $COMMANDS_ARRAY += "/Apply-Image";
  $COMMANDS_ARRAY += "/Apply-Unattend";
  $COMMANDS_ARRAY += "/Capture-CustomImage";
  $COMMANDS_ARRAY += "/Capture-Ffu";
  $COMMANDS_ARRAY += "/Capture-Image";
  $COMMANDS_ARRAY += "/Check-AppPatch";
  $COMMANDS_ARRAY += "/Cleanup-Image";
  $COMMANDS_ARRAY += "/Cleanup-Mountpoints";
  $COMMANDS_ARRAY += "/Cleanup-Wim";
  $COMMANDS_ARRAY += "/Commit-Image";
  $COMMANDS_ARRAY += "/Commit-Wim";
  $COMMANDS_ARRAY += "/Delete-Image";
  $COMMANDS_ARRAY += "/Disable-Feature";
  $COMMANDS_ARRAY += "/Enable-Feature";
  $COMMANDS_ARRAY += "/English";
  $COMMANDS_ARRAY += "/Export-DefaultAppAssociations";
  $COMMANDS_ARRAY += "/Export-Driver";
  $COMMANDS_ARRAY += "/Export-Image";
  $COMMANDS_ARRAY += "/Export-Source";
  $COMMANDS_ARRAY += "/Format";
  $COMMANDS_ARRAY += "/Gen-LangIni";
  $COMMANDS_ARRAY += "/Get-AppInfo";
  $COMMANDS_ARRAY += "/Get-AppPatches";
  $COMMANDS_ARRAY += "/Get-AppPatchInfo";
  $COMMANDS_ARRAY += "/Get-Apps";
  $COMMANDS_ARRAY += "/Get-Capabilities";
  $COMMANDS_ARRAY += "/Get-CapabilityInfo";
  $COMMANDS_ARRAY += "/Get-CurrentEdition";
  $COMMANDS_ARRAY += "/Get-DefaultAppAssociations";
  $COMMANDS_ARRAY += "/Get-DriverInfo";
  $COMMANDS_ARRAY += "/Get-Drivers";
  $COMMANDS_ARRAY += "/Get-FeatureInfo";
  $COMMANDS_ARRAY += "/Get-Features";
  $COMMANDS_ARRAY += "/Get-ImageInfo";
  $COMMANDS_ARRAY += "/Get-Intl";
  $COMMANDS_ARRAY += "/Get-MountedImageInfo";
  $COMMANDS_ARRAY += "/Get-MountedWimInfo";
  $COMMANDS_ARRAY += "/Get-NonRemovableAppPolicy";
  $COMMANDS_ARRAY += "/Get-OSUninstallWindow";
  $COMMANDS_ARRAY += "/Get-PackageInfo";
  $COMMANDS_ARRAY += "/Get-Packages";
  $COMMANDS_ARRAY += "/Get-ProvisionedAppxPackages";
  $COMMANDS_ARRAY += "/Get-ProvisioningPackageInfo";
  $COMMANDS_ARRAY += "/Get-ReservedStorageState";
  $COMMANDS_ARRAY += "/Get-TargetEditions";
  $COMMANDS_ARRAY += "/Get-WIMBootEntry";
  $COMMANDS_ARRAY += "/Get-WimInfo";
  $COMMANDS_ARRAY += "/Image";
  $COMMANDS_ARRAY += "/Import-DefaultAppAssociations";
  $COMMANDS_ARRAY += "/Initiate-OSUninstall";
  $COMMANDS_ARRAY += "/List-Image";
  $COMMANDS_ARRAY += "/LogLevel";
  $COMMANDS_ARRAY += "/LogPath";
  $COMMANDS_ARRAY += "/Mount-Image";
  $COMMANDS_ARRAY += "/Mount-Wim";
  $COMMANDS_ARRAY += "/NoRestart";
  $COMMANDS_ARRAY += "/Online";
  $COMMANDS_ARRAY += "/Optimize-Ffu";
  $COMMANDS_ARRAY += "/Optimize-Image";
  $COMMANDS_ARRAY += "/Optimize-ProvisionedAppxPackages";
  $COMMANDS_ARRAY += "/Quiet";
  $COMMANDS_ARRAY += "/Remount-Image";
  $COMMANDS_ARRAY += "/Remount-Wim";
  $COMMANDS_ARRAY += "/Remove-Capability";
  $COMMANDS_ARRAY += "/Remove-DefaultAppAssociations";
  $COMMANDS_ARRAY += "/Remove-Driver";
  $COMMANDS_ARRAY += "/Remove-OSUninstall";
  $COMMANDS_ARRAY += "/Remove-Package";
  $COMMANDS_ARRAY += "/Remove-ProvisionedAppxPackage";
  $COMMANDS_ARRAY += "/ScratchDir";
  $COMMANDS_ARRAY += "/Set-AllIntl";
  $COMMANDS_ARRAY += "/Set-Edition";
  $COMMANDS_ARRAY += "/Set-InputLocale";
  $COMMANDS_ARRAY += "/Set-LayeredDriver";
  $COMMANDS_ARRAY += "/Set-NonRemovableAppPolicy";
  $COMMANDS_ARRAY += "/Set-OSUninstallWindow";
  $COMMANDS_ARRAY += "/Set-ProductKey";
  $COMMANDS_ARRAY += "/Set-ProvisionedAppxDataFile";
  $COMMANDS_ARRAY += "/Set-ReservedStorageState";
  $COMMANDS_ARRAY += "/Set-SetupUILang";
  $COMMANDS_ARRAY += "/Set-SKUIntlDefaults";
  $COMMANDS_ARRAY += "/Set-SysLocale";
  $COMMANDS_ARRAY += "/Set-SysUILang";
  $COMMANDS_ARRAY += "/Set-TimeZone";
  $COMMANDS_ARRAY += "/Set-UILang";
  $COMMANDS_ARRAY += "/Set-UILangFallback";
  $COMMANDS_ARRAY += "/Set-UserLocale";
  $COMMANDS_ARRAY += "/Split-Ffu";
  $COMMANDS_ARRAY += "/Split-Image";
  $COMMANDS_ARRAY += "/SysDriveDir";
  $COMMANDS_ARRAY += "/Unmount-Image";
  $COMMANDS_ARRAY += "/Unmount-Wim";
  $COMMANDS_ARRAY += "/Update-WIMBootEntry";
  $COMMANDS_ARRAY += "/WinDir";

  Set-Content -Path ("${MANFILE}") -Value ("${DASH_NL}");
  For ($i=0; ($i -LT ${COMMANDS_ARRAY}.Count); $i++) {
    $EACH_COMMAND = (${COMMANDS_ARRAY}[${i}]);
    $EACH_DISM_ARGS = If ("${EACH_COMMAND}" -Eq "") { @("/Online","/?"); } Else { @("/Online","${EACH_COMMAND}","/?"); };
    Add-Content -Path ("${MANFILE}") -Value ("DISM ${EACH_DISM_ARGS}");
    DISM ${EACH_DISM_ARGS} | Add-Content -Path ("${MANFILE}");
    Add-Content -Path ("${MANFILE}") -Value ("${DASH_NL}");
  }

}