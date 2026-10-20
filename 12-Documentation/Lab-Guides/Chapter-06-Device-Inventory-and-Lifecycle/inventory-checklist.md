# Device Inventory Checklist

## A. Tenant readiness

- [ ] Confirm access to the Intune admin center.
- [ ] Confirm licensing for the test user/device and enrollment scenario.
- [ ] Confirm required Intune role permissions.
- [ ] Confirm approved Microsoft Graph permissions if using the export script.
- [ ] Use a disposable test device or VM.
- [ ] Verify that no production device is selected for lifecycle testing.

## B. Portal inventory

- [ ] Record device name.
- [ ] Record Intune device ID.
- [ ] Record Entra device ID, if available.
- [ ] Record OS and OS version.
- [ ] Record manufacturer and model, if available.
- [ ] Record serial number in private evidence only.
- [ ] Record ownership.
- [ ] Record enrollment date/method, if available.
- [ ] Record primary user where appropriate.
- [ ] Record compliance state.
- [ ] Record last check-in.

## C. Local Windows inventory

- [ ] Run `Get-LocalDeviceInventory.ps1` on Windows.
- [ ] Confirm the script printed the output path.
- [ ] Confirm the JSON parses successfully.
- [ ] Record the collection timestamp.
- [ ] Compare OS/model fields with Intune.
- [ ] Explain differences without assuming one source is always current.

## D. Microsoft Graph export

- [ ] Install/import `Microsoft.Graph.Authentication`.
- [ ] Authenticate to the intended tenant.
- [ ] Use approved delegated permissions.
- [ ] Confirm the script follows pagination.
- [ ] Confirm CSV and JSON files were generated.
- [ ] Summarize devices by OS.
- [ ] Summarize devices by compliance state.
- [ ] Confirm only approved fields were exported.
- [ ] Keep raw exports outside the public repository.

## E. Lifecycle safety

- [ ] Identify the exact test device.
- [ ] Record device identifiers and current state.
- [ ] Confirm authorization and backup/rebuild plan.
- [ ] Understand Sync, Retire, Wipe, Delete, and Autopilot Reset.
- [ ] Do not execute destructive actions without explicit approval.
- [ ] Verify completion after an approved action.
- [ ] Update asset records and document final disposition.

## F. Evidence

- [ ] Sanitized portal screenshot or written field record.
- [ ] Sanitized local inventory sample.
- [ ] Sanitized Graph export summary.
- [ ] Sync request and action status notes.
- [ ] Troubleshooting notes.
- [ ] Lifecycle decision record.
- [ ] No production identifiers or raw tenant data in public GitHub.
