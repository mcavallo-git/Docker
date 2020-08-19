# ------------------------------------------------------------
#
# UNINSTALL THE FOLLOWING PROGRAM(S) (Win7 style exes) by opening "appwiz.cpl" ("Programs and Features") and right-clicking -> selecting "Uninstall" on each (wait til all are uninstalled to restart)
#

#  > FIND IN "appwiz.cpl", THEN UNINSTALL:

AI Suite 3
All MB
AMD Software
AMD_Chipset_Drivers
ARMOURY CRATE Lite Service
ASUS Framework Service
AURA
AURA lighting effect add-on
AURA lighting effect add-on x64
AURA Service
ROG Live Service


# ------------------------------------------------------------
#
# UNINSTALL THE FOLLOWING APPLICATION(S) (Win10 style apps) by [ typing their name into the start menu, then right-clicking them and selecting "Uninstall" ]. Alternatively, uninstall them by [ opening "Apps & features" then left-clicking the app and selecing "Uninstall" ]:
#

#  > FIND VIA START-MENU, THEN UNINSTALL:

ARMOURY CRATE
AURA Creator


# ------------------------------------------------------------
#
# REMOVE EXISTENT LEFTOVER SERVICES
#

If ($True) {
	
	<# FIND/REMOVE SERVICES #>
	Get-Service -ErrorAction "SilentlyContinue" `
	| Where-Object { `
		(($_.Name -Like "ASUS*") -Or ($_.DisplayName -Like "ASUS*")) `
		-Or (($_.Name -Like "ROG Live*") -Or ($_.DisplayName -Like "ROG Live*")) `
		-Or (($_.Name -Like "ARMOURY CRATE*") -Or ($_.DisplayName -Like "ARMOURY CRATE*")) `
	} | ForEach-Object {
		$_ | Stop-Service;
		Start-Sleep -Milliseconds (250);
		Write-Host "`nInfo: Deleting Service `"$($_.Name)`"...  " -ForegroundColor "Yellow";
		Start-Process -Filepath ("C:\Windows\system32\sc.exe") -ArgumentList (@("delete","$($_.Name)")) -Verb ("RunAs") -ErrorAction ("SilentlyContinue");
		Start-Sleep -Milliseconds (250);
	};

}


# ------------------------------------------------------------
#
# REMOVE EXISTENT LEFTOVER FILES & DIRECTORIES 

If ($True) {

	<# SYSTEM-32 #>
	$Parent_Directory = "C:\Windows\System32";
	$Filenames_To_Remove = @();
	$Filenames_To_Remove += ("AsusDownloadAgent.exe");
	$Filenames_To_Remove += ("AsusDownLoadLicense.exe");
	$Filenames_To_Remove += ("AsusUpdateCheck.exe");
	Get-ChildItem -Path ("${Parent_Directory}") -File -Recurse -Depth (1) -Force -ErrorAction "SilentlyContinue" `
	| Where-Object { (${Filenames_To_Remove}) -Contains ("$($_.Name)"); } `
	| ForEach-Object {
		$Each_Fullpath = ("$($_.FullName)");
		Write-Host "Removing file with path  `"${Each_Fullpath}`" ...";
		Remove-Item -Path ("${Each_Fullpath}") -Force;
	};

	<# PROG-FILES X86 #>
	$Parent_Directory = "C:\Program Files (x86)";
	$Filenames_To_Remove = @();
	$Filenames_To_Remove += ("ASUS");
	Get-ChildItem -Path ("${Parent_Directory}") -Directory -Force -ErrorAction "SilentlyContinue" `
	| Where-Object { (${Filenames_To_Remove}) -Contains ("$($_.Name)"); } `
	| ForEach-Object {
		$Each_Fullpath = ("$($_.FullName)");
		Write-Host "Removing directory with path  `"${Each_Fullpath}`" ...";
		Get-ChildItem -Path ("${Each_Fullpath}") -File -Recurse -Force -ErrorAction "SilentlyContinue" | Remove-Item -Force;
		<# Remove-Item -Path ("${Each_Fullpath}") -Recurse -Force; #>
	};

}



# ------------------------------------------------------------
#
# Citation(s)
#
#   docs.microsoft.com  |  "Get-ChildItem - Gets the items and child items in one or more specified locations"  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/get-childitem?view=powershell-5.1
#
#   docs.microsoft.com  |  "Remove-Item - Deletes the specified items"  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/remove-item?view=powershell-5.1
#
# ------------------------------------------------------------