# ------------------------------------------------------------
#
# PowerShell - FTYPE (CMD Command) (displays or modifies file types used in file extension associations)
#
# ------------------------------------------------------------

# General Syntax
#      <FileType>            Specifies the file type to display or change.
#      <OpenCommandString>   Specifies the open command string to use when opening files of the specified file type.
#      /?                    Displays help at the command prompt.

FTYPE [<FileType>[=[<OpenCommandString>]]]


# ------------------------------------------------------------

# List file name extension associations active for current session
CMD /C FTYPE

# Walk through the list of filetypes
If ($True) {
$Assocs_Obj=@{};
$FTypes_Obj=@{};
CMD /C ASSOC | Sort-Object | ForEach-Object { $Components=("${_}".Split("=")); $Assocs_Obj.("$(${Components}[0])")=("$(${Components}[1..$(${Components}.Count)]);"); };
CMD /C FTYPE | Sort-Object | ForEach-Object { $Components=("${_}".Split("=")); $FTypes_Obj.("$(${Components}[0])")=("$(${Components}[1..$(${Components}.Count)]);"); };
$Assocs_Resolved_Obj=($Assocs_Obj.Keys | Sort-Object | ForEach-Object {
	$Assoc_Key = "${_}";
	$Assoc_Val = (${Assocs_Obj}.("${Assoc_Key}") -replace "^((?:(?!;).)+)(;)?$","`$1");
	$FType_Key = ("${Assoc_Val}");
	$FType_Val = (${FTypes_Obj}.("${FType_Key}"));
	[PSCustomObject]@{"Assoc_Key"="${Assoc_Key}";"Assoc_Val"="${Assoc_Val}";"FType_Val"="${FType_Val}";};
});
$Assocs_Resolved_Obj | Format-Table -AutoSize;
}


# ------------------------------------------------------------

# List file name extension associations active for current session
CMD /C FTYPE


# Store list of current session's [ filetype associations with filename extensions ] on a file on the desktop
CMD /C FTYPE FTYPE 1>"${HOME}\Desktop\cmd.ftype.log"
notepad.exe "${HOME}\Desktop\cmd.ftype.log"


# ------------------------------------------------------------
#
# Citation(s)
#
#   docs.microsoft.com  |  "ftype - Displays or modifies file types that are used in file name extension associations"  |  https://docs.microsoft.com/en-us/windows-server/administration/windows-commands/ftype
#
# ------------------------------------------------------------