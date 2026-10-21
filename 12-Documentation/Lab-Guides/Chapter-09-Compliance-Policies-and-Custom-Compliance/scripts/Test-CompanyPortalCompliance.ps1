#requires -Version 5.1
<#
.SYNOPSIS
  Reports whether a Company Portal installation footprint is present.
.DESCRIPTION
  Intended for a Windows Intune custom compliance discovery script.
  This is a basic presence check, not an app-health or sign-in check.
#>

$ErrorActionPreference = 'Stop'

$paths = @(
    "$env:ProgramFiles\WindowsApps"
)

$installed = $false

# Check common uninstall registry locations first.
$uninstallRoots = @(
    'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\*',
    'HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*',
    'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\*'
)

foreach ($root in $uninstallRoots) {
    try {
        $apps = Get-ItemProperty -Path $root -ErrorAction SilentlyContinue
        if ($apps | Where-Object {
            $_.DisplayName -match 'Company Portal'
        }) {
            $installed = $true
            break
        }
    }
    catch {
        # Continue checking other locations.
    }
}

# Check the provisioned/registered MSIX package footprint.
# Package names can vary by deployment and app version, so this is
# an additional signal rather than a guarantee of app functionality.
if (-not $installed) {
    try {
        $packages = Get-AppxPackage -AllUsers -Name '*CompanyPortal*' `
            -ErrorAction SilentlyContinue

        if ($packages) {
            $installed = $true
        }
    }
    catch {
        # Some contexts may not permit querying all users.
    }
}

$result = @{
    CompanyPortalInstalled = [bool]$installed
}

return ($result | ConvertTo-Json -Compress)
