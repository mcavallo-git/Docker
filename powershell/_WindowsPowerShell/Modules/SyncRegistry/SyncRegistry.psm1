function SyncRegistry {
	Param(
	)

	If ((RunningAsAdministrator) -Ne ($True)) {

		PrivilegeEscalation -Command ("SyncRegistry");
	
	} Else {

		# ------------------------------------------------------------
		# TO-DO
		#
		#   Power Settings  -->  Monitor Off after 30-min
		#   Power Settings  -->  Never Sleep
		#   Screen Saver  -->  Activate  [ Blank-Screensaver ("None" option) ]  after  [ 20-min ]
		#
		#

		# ------------------------------------------------------------
		# Define any Network Maps which will be required during the runtime
		#  (Registry Root-Keys are actually Network Maps to the "Registry" PSProvider)

		$PSDrives = @();

		$PSDrives += @{
			Name="HKLM";
			PSProvider="Registry";
			Root="HKEY_LOCAL_MACHINE";
		};

		$PSDrives += @{
			Name="HKCC";
			PSProvider="Registry";
			Root="HKEY_CURRENT_CONFIG";
		};

		$PSDrives += @{
			Name="HKCR";
			PSProvider="Registry";
			Root="HKEY_CLASSES_ROOT";
		};

		$PSDrives += @{
			Name="HKU";
			PSProvider="Registry";
			Root="HKEY_USERS";
		};

		$PSDrives += @{
			Name="HKCU";
			PSProvider="Registry";
			Root="HKEY_CURRENT_USER";
		};

		$PSDrives += @{
			Name=$Null;
			PSProvider="Registry";
			Root="HKEY_PERFORMANCE_DATA";
		};

		$PSDrives += @{
			Name=$Null;
			PSProvider="Registry";
			Root="HKEY_DYN_DATA";
		};


		# ------------------------------------------------------------

		$RegEdits = @();


		# Cortana/Search Settings
		$RegEdits += @{
			Path="HKCU:\Software\Microsoft\Windows\CurrentVersion\Search";
			Props=@(
				@{
					Description="Cortana/Search Settings - Set to [ 1 ] to Enable or [ 0 ] to Disable Cortana's ability to send search-resutls to Bing.com.";
					Hotfix="Enabling fixes a bug where Cortana eats 30-40% CPU resources (KB4512941).";
					Name="BingSearchEnabled";
					Type="DWord";
					Value=1;
					Delete=$False;
				},
				@{
					Description=$Null;
					Name="AllowSearchToUseLocation";
					Type="DWord";
					Value=0;
					Delete=$False;
				}
			)
		};


		# Cortana/Search Settings (cont.)
		$RegEdits += @{
			Path="HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search";
			Props=@(
				@{
					Description="Cortana/Search Settings - TODO";
					Name="AllowCortana";
					Type="DWord";
					Value=0;
					Delete=$False;
				},
				@{
					Description="Cortana/Search Settings - TODO";
					Name="ConnectedSearchUseWeb";
					Type="DWord";
					Value=0;
					Delete=$False;
				},
				@{
					Description="Cortana/Search Settings - TODO";
					Name="ConnectedSearchUseWebOverMeteredConnections";
					Type="DWord";
					Value=0;
					Delete=$False;
				},
				@{
					Description="Cortana/Search Settings - TODO";
					Name="DisableWebSearch";
					Type="DWord";
					Value=1;
					Delete=$False;
				}
			)
		};


		# Explorer Settings (cont.)
		$RegEdits += @{
			Path = "HKCU:\Software\Policies\Microsoft\Windows\Explorer";
			Props=@(
				@{
					Description="Explorer Settings - Set to [ 1 ] to Disable or [ 0 ] to Enable `"Aero Shake`" in Windows 10";
					Name="NoWindowMinimizingShortcuts"; 
					Type="DWord";
					Value=1;
					Delete=$False;
				}
			)
		};


		# Explorer Settings (cont.)
		$RegEdits += @{
			Path = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced";
			Props=@(
				@{
					Description="Explorer Settings - Setting to [ 0 ] selects `"Show hidden files, folders, and drives`", setting to [ 1 ] selects `"Don't show hidden files, folders, or drives`"";
					Name="Hidden"; 
					Type="DWord";
					Value=0;
					Delete=$False;
				},
				@{
					Description="Explorer Settings - Check [ 1 ] or Uncheck [ 0 ] option `"Hide empty drives`"";
					Name="HideDrivesWithNoMedia"; 
					Type="DWord";
					Value=0;
					Delete=$False;
				},
				@{
					Description="Explorer Settings - Check [ 1 ] or Uncheck [ 0 ] option `"Hide extensions for known file types`"";
					Name="HideFileExt"; 
					Type="DWord";
					Value=0;
					Delete=$False;
				},
				@{
					Description="Explorer Settings - Check [ 1 ] or Uncheck [ 0 ] option `"Hide folder merge conflicts`"";
					Name="HideMergeConflicts"; 
					Type="DWord";
					Value=0;
					Delete=$False;
				}
			)
		};


		# Explorer Settings (cont.)
		$DefaultPictureEditor="C:\Program Files\paint.net\PaintDotNet.exe";
		If ((Test-Path -Path "${DefaultPictureEditor}") -Eq $True) {
			# Set default application to use when user clicks "Edit" after right-clicking an image-file in Explorer
			#   |--> Explorer -> Image-File (.png, .jpg, ...) -> Right-Click -> Edit -> Opens app held in [v THIS v] RegEdit Key/Val
			$RegEdits += @{
				Path = "HKCR:\SystemFileAssociations\image\shell\edit\command";
				Props=@(
					@{
						Description="Explorer Settings - Defines the application opened when a user right-clicks an Image file (in Windows Explorer) and selects the `"Edit`" command.";
						Name="(Default)"; 
						Type="REG_EXPAND_SZ";
						Val_Default="`"%systemroot%\system32\mspaint.exe`" `"%1`"";
						Value=(("`"")+(${DefaultPictureEditor})+("`" `"%1`""));
						Delete=$False;
					}
				)
			};
		}


		# Lock Workstation (Enable/Disable locking the workstation, which includes disabling the "WinKey + L" lock-workstation action)
		$RegEdits += @{
			Path="HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\System";
			Props=@(
				@{
					Description="Set this value to [ 1 ] to disable `"Lock Workstation`" in Windows (hotkey: WinKey + L )";
					Name="DisableLockWorkstation";
					Type="DWord";
					Value=0;
					Delete=$False;
				}
			)
		};


		# Notification Area Icons (always show)
		$RegEdits += @{
			Path="Registry::HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer";
			Props=@(
				@{
					Description="System Tray - Set this value to [ 0 ] to show all icons, [ 1 ] to hide inactive icons (note: the default for this is set under HKLM)";
					Hotfix=$Null;
					Name="EnableAutoTray";
					Type="DWord";
					Value=0;
					Delete=$False;
				}
			)
		};


		# Office 2013 Settings
		$RegEdits += @{
			Path="HKCU:\Software\Microsoft\Office\15.0\Common\General";
			Props=@(
				@{
					Description="Office 2013 Settings - Set to [ 2147483648 ] to Disable Microsoft Office Clipboard (Excel-Only?)";
					Hotfix=$Null;
					Name="AcbControl";
					Type="DWord";
					Value=2147483648;
					Delete=$False;
				}
			)
		};


		# Office 2016 Settings
		$RegEdits += @{
			Path="HKCU:\Software\Microsoft\Office\16.0\Common\General";
			Props=@(
				@{
					Description="Office 2016 Settings - Set to [ 2147483648 ] to Disable Microsoft Office Clipboard (Excel-Only?)";
					Hotfix=$Null;
					Name="AcbControl";
					Type="DWord";
					Value=2147483648;
					Delete=$False;
				}
			)
		};


		# Power Settings
		$RegEdits += @{
			Path="HKLM:\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\238C9FA8-0AAD-41ED-83F4-97BE242C8F20\7bc4a2f9-d8fc-4469-b07b-33eb785aaca0";
			Props=@(
				@{
					Description="Power Settings - Set to [2] to enable 'advanced power settings', [1] to disable 'advanced power settings'.";
					Hotfix=$Null;
					Name="Attributes";
					Type="DWord";
					Value=2;
					Delete=$False;
				}
			)
		};


		# Shutdown/Restart Settings
		$RegEdits += @{
			Path = "HKCU:\Control Panel\Desktop";
			Props=@(
				@{
					Description="Set to [ 1 ] to Disable or [ 0 ] to Enable the 'This App is Preventing Shutdown or Restart' screen, which appears while attempting Shutdown/Restart the machine while certain inspecific applications are running - Remove this key/val to show this screen, instead";
					Name="AutoEndTasks"; 
					Type="String";
					Value=1;
					Delete=$False;
				}
			)
		};


		# SmartScreen for Microsoft Edge, Microsoft Store Apps
		$RegEdits += @{
			Path="HKLM:\SOFTWARE\Policies\Microsoft\Windows\System";
			Props=@(
				@{
					Description="Set this value to [ 0 ] to turn off SmartScreen, [ 1 ] to give user a warning before running downloaded unknown software, [ 2 ] to require approval from an administrator before running downloaded unknown software ( from https://docs.microsoft.com/en-us/microsoft-edge/deploy/available-policies#configure-windows-defender-smartscreen )";
					Name="EnableSmartScreen";
					Type="DWord";
					Value=0;
					Delete=$False;
				}
			)
		};
		$RegEdits += @{
			Path="HKLM:\SOFTWARE\Policies\Microsoft\MicrosoftEdge\PhishingFilter";
			Props=@(
				@{
					Description="Set this value to [ 0 ] to allow users to bypass (ignore) the Windows Defender SmartScreen warnings about potentially malicious files, [ 1 ] to prevent users from bypassing the warnings, blocking them from downloading of the unverified file(s) (from https://docs.microsoft.com/en-us/microsoft-edge/deploy/available-policies#prevent-bypassing-windows-defender-smartscreen-prompts-for-files )";
					Name="PreventOverrideAppRepUnknown";
					Type="DWord";
					Value=0;
					Delete=$False;
				}
			)
		};
		$RegEdits += @{
			Path="HKLM:\SOFTWARE\Policies\Microsoft\MicrosoftEdge\PhishingFilter";
			Props=@(
				@{
					Description="By default, Microsoft Edge allows users to bypass (ignore) the Windows Defender SmartScreen warnings about potentially malicious sites, allowing them to continue to the site. With this policy though, you can configure Microsoft Edge to prevent users from bypassing the warnings, blocking them from continuing to the site (from https://docs.microsoft.com/en-us/microsoft-edge/deploy/available-policies#prevent-bypassing-windows-defender-smartscreen-prompts-for-sites )";
					Name="PreventOverride";
					Type="DWord";
					Value=0;
					Delete=$False;
				}
			)
		};


		# Windows Update - Force-pull from Windows instaed of local server
		$RegEdits += @{
			Path="HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU";
			Props=@(
				@{
					Description="Set this value to [ 1 ] to configure Automatic Updates to use a server that is running Software Update Services instead of Windows Update ( from https://docs.microsoft.com/en-us/windows/deployment/update/waas-wu-settings )";
					Name="UseWUServer";
					Type="DWord";
					Value=0;
					Delete=$False;
				}
			)
		};
		$RegEdits += @{
			Path="HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\Servicing";
			Props=@(
				@{
					Description="Sets the value (string) for the option named [ Alternate source file path ] under Group-Policy [ 'Computer Configuration' -> 'Administrative Templates' -> 'System' -> 'Specify settings for optional component installation and component repair setting.'";
					Name="LocalSourcePath";
					Type="ExpandString";
					Value="";
					Delete=$False;
				},
				@{
					Description="Sets the value (checkbox, check=2, unchecked=delete-the-key) for the option named [ Download repair content and optional features directly from Windows Update isntead of Windows Server Update Services (WSUS) ] under Group-Policy [ 'Computer Configuration' -> 'Administrative Templates' -> 'System' -> 'Specify settings for optional component installation and component repair setting.'";
					Name="RepairContentServerSource";
					Type="DWord";
					Value=2;
					Delete=$False;
				},
				@{
					Description="Sets the value (checkbox, check=2, unchecked=delete-the-key) for the option named [ Never attempt to download payload from Windows Update ] under Group-Policy [ 'Computer Configuration' -> 'Administrative Templates' -> 'System' -> 'Specify settings for optional component installation and component repair setting.'";
					Name="UseWindowsUpdate";
					Type="DWord";
					Value=2;
					Delete=$True;
				}
			)
		};


		# ------------------------------------------------------------
		# Environment-specific registry settings
		#
		If ( $False ) {

			# VMware vSphere Client Cached-Connections
			$RegEdits += @{
				Path = "HKCU:\Software\VMware\VMware Infrastructure Client\Preferences";
				Props=@(
					@{
						Description="Defines the vSphere Client's [ IP address/ Name ] cached connection-urls";
						Name="RecentConnections"; 
						Type="String";
						Value="";
						Delete=$False;
					}
				)
			};

			# VMware vSphere Client Cached-Connections
			$RegEdits += @{
				Path = "HKCU:\Software\Policies\Microsoft\CloudFiles\BlockedApps\*";
				Props=@(
					@{
						Description="Blocks (1) or Unblocks (0) Apps from being able to trigger the OneDrive's `"Files On-Demand`" feature";
						Name="Enabled"; 
						Type="DWord";
						Value=1;
						Delete=$False;
					}
				)
			};

		}

		# ------------------------------------------------------------
		
		If (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]"Administrator")) {
			#
			# Current session does not have Admin-Rights (required)
			#   |--> Re-run this script as admin (if current user is not an admin, request admin credentials)
			#
			Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`" $PSCommandArgs" -Verb RunAs;
			Exit;

		} Else {
			#
			# 		New-Item --> Can be used to create new registry keys (assuming the current powershell session is running with elevated privileges)
			#
			#			Set-ItemProperty --> Can be used to create new registry values (DWord 32-bit, etc.)
			#

			Foreach ($EachRegEdit In $RegEdits) {
				#
				# Root-Keys
				#   |--> Ensure that this registry key's Root-Key has been mapped as a network drive
				#   |--> Mapping this as a network drive grants this script read & write access to said Root-Key's registry values (which would otherwise be inaccessible)
				#
				$Each_RegEdit_DriveName=(($EachRegEdit.Path).Split(':\')[0]);
				If ((Test-Path -Path (("")+(${Each_RegEdit_DriveName})+(":\"))) -Eq $False) {
					$Each_PSDrive_PSProvider=$Null;
					$Each_PSDrive_Root=$Null;
					Write-Host "`n`n  Info: Root-Key `"${Each_RegEdit_DriveName}`" not found" -ForegroundColor Yellow;
					Foreach ($Each_PSDrive In $PSDrives) {
						If ((($Each_PSDrive.Name) -Ne $Null) -And (($Each_PSDrive.Name) -eq $Each_RegEdit_DriveName)) {
							$Each_PSDrive_PSProvider=($Each_PSDrive.PSProvider);
							$Each_PSDrive_Root=($Each_PSDrive.Root);
							Break;
						}
					}
					If ($Each_PSDrive_Root -Ne $Null) {
						Write-Host "   |`n   |--> Adding Session-Based ${Each_PSDrive_PSProvider} Network-Map from drive name `"${Each_RegEdit_DriveName}`" to data store location `"${Each_PSDrive_Root}`"" -ForegroundColor "Yellow";
						New-PSDrive -Name "${Each_RegEdit_DriveName}" -PSProvider "${Each_PSDrive_PSProvider}" -Root "${Each_PSDrive_Root}" | Out-Null;
					}
				}
				
				If ((Test-Path -Path ($EachRegEdit.Path)) -eq $True) {
					# Skip creating registry key if it already exists
					Write-Host (("`n`n  Found Key `"")+($EachRegEdit.Path)+("`"")) -ForegroundColor DarkGray; # (Already up to date)
				} Else {
					# Create missing key in the registry
					Write-Host (("`n`n  Creating Key `"")+($EachRegEdit.Path)+("`" ")) -ForegroundColor Green;
					New-Item -Path ($EachRegEdit.Path) -Force; # Note: The -Force is used to create any/all missing parent registry keys
				}

				Foreach ($EachProp In $EachRegEdit.Props) {

					# Check for each key-property
					# Write-Host (("`n`n  Checking for `"")+($EachRegEdit.Path)+("`" --> `"$($EachProp.Name)`"...`n`n"));
					$Revertable_ErrorActionPreference = $ErrorActionPreference; $ErrorActionPreference = 'SilentlyContinue';
					$GetEachItemProp = Get-ItemProperty -Path ($EachRegEdit.Path) -Name ($EachProp.Name);
					$last_exit_code = If($?){0}Else{1};
					$ErrorActionPreference = $Revertable_ErrorActionPreference;
					$EchoDetails = "";
					If ((${EachProp}.Description) -Ne $Null) { $EchoDetails += "`n         v`n        Description: $(${EachProp}.Description)"; }
					If ((${EachProp}.Hotfix) -Ne $Null) { $EchoDetails += "`n         v`n        Hotfix: $(${EachProp}.Hotfix)"; }

					If ($last_exit_code -eq 0) { # Registry-Key-Property exists

						If (($EachProp.Delete) -eq $False) { # Property should NOT be deleted

							$EachProp.LastValue = $GetEachItemProp.($EachProp.Name);
								
							If (($EachProp.LastValue) -eq ($EachProp.Value)) { # Property set as-intended (Already up to date)
								Write-Host "   |`n   |--> Found Property with Name [ $($EachProp.Name) ] & Type [ $($EachProp.Type) ] with correct Value of [ $($EachProp.Value) ] ${EchoDetails}" -ForegroundColor "DarkGray";

							} Else {
								# Modify the value of an existing property on an existing registry key
								Write-Host "   |`n   |--> Updating Property with Name [ $($EachProp.Name) ] & Type [ $($EachProp.Type) ] from Value [ $($EachProp.LastValue) ] to Value [ $($EachProp.Value) ] ${EchoDetails}" -ForegroundColor "Yellow";
								Set-ItemProperty -Path ($EachRegEdit.Path) -Name ($EachProp.Name) -Value ($EachProp.Value);

							}

						} Else { # Property SHOULD be deleted
							
							# Existing key-property found which should be deleted
							Write-Host "   |`n   |--> Deleting Property with Name [ $($EachProp.Name) ] & Type [ $($EachProp.Type) ] with Value of [ $($EachProp.Value) ] ${EchoDetails}" -ForegroundColor "Magenta";
							Remove-ItemProperty -Path ($EachRegEdit.Path) -Name ($EachProp.Name) -Value ($EachProp.Value);

						}


					} Else { # Registry-Key-Property does NOT exist

						If (($EachProp.Delete) -eq $False) { # Property should NOT be deleted

							# Add the missing property to the Registry Key
							Write-Host "   |`n   |--> Adding Property with Name [ $($EachProp.Name) ] & Type [ $($EachProp.Type) ] with Value [ $($EachProp.Value) ] ${EchoDetails}" -ForegroundColor "Yellow";
							New-ItemProperty -Path ($EachRegEdit.Path) -Name ($EachProp.Name) -PropertyType ($EachProp.Type) -Value ($EachProp.Value) -Force;
							Write-Host " `n`n";

						} Else { # Property SHOULD be deleted (Already up to date)
							Write-Host "   |`n   |--> Skipping Deletion of Property with Name [ $($EachProp.Name) ] & Type [ $($EachProp.Type) ] (already deleted/doesn't-exist) ${EchoDetails}" -ForegroundColor "DarkGray";


						}

					}

				}

			}

		}
	}

	Write-Host -NoNewLine "`n`n  Press any key to exit..." -BackgroundColor Black -ForegroundColor Magenta;
	$KeyPress = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');

}
Export-ModuleMember -Function "SyncRegistry";
# Install-Module -Name "SyncRegistry"


