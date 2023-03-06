function invoke-PowerPing {
	$base_ip = "192.168.0."
	# create empty array
	$live = New-Object System.Collections.Generic.List[System.Object]
	
	
	for ($i = 1; ($i -lt 256); $i++) {
		$ip = $base_ip + $i.toString()
		$conn = Test-Connection -count 1 -comp $ip -quiet -ErrorAction SilentlyContinue
	
		if($conn -eq $true) {
			$live.add($ip)
		}
	}

	return $live
}
