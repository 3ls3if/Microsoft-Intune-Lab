# Chapter 06 — Device Inventory and Lifecycle

## 1. Fundamentals

**Device inventory** is the information used to identify and understand a managed endpoint. Common fields include device name, operating system, OS version, manufacturer, model, serial number, ownership, enrollment date, compliance state, and last check-in.

**Enrollment** establishes an Intune management relationship.

**Compliance** evaluates a device against assigned compliance policies. Compliance is not a complete hardware inventory.

**Device identity** in Microsoft Entra ID is separate from the Intune managed-device record. An asset-management system may maintain another record for the physical device.

These records are related but are not interchangeable.

## 2. Architecture

1. A supported endpoint is registered or enrolled using an approved method.
2. The endpoint communicates with Intune management services.
3. Intune displays supported device details, status, policy results, and available actions.
4. Administrators use the Intune admin center, reports, and Microsoft Graph to inspect or export information.
5. The organization uses inventory for operations, security, reassignment, retirement, and asset reconciliation.

Available fields and capabilities vary by platform, OS version, enrollment method, and management features.

## 3. Inventory refresh and check-in

Inventory refresh and management check-in are related but not identical. An on-demand Sync request does not guarantee that every inventory field refreshes immediately.

When comparing local and cloud values, record:

- Local collection time.
- Intune last check-in time.
- Graph export time.
- The field being compared.
- The source of each value.

## 4. Lab 01 — Inspect inventory

1. Open https://intune.microsoft.com/.
2. Navigate to **Devices → All devices**.
3. Select a disposable test device.
4. Record the following information:

| Field | Value |
|---|---|
| Device name | |
| Intune device ID | |
| Entra device ID | |
| Serial number and model | |
| OS and OS version | |
| Ownership | |
| Enrollment date/method | |
| Primary user | |
| Compliance state | |
| Last check-in | |

5. Inspect the overview, device details, monitor/status sections, discovered apps if available, and device action status.
6. Capture private evidence and redact identifiers before publishing.

Portal sections and field availability differ by platform and enrollment type.

## 5. Lab 02 — Safe Sync validation

1. Select the test device.
2. Choose **Sync**.
3. Review the device action status.
4. Wait for the device to reconnect.
5. Refresh the device page and inspect the fields you are testing.
6. Record the result.

A submitted action is not proof that the device completed it. Validate the relevant field, policy status, or action status.

## 6. Lab 03 — Local Windows inventory

Use the script documented in `scripts-Get-LocalDeviceInventory.md`. It collects a local snapshot of system manufacturer/model, BIOS serial, OS details, memory, processor, and local disks.

Run it on a Windows test device. It is not intended to run on macOS.

## 7. Lab 04 — Microsoft Graph export

Use the script documented in `scripts-Export-IntuneDeviceInventory.md`.

The script uses the Microsoft Graph `deviceManagement/managedDevices` endpoint, requests the delegated scope `DeviceManagementManagedDevices.Read.All`, follows pagination, and writes CSV and JSON files.

Prerequisites:

- Supported PowerShell environment.
- Microsoft Graph Authentication module.
- Authorized sign-in and required consent.
- Appropriate access to managed-device records.

Use least privilege and protect generated exports.

## 8. Lifecycle stages

### Onboarding

- Confirm supported enrollment method.
- Confirm licensing and permissions.
- Enroll the device.
- Validate inventory, check-in, policy application, and compliance.

### Active management

- Monitor OS versions, compliance, and last check-in.
- Investigate duplicate or stale records.
- Confirm ownership and primary-user data where appropriate.

### Reassignment

- Confirm backup and data-handling requirements.
- Decide whether to update the primary user, reset, or re-enroll.
- Review application and policy assignments.
- Validate the new user's experience.

### Offboarding and disposal

- Confirm authorization, device identity, backups, retention, and data-erasure requirements.
- Choose a supported action for the platform and scenario.
- Verify action completion when possible.
- Update the asset record.
- Review the Entra device object separately.

## 9. Lifecycle action comparison

| Action | Purpose | Caution |
|---|---|---|
| Sync | Request management communication | Does not erase data or guarantee immediate refresh of every field. |
| Rename | Change a supported device name | Consider naming rules and dependent systems. |
| Retire | Remove organizational management/data where supported | The device must process the request; behaviour varies by platform. |
| Wipe | Reset a supported device and remove data | Destructive; confirm identity, authorization, and backup. |
| Delete | Remove the Intune record and may initiate retirement for supported MDM scenarios | Record removal does not prove endpoint completion. |
| Autopilot Reset | Prepare a supported Windows device for reuse while retaining its organizational management relationship | Not a generic factory reset. Confirm the scenario first. |

Always review current platform-specific documentation before performing an action.

## 10. Troubleshooting

| Symptom | Checks |
|---|---|
| Device absent from Intune | Confirm enrollment completion, tenant, account, and management method. |
| Last check-in is old | Check connectivity, power state, enrollment health, and action status. |
| Model or serial is blank | Compare local inventory; the field may not be exposed for that device. |
| Cloud and local values differ | Compare timestamps and data sources. |
| Compliance failure | Inspect the failed policy setting and evaluation details. |
| Graph HTTP 401 | Reauthenticate and verify tenant/account. |
| Graph HTTP 403 | Review permissions, consent, role access, and tenant policies. |
| Graph HTTP 429 | Respect `Retry-After` and reduce request frequency. |
| Export is empty | Confirm tenant/account and whether managed-device records exist. |
| Action remains pending | Device may be offline or may not have processed the request. |

### Windows diagnostics

```powershell
Get-ComputerInfo |
    Select-Object CsName, WindowsProductName, WindowsVersion,
        OsBuildNumber, CsManufacturer, CsModel

dsregcmd /status

Get-ScheduledTask |
    Where-Object { $_.TaskPath -like '\Microsoft\Windows\EnterpriseMgmt\*' } |
    Select-Object TaskPath, TaskName, State

Get-WinEvent -FilterHashtable @{
    LogName   = 'Microsoft-Windows-DeviceManagement-Enterprise-Diagnostics-Provider/Admin'
    StartTime = (Get-Date).AddHours(-24)
} -MaxEvents 30 -ErrorAction SilentlyContinue |
    Select-Object TimeCreated, Id, LevelDisplayName, Message

