
# Intune Custom Compliance Discovery Script
# Detect whether Company Portal is installed on Windows

$packageName = "Microsoft.CompanyPortal"

$installed = $false

try {
    # Check packages registered for any user
    $packages = Get-AppxPackage -AllUsers -Name $packageName `
        -ErrorAction SilentlyContinue

    if ($packages) {
        $installed = $true
    }

    # Check provisioned packages (available for new user profiles)
    if (-not $installed) {
        $provisioned = Get-AppxProvisionedPackage -Online `
            -ErrorAction SilentlyContinue |
            Where-Object {
                $_.DisplayName -eq $packageName
            }

        if ($provisioned) {
            $installed = $true
        }
    }
}
catch {
    # Do not report a false positive if detection fails
    $installed = $false
}

$result = @{
    CompanyPortalInstalled = [bool]$installed
}

return $result | ConvertTo-Json -Compress
