function invoke-PowerFuzz { 

	[CmdletBinding()]
	Param(
		[Parameter(Mandatory = $true, ValueFromPipeline = $true)]
	[string]$address,
	[Parameter(Mandatory = $true)]
	[string]$wordlistpath
	)
	
        
    # lets open a wordlist
    $wordlist = Get-Content $wordlistpath

    foreach ($item in [array]$wordlist) {
        $uri = "$($address)/$($item)"
        try {
            $req_status = invoke-webrequest -uri $uri | Select-Object StatusCode
        }
        catch {
            continue
        }        
        if($req_status.statuscode -eq 200) {
            "$($uri) - $($req_status.statuscode)"
        }
    }
}