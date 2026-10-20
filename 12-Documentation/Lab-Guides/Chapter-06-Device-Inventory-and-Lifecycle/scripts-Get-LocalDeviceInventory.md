# Script — Get-LocalDeviceInventory.ps1

## Purpose

Collect a read-only Windows inventory snapshot and save it as JSON.

## PowerShell script

Save the code below as `Get-LocalDeviceInventory.ps1` on your Windows test device.

```powershell
[CmdletBinding()]
param(
    [string]$OutputDirectory = "$env:USERPROFILE\Documents\Intune-Lab"
)

$ErrorActionPreference = 'Stop'

if (-not (Test-Path -LiteralPath $OutputDirectory)) {
    New-Item -Path $OutputDirectory -ItemType Directory -Force |
        Out-Null
}

$timestamp = Get-Date -Format 'yyyyMMdd-HHmmss'
$outputFile = Join-Path $OutputDirectory "Local-Device-Inventory-$timestamp.json"

$computerSystem = Get-CimInstance -ClassName Win32_ComputerSystem
$operatingSystem = Get-CimInstance -ClassName Win32_OperatingSystem
$bios = Get-CimInstance -ClassName Win32_BIOS
$processor = Get-CimInstance -ClassName Win32_Processor |
    Select-Object -First 1

$disks = @(Get-CimInstance -ClassName Win32_LogicalDisk -Filter "DriveType=3" |
    Select-Object DeviceID, VolumeName, FileSystem,
        @{Name='SizeGB'; Expression={
            if ($_.Size) { [math]::Round($_.Size / 1GB, 2) } else { $null }
        }},
        @{Name='FreeGB'; Expression={
            if ($_.FreeSpace) { [math]::Round($_.FreeSpace / 1GB, 2) } else { $null }
        }})

$inventory = [PSCustomObject]@{
    CollectedAt       = (Get-Date).ToString('o')
    ComputerName      = $env:COMPUTERNAME
    Manufacturer      = $computerSystem.Manufacturer
    Model             = $computerSystem.Model
    DomainOrWorkgroup = $computerSystem.Domain
    SerialNumber      = $bios.SerialNumber
    BIOSVersion       = $bios.SMBIOSBIOSVersion
    OSName            = $operatingSystem.Caption
    OSVersion         = $operatingSystem.Version
    OSBuild           = $operatingSystem.BuildNumber
    OSArchitecture    = $operatingSystem.OSArchitecture
    LastBootTime      = $operatingSystem.LastBootUpTime
    TotalMemoryGB     = [math]::Round(
        $computerSystem.TotalPhysicalMemory / 1GB, 2
    )
    CPUName           = $processor.Name
    LogicalProcessors = $computerSystem.NumberOfLogicalProcessors
    Disks             = $disks
}

$inventory | ConvertTo-Json -Depth 5 |
    Set-Content -LiteralPath $outputFile -Encoding UTF8

Write-Host "Inventory saved to: $outputFile" -ForegroundColor Green
$inventory
