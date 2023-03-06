function invoke-PowerScan { 

	[CmdletBinding()]
	Param(
		[Parameter(Mandatory = $true, ValueFromPipeline = $true)]
	$ips,
	[Parameter(Mandatory = $false)]
	$ports
	)

	if(!$ports) {
		$ports = (1..65535)
	}
	
	$openports = @{ }
	foreach($ip in [array]$ips) {
		$openports.$($ip) = New-Object System.Collections.Generic.List[System.Object]
		foreach($port in $ports) {
			

				try {                      
					$socket = New-Object System.Net.Sockets.TcpClient($ip, $port)
		            	
					if ($socket.Connected) {
			        		# if we can connect the port is open     
		              		$socket.Close()
			        		$openports[$ip].add($port)
				  		
		            	}
		   		}
				catch {
				continue
				}
	}
	}
	$openports
}
