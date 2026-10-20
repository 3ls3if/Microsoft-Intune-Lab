# Device Lifecycle Runbook

## Purpose

Provide a safe, auditable process for onboarding, active management, reassignment, retirement, and disposal of devices managed by Microsoft Intune.

## 1. Onboarding

1. Confirm device ownership and asset record.
2. Confirm that the enrollment method and platform are supported.
3. Confirm user/device licensing and required permissions.
4. Enroll using the approved organizational process.
5. Verify that the device appears under **Devices → All devices**.
6. Validate inventory, check-in, policy application, and compliance.
7. Record identifiers in the approved asset system, not a public repository.

**Success criteria:** The device is correctly identified, checks in, receives required management configuration, and has documented ownership.

## 2. Active management

1. Review OS version and compliance state.
2. Check last check-in and investigate stale records.
3. Verify primary user and ownership when relevant.
4. Review applicable policy and application status.
5. Investigate duplicates before deleting records.
6. Record actions taken and their results.

A stale check-in is an investigation signal, not sufficient evidence by itself that a device is retired.

## 3. Reassignment

1. Confirm manager or asset-owner approval.
2. Confirm backup and data-transfer requirements.
3. Determine whether a primary-user change is sufficient or a reset/re-enrollment is required.
4. Review user-targeted application and policy assignments.
5. Remove the previous user's access/data as required by organizational policy.
6. Update the primary user and asset record where appropriate.
7. Validate the new user's sign-in and managed state.

## 4. Retirement and disposal

1. Confirm authorization and identify the exact device using multiple identifiers.
2. Confirm backups, legal/retention requirements, and data-erasure requirements.
3. Select the supported action for the platform and scenario.
4. Record the request and action status.
5. Verify that the endpoint processed the action when possible.
6. Update the asset register and disposition record.
7. Review the associated Entra device object separately.
8. Follow the organization's secure disposal process.

## 5. Choosing an action

- **Sync:** Request management communication; no intended data erasure.
- **Retire:** Remove organizational management/data where supported.
- **Wipe:** Reset a supported device and remove data; destructive.
- **Delete:** Remove the Intune record and may initiate retirement for supported MDM scenarios. Cloud record removal does not prove endpoint completion.
- **Autopilot Reset:** Prepare a supported Windows device for reuse while retaining its organizational management relationship. This is not a generic factory reset.

Behaviour differs by platform and enrollment method. Review current Microsoft documentation before performing the action.

## 6. Required pre-action checklist

- [ ] Exact device verified.
- [ ] Platform and enrollment method confirmed.
- [ ] Action purpose documented.
- [ ] Approval recorded.
- [ ] Backup/rebuild plan confirmed.
- [ ] BitLocker recovery and identity dependencies considered.
- [ ] Expected user impact communicated.
- [ ] Recovery limitations understood.
- [ ] Post-action validation plan defined.

## 7. Recovery and rollback

Ordinary property changes may be restored from recorded original values. Destructive actions generally do not have a simple undo. Recovery may require device rebuild, re-enrollment, data restoration, or record recreation.

Do not delete the Entra device object solely to clean up an Intune record without reviewing join state, BitLocker recovery arrangements, and identity dependencies.

## 8. Official reference

https://learn.microsoft.com/en-us/intune/device-management/actions/index
