# Chapter 06 — Device Inventory and Lifecycle

## Overview

This chapter covers Microsoft Intune device inventory and lifecycle management, including hardware and operating system details, enrollment status, compliance, check-in activity, reporting, reassignment, retirement, and disposal.

## Learning objectives

- Understand inventory, enrollment, compliance, and device identity.
- Inspect device records in the Intune admin center.
- Collect local Windows inventory with PowerShell.
- Export managed-device records through Microsoft Graph.
- Compare local inventory with cloud inventory.
- Choose appropriate lifecycle actions.
- Troubleshoot stale or missing device data.
- Protect inventory reports and document recovery procedures.

## Prerequisites

- Microsoft Intune tenant and admin-center access.
- A licensed test user and enrolled test device, as required by the enrollment scenario.
- A Windows 10/11 test device or disposable VM.
- Appropriate Intune role permissions.
- Microsoft Graph PowerShell authentication support for the Graph lab.
- Git and the existing Microsoft Intune Lab repository.

## Chapter files

- `Chapter-06-Device-Inventory-and-Lifecycle-Lecture-Notes.md`
- `inventory-checklist.md`
- `lifecycle-runbook.md`
- `scripts-Get-LocalDeviceInventory.md`
- `scripts-Export-IntuneDeviceInventory.md`
- `config-inventory-fields.md`
- `reports-README.md`
- `evidence-README.md`
- `GitHub-Setup-and-Validation.md`

## Lab sequence

1. Confirm tenant readiness and licensing.
2. Inspect an enrolled test device.
3. Request a device Sync and review its status.
4. Collect local Windows inventory.
5. Export Intune inventory using Microsoft Graph.
6. Compare local and cloud fields.
7. Document lifecycle decisions.
8. Complete the checklist and record sanitized evidence.

## Licensing

Licensing depends on the subscription, user/device scenario, enrollment method, and applicable Microsoft terms. Intune Plan 1 capabilities are included in certain Microsoft 365 subscriptions, including Microsoft 365 Business Premium, subject to current terms. Standard inventory generally does not require Intune Suite add-ons.

Verify current requirements:
https://learn.microsoft.com/en-us/intune/fundamentals/licensing

## Lab safety

Use a disposable test device. Do not test Retire, Wipe, Delete, or Autopilot Reset on production devices. These actions can be disruptive or irreversible.

## Data protection

Do not commit production exports, real serial numbers, user principal names, tenant IDs, device IDs, recovery keys, tokens, or sensitive screenshots to a public repository.

## Official references

- https://learn.microsoft.com/en-us/intune/device-management/inventory-and-status/device-details
- https://learn.microsoft.com/en-us/intune/device-management/overview
- https://learn.microsoft.com/en-us/intune/device-management/actions/index
- https://learn.microsoft.com/en-us/graph/api/resources/intune-devices-manageddevice?view=graph-rest-1.0
