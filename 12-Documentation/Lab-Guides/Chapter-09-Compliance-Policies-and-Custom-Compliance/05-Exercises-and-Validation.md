# 05 — Exercises and Validation

## Exercise 1 — Built-in compliance

- [ ] Create a Windows compliance policy.
- [ ] Assign it to the lab group.
- [ ] Confirm the test device receives the policy.
- [ ] Record the device's initial compliance status.
- [ ] Explain one reported setting.

Acceptance criteria: the policy is assigned to the intended test scope and its status is documented.

## Exercise 2 — Custom compliance

- [ ] Validate the PowerShell script locally on Windows.
- [ ] Confirm the script returns a JSON object.
- [ ] Confirm `CompanyPortalInstalled` is a Boolean.
- [ ] Validate the custom compliance JSON on macOS.
- [ ] Upload the discovery script to Intune.
- [ ] Create the custom compliance policy.
- [ ] Assign it to the lab group.
- [ ] Record the individual setting result.

Acceptance criteria: the local script output matches the setting name and data type expected by the JSON rule.

## Exercise 3 — Pass and fail testing

- [ ] Test a device where Company Portal is detected.
- [ ] Test a device where it is not detected, if safely available.
- [ ] Compare the script output with Intune's reported setting result.
- [ ] Document any delay between evaluation and reporting.
- [ ] Restore the lab device to its intended state.

Acceptance criteria: both expected values and their limitations are documented.

## Exercise 4 — Improve detection

- [ ] Identify the package format used by the test device.
- [ ] Document which detection signals are reliable for that package.
- [ ] Update the script only after testing the change.
- [ ] Revalidate JSON output and rule compatibility.
- [ ] Test after an app update if possible.

Acceptance criteria: the detection logic is documented and does not report success without evidence.

## Exercise 5 — Conditional Access design

- [ ] Explain the difference between compliance evaluation and access enforcement.
- [ ] Identify the required Entra licensing.
- [ ] Design a policy scoped only to test users.
- [ ] Consider report-only mode before enforcement.
- [ ] Document emergency-access and rollback precautions.

Do not enforce tenant-wide Conditional Access as part of this exercise.

## Evidence checklist

- [ ] Built-in compliance policy configuration.
- [ ] Policy assignment scope.
- [ ] Test device OS and enrollment state.
- [ ] Discovery script source and local output.
- [ ] JSON validation output.
- [ ] Custom compliance policy configuration.
- [ ] Individual compliance setting result.
- [ ] Troubleshooting notes, if applicable.
- [ ] Rollback verification.

Redact unnecessary user information, serial numbers, tenant identifiers, and other sensitive details before committing evidence.

## Repository validation

From the chapter directory:

```bash
python3 -m json.tool config/company-portal-compliance.json

for file in \
  README.md \
  01-Compliance-Fundamentals.md \
  02-Built-in-Compliance-Lab.md \
  03-Custom-Compliance-Lab.md \
  04-Troubleshooting-and-Rollback.md \
  05-Exercises-and-Validation.md \
  scripts/Test-CompanyPortalCompliance.ps1 \
  config/company-portal-compliance.json \
  reports/README.md \
  evidence/README.md
do
  if [ -f "$file" ]; then
    printf 'OK      %s\n' "$file"
  else
    printf 'MISSING %s\n' "$file"
  fi
done


Chapter completion criteria
- [ ] Built-in policy created and evaluated.
- [ ] Custom discovery script tested.
- [ ] JSON validated.
- [ ] Custom policy created and assigned.
- [ ] Pass/fail behavior investigated.
- [ ] Security and rollback documented.
- [ ] All expected files exist.
- [ ] Git changes reviewed and committed.
Official references
- https://learn.microsoft.com/en-us/intune/device-security/compliance/create-policy
- https://learn.microsoft.com/en-us/intune/device-security/compliance/create-custom-script
- https://learn.microsoft.com/en-us/intune/device-security/compliance/create-custom-json
- https://learn.microsoft.com/en-us/intune/intune-service/protect/create-conditional-access-intune
## 7. Verify all files

Run:

```bash
for file in \
  README.md \
  01-Compliance-Fundamentals.md \
  02-Built-in-Compliance-Lab.md \
  03-Custom-Compliance-Lab.md \
  04-Troubleshooting-and-Rollback.md \
  05-Exercises-and-Validation.md \
  scripts/Test-CompanyPortalCompliance.ps1 \
  config/company-portal-compliance.json \
  reports/README.md \
  evidence/README.md
do
  if [ -f "$file" ]; then
    printf 'OK      %s\n' "$file"
  else
    printf 'MISSING %s\n' "$file"
  fi
done

python3 -m json.tool config/company-portal-compliance.json
