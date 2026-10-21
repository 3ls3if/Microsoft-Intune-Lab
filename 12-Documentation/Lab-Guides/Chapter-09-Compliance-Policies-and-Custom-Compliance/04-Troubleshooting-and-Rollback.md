# 04 — Troubleshooting and Rollback

## Troubleshooting workflow

Follow this order before changing policy settings:

1. Confirm the device is enrolled in Intune.
2. Confirm the policy is assigned to the correct group.
3. Confirm the device or user is in the group.
4. Confirm the selected platform matches the device.
5. Inspect last check-in and policy status.
6. Validate the discovery script locally.
7. Validate the JSON syntax and setting names.
8. Compare script output with the JSON rule's expected type and value.
9. Inspect the device's individual compliance setting.
10. Allow time for the next evaluation before making repeated changes.

## Common symptoms

| Symptom | Possible cause | Investigation |
|---|---|---|
| Script unavailable in policy wizard | Wrong platform or upload incomplete | Confirm script type and save status |
| JSON rejected | Invalid JSON or unsupported schema | Run `python3 -m json.tool` and review the documented schema |
| Setting missing | Script output lacks the expected property | Compare `SettingName` with the JSON property |
| Data-type mismatch | Script returns text instead of a Boolean | Parse output with `ConvertFrom-Json` and inspect the property type |
| Unknown status | Evaluation pending or assignment issue | Verify enrollment, assignment, and last check-in |
| Unexpected noncompliance | Detection logic misses the actual installation | Inspect package and registry state on Windows |
| Script works interactively but not in Intune | Different execution context or permissions | Test under the intended execution context |
| Status does not update immediately | Evaluation or reporting delay | Trigger available sync/check-status actions and allow time |

## Windows diagnostics

Run locally:

```powershell
Get-AppxPackage -Name '*CompanyPortal*' |
    Select-Object Name, PackageFullName, InstallLocation

$uninstallRoots = @(
    'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\*',
    'HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*',
    'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\*'
)

foreach ($root in $uninstallRoots) {
    Get-ItemProperty -Path $root -ErrorAction SilentlyContinue |
        Where-Object DisplayName -Match 'Company Portal' |
        Select-Object DisplayName, DisplayVersion, InstallLocation
}
