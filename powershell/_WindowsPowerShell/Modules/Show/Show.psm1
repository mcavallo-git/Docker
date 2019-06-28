#
#	PowerShell - Show
#		|
#		|--> Description:  Shows extended variable information to user
#		|
#		|--> Example:     Show -Test1 -Test2 -Test3 "Value3";
#
Function Show() {
	Param(
		[Switch]$Detailed,
		[Switch]$Methods,
		[Switch]$ShowMethods,
		[Parameter(Position=0, ValueFromRemainingArguments)]$inline_args
	)

	$ShowStructure = $False;
	If ($PSBoundParameters.ContainsKey('Detailed') -Eq $True) {
		$ShowStructure = $True;
	} ElseIf ($PSBoundParameters.ContainsKey('Methods') -Eq $True) {
		$ShowStructure = $True;
	} ElseIf ($PSBoundParameters.ContainsKey('ShowMethods') -Eq $True) {
		$ShowStructure = $True;
	}

	ForEach ($EachArg in ($inline_args+$args)) {
		Write-Output "============================================================";
		Write-Output "`n`n --> Value (List):`n";
		$EachArg | Format-List;
		If ($ShowStructure -Eq $True) {

			$ListProperties = (Get-Member -View ("All") -InputObject ($EachArg) | Where-Object { $_.MemberType -eq "Property"} | Select-Object -ExpandProperty "Name");
			Write-Output "`n`n --> Properties:`n";
			$ListProperties.GetType();
			$ListProperties;

			$ListMethods = (Get-Member -View ("All") -InputObject ($EachArg) | Where-Object { $_.MemberType -eq "Method"} | Select-Object -ExpandProperty "Name");
			Write-Output "`n`n --> Methods:`n";
			$ListMethods.GetType();
			$ListMethods;

			$ListOthers = (Get-Member -View ("All") -InputObject ($EachArg) | Where-Object { $_.MemberType -ne "Property"} | Where-Object { $_.MemberType -ne "Method"});
			Write-Output "`n`n --> Other:`n";
			$ListOthers.GetType();
			$ListOthers;


		}
		Write-Output "`n------------------------------------------------------------";
	}

	Return;

}
Export-ModuleMember -Function "Show";
# Install-Module -Name "Show"



#
#	Citation(s)
#
#		"Powershell: Everything you wanted to know about arrays"
#			|--> https://powershellexplained.com/2018-10-15-Powershell-arrays-Everything-you-wanted-to-know/#write-output--noenumerate
#			|--> by Kevin Marquette
#
#