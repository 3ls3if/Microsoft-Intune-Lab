[CmdletBinding()]
param(
    [string]$OutputDirectory = "$HOME/Intune-Lab"
)

$ErrorActionPreference = 'Stop'

if (-not (Get-Module -ListAvailable -Name Microsoft.Graph.Authentication)) {
    throw 'Install Microsoft.Graph.Authentication before running this script.'
}

if (-not (Test-Path -LiteralPath $OutputDirectory)) {
    New-Item -Path $OutputDirectory -ItemType Directory -Force |
        Out-Null
}

Import-Module Microsoft.Graph.Authentication
$scopes = @('DeviceManagementManagedDevices.Read.All')

Connect-MgGraph -Scopes $scopes -NoWelcome

$select = @(
    'id',
    'deviceName',
    'operatingSystem',
    'osVersion',
    'manufacturer',
    'model',
    'serialNumber',
    'userPrincipalName',
    'managedDeviceOwnerType',
    'complianceState',
    'managementAgent',
    'enrolledDateTime',
    'lastSyncDateTime',
    'azureADDeviceId'
) -join ','

$uri = "https://graph.microsoft.com/v1.0/deviceManagement/managedDevices?`$select=$select"
$results = [System.Collections.Generic.List[object]]::new()

try {
    while ($uri) {
        $response = Invoke-MgGraphRequest -Method GET -Uri $uri

        foreach ($device in $response.value) {
            $results.Add([PSCustomObject]@{
                IntuneDeviceId    = $device.id
                DeviceName        = $device.deviceName
                OperatingSystem   = $device.operatingSystem
                OSVersion         = $device.osVersion
                Manufacturer      = $device.manufacturer
                Model             = $device.model
                SerialNumber      = $device.serialNumber
                UserPrincipalName = $device.userPrincipalName
                Ownership         = $device.managedDeviceOwnerType
                ComplianceState   = $device.complianceState
                ManagementAgent   = $device.managementAgent
                EnrolledDateTime  = $device.enrolledDateTime
                LastSyncDateTime  = $device.lastSyncDateTime
                EntraDeviceId     = $device.azureADDeviceId
            })
        }

        $uri = $response.'@odata.nextLink'
    }

    $stamp = Get-Date -Format 'yyyyMMdd-HHmmss'
    $csvPath = Join-Path $OutputDirectory "Intune-Inventory-$stamp.csv"
    $jsonPath = Join-Path $OutputDirectory "Intune-Inventory-$stamp.json"

    $results | Export-Csv -LiteralPath $csvPath -NoTypeInformation -Encoding utf8
    $results | ConvertTo-Json -Depth 5 |
        Set-Content -LiteralPath $jsonPath -Encoding UTF8

    Write-Host "Devices exported: $($results.Count)" -ForegroundColor Green
    Write-Host "CSV:  $csvPath"
    Write-Host "JSON: $jsonPath"
}
finally {
    Disconnect-MgGraph -ErrorAction SilentlyContinue
}