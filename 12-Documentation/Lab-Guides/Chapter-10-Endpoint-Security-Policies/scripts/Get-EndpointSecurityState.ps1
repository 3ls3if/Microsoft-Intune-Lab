#requires -Version 5.1
<#
.SYNOPSIS
  Collects a read-only snapshot of Windows endpoint security state.
.DESCRIPTION
  Intended for an authorized Intune lab device. Collects Defender,
  firewall, BitLocker, and ASR information and exports a JSON report.
  Run in elevated PowerShell for the fullest local visibility.
#>

[CmdletBinding()]
param(
    [string]$OutputDirectory = "$env:ProgramData\IntuneLab\EndpointSecurity"
)

$ErrorActionPreference = 'Continue'

if (-not (Test-Path -LiteralPath $OutputDirectory)) {
    New-Item -Path $OutputDirectory -ItemType Directory -Force |
        Out-Null
}

$timestamp = Get-Date
$computer = Get-CimInstance Win32_ComputerSystem
$os = Get-CimInstance Win32_OperatingSystem

# Defender state
$defender = $null
try {
    $mp = Get-MpComputerStatus -ErrorAction Stop
    $defender = [pscustomobject]@{
        AMServiceEnabled             = $mp.AMServiceEnabled
        AntivirusEnabled             = $mp.AntivirusEnabled
        RealTimeProtectionEnabled    = $mp.RealTimeProtectionEnabled
        BehaviorMonitorEnabled       = $mp.BehaviorMonitorEnabled
        IoavProtectionEnabled        = $mp.IoavProtectionEnabled
        AMRunningMode                = $mp.AMRunningMode
        AntivirusSignatureVersion    = $mp.AntivirusSignatureVersion
        AntivirusSignatureLastUpdated = $mp.AntivirusSignatureLastUpdated
    }
}
catch {
    $defender = [pscustomobject]@{
        Error = $_.Exception.Message
    }
}

# Windows Firewall state
$firewall = @()
try {
    $firewall = @(
        Get-NetFirewallProfile -ErrorAction Stop |
            Select-Object Name, Enabled, DefaultInboundAction,
                          DefaultOutboundAction
    )
}
catch {
    $firewall = @([pscustomobject]@{
        Error = $_.Exception.Message
    })
}

# BitLocker state
$bitlocker = @()
try {
    $bitlocker = @(
        Get-BitLockerVolume -ErrorAction Stop |
            Select-Object MountPoint, VolumeType, VolumeStatus,
                          ProtectionStatus, EncryptionMethod,
                          EncryptionPercentage
    )
}
catch {
    $bitlocker = @([pscustomobject]@{
        Error = $_.Exception.Message
    })
}

# ASR state
$asrRules = @()
try {
    $pref = Get-MpPreference -ErrorAction Stop
    $ids = @($pref.AttackSurfaceReductionRules_Ids)
    $actions = @($pref.AttackSurfaceReductionRules_Actions)
    $count = [Math]::Min($ids.Count, $actions.Count)

    for ($i = 0; $i -lt $count; $i++) {
        $asrRules += [pscustomobject]@{
            RuleId = $ids[$i]
            Action = $actions[$i]
        }
    }
}
catch {
    $asrRules = @([pscustomobject]@{
        Error = $_.Exception.Message
    })
}

$report = [pscustomobject]@{
    CollectedAt = $timestamp.ToString('o')
    Device = [pscustomobject]@{
        Name           = $computer.Name
        Manufacturer   = $computer.Manufacturer
        Model          = $computer.Model
        Domain         = $computer.Domain
        OperatingSystem = $os.Caption
        Version        = $os.Version
        BuildNumber    = $os.BuildNumber
        LastBootUpTime = $os.LastBootUpTime
    }
    Defender = $defender
    Firewall = $firewall
    BitLocker = $bitlocker
    AttackSurfaceReductionRules = $asrRules
}

$fileName = '{0}-{1}.json' -f $computer.Name, $timestamp.ToString('yyyyMMdd-HHmmss')
$reportPath = Join-Path $OutputDirectory $fileName

$report |
    ConvertTo-Json -Depth 8 |
    Set-Content -LiteralPath $reportPath -Encoding UTF8

Write-Host "Endpoint security report saved to: $reportPath"
Write-Host "Review the report for errors and verify each setting in context."
