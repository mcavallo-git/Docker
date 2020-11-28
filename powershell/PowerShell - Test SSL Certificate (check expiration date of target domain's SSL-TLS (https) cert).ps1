
If ($True) {

	$DomainsToCheck = @(
		"https://mcavallo.com/",
		"https://cava.lol/"
	);

	$HttpWebRequest_AllowAutoRedirect = $False; <# Boolean -> True=[ Follow 301/302/etc. redirects ], False=[ Get domain certificate without redirects ] #>

	$HttpWebRequest_KeepAlive = $False; <# Boolean -> True=[ Keep HTTP connections open for the default duration of 2-minutes before closing the socket ], False=[ Close the socket immediately after retrieving the requested data ] #>
	
	$HttpWebRequest_MaximumAutomaticRedirections = 1; <# Integer -> The maximum number of redirects that the request follows #>

	$HttpWebRequest_Timeout = 3000; <# Integer -> Web request timeout (in milliseconds), e.g. abort the web request if it takes longer than this duration #>

	$ValidDaysRemaining_WarningLimit = 30; <# Integer -> Warn the user if the certificate expires before this many days (from now) #>

	[System.Net.ServicePointManager]::ServerCertificateValidationCallback = { $True }; <# Disable certificate validation (ignore SSL warnings) #>

	ForEach ($EachDomain In $DomainsToCheck) {

		Write-Host "------------------------------------------------------------";
		Write-Host "Requesting SSL Certificate from `"$EachDomain`" ...  " -NoNewLine;

		$HttpWebRequest = [System.Net.HttpWebRequest]::Create($EachDomain);
		$HttpWebRequest.AllowAutoRedirect = $HttpWebRequest_AllowAutoRedirect;
		$HttpWebRequest.KeepAlive = $HttpWebRequest_KeepAlive;
		$HttpWebRequest.MaximumAutomaticRedirections = $HttpWebRequest_MaximumAutomaticRedirections;
		$HttpWebRequest.Timeout = $HttpWebRequest_Timeout;

		Try {
			(($HttpWebRequest.GetResponse()).Close() | Out-Null);
		} Catch {
			# Write-Host URL check error $EachDomain`: $_ -f Red;
			Write-Host $_ -f Red;
		};

		$DomainCertificate = ($HttpWebRequest.ServicePoint.Certificate);
		$ExpDate_String = $DomainCertificate.GetExpirationDateString();
		$ExpDate_Obj = [DateTime]::Parse($ExpDate_String, $Null);

		Write-Host "Expiration DateTime=[ $($ExpDate_Obj.ToString()) ]";

		[Int]$ValidDaysRemaining = ($ExpDate_Obj - $(Get-Date)).Days;
		If ($ValidDaysRemaining -GT $ValidDaysRemaining_WarningLimit) {
			Write-Host "The certificate for domain `"$EachDomain`" expires in [ $ValidDaysRemaining ] days." -f Green;
		} Else {
			$certName = $DomainCertificate.GetName();
			$certThumbprint = $DomainCertificate.GetCertHashString();
			$certEffectiveDate = $DomainCertificate.GetEffectiveDateString();
			$certIssuer = $DomainCertificate.GetIssuerName();
			Write-Host "The certificate for domain `"$EachDomain`" expires in [ $ValidDaysRemaining ] days." -f Yellow;
			Write-Host Details:`n`nCert name: $certName`Cert thumbprint: $certThumbprint`nCert effective date: $certEffectiveDate`nCert issuer: $certIssuer -f Yellow;
		}


		$HttpWebRequest = $Null;
		# Remove-Variable ("HttpWebRequest");  <# Delete the value held by the variable AND the variable reference itself. #>

	}

	Write-Host "------------------------------------------------------------";

}


# ------------------------------------------------------------
#
# Citation(s)
#
#   docs.microsoft.com  |  "DateTime.Parse Method (System) | Microsoft Docs"  |  https://docs.microsoft.com/en-us/dotnet/api/system.datetime.parse?view=netframework-4.8
#
#   docs.microsoft.com  |  "DateTime.ParseExact Method (System) | Microsoft Docs"  |  https://docs.microsoft.com/en-us/dotnet/api/system.datetime.parseexact?view=netframework-4.8
#
#   docs.microsoft.com  |  "HttpWebRequest.KeepAlive Property (System.Net) | Microsoft Docs"  |  https://docs.microsoft.com/en-us/dotnet/api/system.net.httpwebrequest.keepalive?view=netframework-4.8
#
#   docs.microsoft.com  |  "HttpWebRequest.MaximumAutomaticRedirections Property (System.Net) | Microsoft Docs"  |  https://docs.microsoft.com/en-us/dotnet/api/system.net.httpwebrequest.maximumautomaticredirections?view=netframework-4.8
#
#   docs.microsoft.com  |  "ServicePointManager.ServerCertificateValidationCallback Property (System.Net) | Microsoft Docs"  |  https://docs.microsoft.com/en-us/dotnet/api/system.net.servicepointmanager.servercertificatevalidationcallback?view=netframework-4.8
#
#   stackoverflow.com  |  ".net - Is there a correct way to dispose of a httpwebrequest? - Stack Overflow"  |  https://stackoverflow.com/a/42241479
#
#   woshub.com  |  "Checking SSL/TLS Certificate Expiration Date with PowerShell | Windows OS Hub"  |  https://woshub.com/check-ssl-tls-certificate-expiration-date-powershell/
#
#   www.reddit.com  |  "Using Invoke-WebRequest with -Outfile while preserving filename : PowerShell"  |  https://www.reddit.com/r/PowerShell/comments/5h0zmw/using_invokewebrequest_with_outfile_while/
#
#   www.tutorialspoint.com  |  "How to get website SSL certificate validity dates with PowerShell?"  |  https://www.tutorialspoint.com/how-to-get-website-ssl-certificate-validity-dates-with-powershell
#
# ------------------------------------------------------------