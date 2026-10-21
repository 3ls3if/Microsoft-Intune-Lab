# 03 — Custom Compliance Lab

## Objective

Use a Windows PowerShell discovery script and a JSON rules file to evaluate whether a Company Portal installation footprint is detected.

## Files

- `scripts/Test-CompanyPortalCompliance.ps1`
- `config/company-portal-compliance.json`

## How it works

1. The discovery script checks selected Windows installation locations.
2. The script returns a JSON object containing `CompanyPortalInstalled`.
3. The custom compliance JSON defines the acceptable value.
4. Intune evaluates the discovered value against the rule.
5. The policy reports the custom setting result.

This is a basic installation-presence demonstration. It does not prove that Company Portal is healthy, signed in, current, or able to synchronize.

## Step 1 — Validate the JSON on macOS

From this directory, run:

```bash
python3 -m json.tool config/company-portal-compliance.json


A syntax error must be corrected before upload.
Step 2 — Review the discovery script
Open scripts/Test-CompanyPortalCompliance.ps1.

Verify:
- The setting name is CompanyPortalInstalled.
- The returned value is a Boolean.
- The script returns a compact JSON object.
- The script does not intentionally modify device settings.
- Errors and execution-context limitations are understood.
Step 3 — Test on Windows
Copy the script to a disposable Windows test device.

Run in PowerShell:
$result = & "C:\Lab\Test-CompanyPortalCompliance.ps1"
$result

$data = $result | ConvertFrom-Json

if ($null -eq $data.CompanyPortalInstalled) {
    throw "CompanyPortalInstalled is missing."
}

if ($data.CompanyPortalInstalled -isnot [bool]) {
    throw "CompanyPortalInstalled must be a Boolean."
}

$data | Format-List


Expected output when detected:
{"CompanyPortalInstalled":true}


Expected output when not detected:
{"CompanyPortalInstalled":false}


Actual results depend on the installation method and execution context. Do not hard-code a passing result.
Step 4 — Upload the discovery script
1. Open the Intune admin center.
2. Find the Windows custom compliance discovery-script workflow under device compliance.
3. Add a Windows discovery script.
4. Name it SCR-CMP-09-CompanyPortal-Presence.
5. Upload scripts/Test-CompanyPortalCompliance.ps1.
6. Review the execution options.
7. Use the 64-bit PowerShell host when appropriate for your detection logic.
8. Save the script.
Verify the current portal workflow and requirements in Microsoft's documentation before deployment.
Step 5 — Create the custom compliance policy
1. Open Devices > Compliance and create a Windows policy.
2. Name it CMP-09-WIN-CompanyPortal-Presence.
3. Open Custom Compliance settings.
4. Set custom compliance to Require.
5. Select the discovery script.
6. Upload config/company-portal-compliance.json.
7. Wait for Intune to validate the rules.
8. Assign the policy to SG-Intune-Compliance-Lab.
9. Keep noncompliance actions conservative.
10. Create the policy.
Step 6 — Validate the result
Inspect the test device's compliance status and the individual CompanyPortalInstalled setting.
Discovery output	Expected custom rule result
Boolean true	Compliant for this custom rule
Boolean false	Noncompliant for this custom rule
Missing property or invalid JSON	Evaluation error or missing setting

The overall device status may still be noncompliant because of another assigned policy.
Detection limitations
The sample uses uninstall registry entries and an Appx package query as detection signals. Company Portal packaging and installation context can vary. Test the script against the package on your actual device before relying on it.

For production use, document the supported app deployment method and validate the detection logic after app updates.
Security
- Use a dedicated test group.
- Keep the script read-only.
- Avoid collecting sensitive data.
- Review script changes before uploading.
- Test both passing and failing states.
- Do not use this single app-presence check as a substitute for broader security requirements.
Official references
- https://learn.microsoft.com/en-us/intune/device-security/compliance/create-policy
- https://learn.microsoft.com/en-us/intune/device-security/compliance/custom-settings
- https://learn.microsoft.com/en-us/intune/device-security/compliance/create-custom-script
- https://learn.microsoft.com/en-us/intune/device-security/compliance/create-custom-json
  EOF

## 5. Create `04-Troubleshooting-and-Rollback.md`

```bash
cat > 04-Troubleshooting-and-Rollback.md <<'EOF'
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


Compare these results with the discovery script's output.
Custom compliance error clues
Microsoft documents error codes for common custom compliance failures, including script failure, missing discovered settings, invalid JSON, and data-type errors. Consult the current Microsoft troubleshooting documentation for exact meanings and context.

Do not assume every failure has the same cause.
Rollback plan
1. Remove the test group's assignment from the custom compliance policy.
2. Verify no production group is targeted.
3. Remove the script association from the policy if necessary.
4. Delete the policy only after saving required lab evidence.
5. Delete the discovery script only when it is no longer assigned.
6. Remove the lab user or device from the test group if appropriate.
7. Restore any device settings changed during testing.
8. If Conditional Access was used, disable or remove the lab policy after confirming the test is complete.
9. Verify the device remains enrolled and user data is intact.
Do not use device wipe or retirement as routine lab cleanup.
Security controls
- Scope changes to a lab group.
- Avoid automatic destructive actions.
- Keep discovery scripts read-only.
- Review scripts before uploading.
- Do not commit credentials, tokens, or sensitive device data.
- Use a narrow Conditional Access test scope.
- Preserve emergency-access protections in production designs.
Official references
- https://learn.microsoft.com/en-us/intune/device-security/compliance/create-policy
- https://learn.microsoft.com/en-us/intune/device-security/compliance/create-custom-script
- https://learn.microsoft.com/en-us/intune/device-security/compliance/create-custom-json
- https://learn.microsoft.com/en-us/intune/intune-service/protect/create-conditional-access-intune
  EOF