# ------------------------------------------------------------
#
# Note: Registry Value Data-Types
#
#    REG_SZ         |  A null-terminated string
#    REG_BINARY     |  Binary data
#    REG_DWORD      |  A 32-bit number
#    REG_QWORD      |  A 64-bit number
#    REG_MULTI_SZ   |  A sequence of null-terminated strings, terminated by a null value
#    REG_EXPAND_SZ  |  A null-terminated string that contains unexpanded references to environment variables (like %PATH%)
#
#
# ------------------------------------------------------------
#
# Citation(s)
#
#   answers.microsoft.com  |  "Automatic files - Automatic file downloads"  |  https://answers.microsoft.com/en-us/windows/forum/all/automatic-files/91b91138-0096-4fbc-a3e2-5de5176a6ca5
#
#   autohotkey.com  |  "Windows key (#) + letter keeps locking the pc (even if it is not #L)"  |  https://www.autohotkey.com/boards/viewtopic.php?p=46949&sid=490d0a443a7f78557b54c2bfb079350f#p46949
#
#   docs.microsoft.com  |  "Configure Windows Defender SmartScreen"  |  https://docs.microsoft.com/en-us/microsoft-edge/deploy/available-policies#configure-windows-defender-smartscreen
#
#   docs.microsoft.com  |  "Set-ItemProperty - Creates or changes the value of a property of an item"  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/set-itemproperty
#
#   docs.microsoft.com  |  "Get-PSProvider - Gets information about the specified PowerShell provider"  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/get-psprovider
#
#   docs.microsoft.com  |  "New-PSDrive - Creates temporary and persistent mapped network drives"  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/new-psdrive
#
#   getadmx.com  |  "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\System"  |  https://getadmx.com/HKCU/Software/Microsoft/Windows/CurrentVersion/Policies/System
#
#   microsoft.com  |  "Group Policy Settings Reference for Windows and Windows Server"  |  https://www.microsoft.com/en-us/download/confirmation.aspx?id=25250
#
#   social.msdn.microsoft.com  |  ".NET Framework 3.5 doesn't install. Windows 10.. Error code: 0x800F081F"  |  https://social.msdn.microsoft.com/Forums/en-US/4ea808e7-c503-4f99-9480-aa8e6938be3d
#
#   ss64.com  |  "Windows 10 registry - How-To: Windows 10 registry - user interface settings - Windows CMD - SS64.com"  |  https://ss64.com/nt/syntax-reghacks.html
#
#   stackoverflow.com  |  "New-Item recursive registry keys"  |  https://stackoverflow.com/a/21770519
#
#   stackoverflow.com  |  "Retrieve (Default) Value in Registry key"  |  https://stackoverflow.com/a/31711000
#
#   stackoverflow.com  |  "The IDynamicPropertyCmdletProvider interface is not implemented by this provider"  |  https://stackoverflow.com/a/54237993
#
#   windows.tips.net  |  "Understanding Registry Value Data Types"  |  https://windows.tips.net/T013035_Understanding_Registry_Value_Data_Types.html
#
#   winhelponline.com  |  "Change the Default Image Editor Linked to Edit command in Right-click Menu for Image Files"  |  https://www.winhelponline.com/blog/change-default-image-editor-edit-command-right-click-image/
#
# ------------------------------------------------------------