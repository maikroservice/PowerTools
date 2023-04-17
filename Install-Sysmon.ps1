<#
.SYNOPSIS
install-sysmon downloads the most up to date Sysmon zip archive and installs Sysmon64.exe
with the configuration file from Neo23x0 which is an updated fork from the swiftonsecurity repository
adapted from https://github.com/lock-wire/Install-Sysmon
.DESCRIPTION
PowerShell script to install Sysmon with Neo23x0 configuration 
.PARAMETER pwd
The path to the working directory (default is Downloads)
.EXAMPLE
Install-Sysmon -path C:\Users\maikroservice\Downloads
#>

[CmdletBinding()]

# Establish parameters for path
param (
    [string]$path=[Environment]::GetFolderPath("Downloads")   
)

# Test path and create it if required
If(!(test-path $path))
{
	Write-Information -MessageData "Path does not exist.  Creating Path..." -InformationAction Continue;
	New-Item -ItemType Directory -Force -Path $path | Out-Null;
}

# download sysmon and unzip it
Set-Location $path
Invoke-WebRequest -usebasicparsing -Uri https://download.sysinternals.com/files/Sysmon.zip -Outfile sysmon.zip
Expand-Archive sysmon.zip
Set-Location $path\Sysmon

# download sysmon config from Neo23x0
Invoke-WebRequest -Uri https://raw.githubusercontent.com/Neo23x0/sysmon-config/master/sysmonconfig-export.xml -Outfile sysmonconfig-export.xml
.\sysmon64.exe -accepteula -i sysmonconfig-export.xml

Write-Host "Sysmon Installed!"