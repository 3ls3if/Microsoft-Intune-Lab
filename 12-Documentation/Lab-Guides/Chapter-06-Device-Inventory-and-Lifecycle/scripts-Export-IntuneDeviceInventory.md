# Script — Export-IntuneDeviceInventory.ps1

## Purpose

Export Intune managed-device records through Microsoft Graph into CSV and JSON files.

## Prerequisites

- Supported PowerShell environment; PowerShell 7 is recommended.
- Microsoft Graph Authentication module.
- Delegated permission/consent for `DeviceManagementManagedDevices.Read.All`.
- An authorized account with permission to read managed-device records.
- A secure output directory.

Install the module if needed:

```powershell
Install-Module Microsoft.Graph.Authentication -Scope CurrentUser

