
#requires -Version 5.1

<#
.SYNOPSIS
    Collects basic Windows device enrollment diagnostics for Microsoft Intune.

.DESCRIPTION
    Collects:
      - Windows version and build information
      - Microsoft Entra join status using dsregcmd
      - Enrollment-related scheduled tasks
      - Recent DeviceManagement-Enterprise-Diagnostics-Provider events

    This script is read-only. It does not enroll, unenroll, wipe, retire,
    delete, or modify device configuration.

.NOTES
    Run locally on the Windows test device.
    Review and redact sensitive information before sharing the report.
#>

[CmdletBinding()]
param(
    [ValidateRange(1, 200)]
    [int]$MaxEvents = 30,

    [string]$OutputDirectory = (Join-Path $env:USERPROFILE "Desktop")
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Continue"

$timestamp = Get-Date -Format "yyyyMMdd-HHmmss"
$reportPath = Join-Path $OutputDirectory "Intune-Enrollment-Diagnostics-$timestamp.txt"

if (-not (Test-Path -LiteralPath $OutputDirectory)) {
    New-Item -Path $OutputDirectory -ItemType Directory -Force |
        Out-Null
}

function Add-ReportHeading {
    param(
        [Parameter(Mandatory)]
        [string]$Title
    )

    "`r`n" + ("=" * 78) | Out-File -FilePath $reportPath -Append -Encoding utf8
    $Title | Out-File -FilePath $reportPath -Append -Encoding utf8
    ("=" * 78) | Out-File -FilePath $reportPath -Append -Encoding utf8
}

function Add-ReportText {
    param(
        [Parameter(Mandatory)]
        [AllowEmptyString()]
        [string]$Text
    )

    $Text | Out-File -FilePath $reportPath -Append -Encoding utf8
}

try {
    @(
        "Microsoft Intune Enrollment Diagnostics"
        "Collection time: $(Get-Date -Format o)"
        "Computer name: $env:COMPUTERNAME"
        "PowerShell version: $($PSVersionTable.PSVersion)"
        ""
        "SECURITY NOTICE:"
        "This report may contain sensitive device, tenant, or user information."
        "Review and redact it before sharing or committing it to Git."
    ) | Out-File -FilePath $reportPath -Encoding utf8

    # ---------------------------------------------------------
    # 1. Windows operating system information
    # ---------------------------------------------------------
    Add-ReportHeading "1. Windows Operating System"

    try {
        $os = Get-CimInstance -ClassName Win32_OperatingSystem -ErrorAction Stop

        $os |
            Select-Object Caption, Version, BuildNumber, OSArchitecture,
                InstallDate, LastBootUpTime |
            Format-List |
            Out-String |
            Add-Content -Path $reportPath -Encoding utf8
    }
    catch {
        Add-ReportText "Could not collect operating system information: $($_.Exception.Message)"
    }

    # ---------------------------------------------------------
    # 2. Microsoft Entra join and registration status
    # ---------------------------------------------------------
    Add-ReportHeading "2. Microsoft Entra Join Status"

    $dsregCommand = Get-Command "dsregcmd.exe" -ErrorAction SilentlyContinue

    if ($dsregCommand) {
        try {
            $dsregOutput = & $dsregCommand.Source /status 2>&1
            $dsregOutput |
                Out-String |
                Add-Content -Path $reportPath -Encoding utf8
        }
        catch {
            Add-ReportText "dsregcmd failed: $($_.Exception.Message)"
        }
    }
    else {
        Add-ReportText "dsregcmd.exe was not found on this device."
    }

    # ---------------------------------------------------------
    # 3. Enrollment-related scheduled tasks
    # ---------------------------------------------------------
    Add-ReportHeading "3. Enrollment-Related Scheduled Tasks"

    try {
        $tasks = Get-ScheduledTask -ErrorAction Stop |
            Where-Object {
                $_.TaskPath -like "\Microsoft\Windows\EnterpriseMgmt\*"
            } |
            Select-Object TaskName, TaskPath, State

        if ($tasks) {
            $tasks |
                Format-Table -AutoSize |
                Out-String -Width 240 |
                Add-Content -Path $reportPath -Encoding utf8
        }
        else {
            Add-ReportText "No matching EnterpriseMgmt scheduled tasks were found."
        }
    }
    catch {
        Add-ReportText "Could not query scheduled tasks: $($_.Exception.Message)"
    }

    # ---------------------------------------------------------
    # 4. Recent MDM diagnostic events
    # ---------------------------------------------------------
    Add-ReportHeading "4. Recent MDM Diagnostic Events"

    $eventLog = "Microsoft-Windows-DeviceManagement-Enterprise-Diagnostics-Provider/Admin"

    try {
        $events = Get-WinEvent -FilterHashtable @{
            LogName = $eventLog
        } -MaxEvents $MaxEvents -ErrorAction Stop

        if ($events) {
            foreach ($event in $events) {
                Add-ReportText "Time: $($event.TimeCreated)"
                Add-ReportText "Event ID: $($event.Id)"
                Add-ReportText "Level: $($event.LevelDisplayName)"
                Add-ReportText "Message:"
                Add-ReportText ($event.Message -replace "`r?`n", "`r`n")
                Add-ReportText ("-" * 60)
            }
        }
        else {
            Add-ReportText "No events were returned."
        }
    }
    catch {
        Add-ReportText "Could not query the MDM event log: $($_.Exception.Message)"
    }

    # ---------------------------------------------------------
    # 5. Basic network configuration summary
    # ---------------------------------------------------------
    Add-ReportHeading "5. Network Configuration Summary"

    try {
        $network = Get-NetIPConfiguration -ErrorAction Stop |
            Select-Object InterfaceAlias,
                @{
                    Name = "IPv4Address"
                    Expression = {
                        ($_.IPv4Address | ForEach-Object { $_.IPAddress }) -join ", "
                    }
                },
                @{
                    Name = "IPv4DefaultGateway"
                    Expression = {
                        ($_.IPv4DefaultGateway | ForEach-Object { $_.NextHop }) -join ", "
                    }
                },
                @{
                    Name = "DNSServer"
                    Expression = {
                        ($_.DNSServer.ServerAddresses) -join ", "
                    }
                }

        $network |
            Format-Table -AutoSize |
            Out-String -Width 240 |
            Add-Content -Path $reportPath -Encoding utf8
    }
    catch {
        Add-ReportText "Could not collect network summary: $($_.Exception.Message)"
    }

    # ---------------------------------------------------------
    # 6. Completion summary
    # ---------------------------------------------------------
    Add-ReportHeading "6. Collection Summary"

    Add-ReportText "Completed: $(Get-Date -Format o)"
    Add-ReportText "Report path: $reportPath"
    Add-ReportText "This script did not intentionally change device enrollment settings."
    Add-ReportText "Review and redact the report before sharing it."

    Write-Host ""
    Write-Host "Diagnostics collection completed." -ForegroundColor Green
    Write-Host "Report saved to: $reportPath"
    Write-Host "Review the report for sensitive information before sharing."
}
catch {
    Write-Error "Diagnostics collection failed: $($_.Exception.Message)"
    exit 1
}
