
# Chapter 05 — Device Enrollment Checklist

## 1. Lab Information

| Item | Details |
|---|---|
| Chapter | 05 — Device Enrollment |
| Assessment date | YYYY-MM-DD |
| Environment | Lab / Test / Production |
| Enrollment method | Windows Automatic Enrollment / Autopilot / Company Portal / Other |
| Tenant alias | Not Recorded |
| Test user alias | Not Recorded |
| Test device alias | Not Recorded |
| Administrator | Not Recorded |
| Status | Not Started |

> **Security:** Use aliases or sanitized values. Do not commit passwords, access tokens, personal information, or sensitive tenant details to GitHub.

## 2. Prerequisites

### Tenant and Licensing

- [ ] Access to the correct Microsoft Entra tenant confirmed.
- [ ] Intune admin center access verified.
- [ ] Required Intune license verified.
- [ ] Required Microsoft Entra licensing verified.
- [ ] Test user identified.
- [ ] Appropriate administrative permissions confirmed.
- [ ] Consent requirements reviewed, where applicable.

### Device Readiness

- [ ] Windows edition and version recorded.
- [ ] Device ownership confirmed.
- [ ] Existing Microsoft Entra join/registration state checked.
- [ ] Existing MDM provider or enrollment identified.
- [ ] Internet connectivity verified.
- [ ] Backup or VM checkpoint considered, where appropriate.
- [ ] Device approved for lab testing.

## 3. Enrollment Configuration Review

| Setting | Observed Value | Verified |
|---|---|---|
| MDM user scope | Not Verified | No |
| MAM user scope | Not Verified | No |
| Enrollment restrictions | Not Reviewed | No |
| Windows platform allowed | Not Verified | No |
| Device ownership restrictions | Not Reviewed | No |
| Intune device limit | Not Verified | No |
| Entra device limit | Not Verified | No |
| User license assignment | Not Verified | No |
| User group membership | Not Verified | No |

Do not change tenant-wide enrollment settings without authorization and a documented change plan.

## 4. Enrollment Procedure

- [ ] Selected the appropriate enrollment method.
- [ ] Confirmed that the test user is in the intended enrollment scope.
- [ ] Verified that enrollment restrictions permit the device.
- [ ] Recorded the device's original state.
- [ ] Completed the supported enrollment workflow.
- [ ] Recorded the enrollment attempt time.
- [ ] Allowed time for the device record to appear.
- [ ] Avoided repeated account removal or re-enrollment attempts before troubleshooting.

## 5. Validation

### Windows Device

- [ ] Ran `winver` and recorded the Windows version.
- [ ] Ran `dsregcmd /status`.
- [ ] Reviewed `AzureAdJoined`, `DomainJoined`, and `WorkplaceJoined`.
- [ ] Reviewed enrollment-related scheduled tasks if troubleshooting was needed.
- [ ] Reviewed MDM event logs if troubleshooting was needed.

### Intune Admin Center

- [ ] Located the device under Devices > All devices.
- [ ] Confirmed the expected platform.
- [ ] Reviewed ownership and enrollment information.
- [ ] Reviewed management status.
- [ ] Recorded compliance status separately from enrollment status.
- [ ] Verified the device is associated with the intended tenant.

> An Entra-joined or registered device is not necessarily successfully enrolled in Intune. Verify the Intune device record and relevant enrollment evidence.

## 6. Results

| Validation Item | Expected Result | Actual Result | Status |
|---|---|---|---|
| Tenant context | Correct tenant | Pending | Pending |
| User licensing | Eligible license assigned | Pending | Pending |
| Enrollment scope | User included in intended scope | Pending | Pending |
| Device join state | Matches the selected method | Pending | Pending |
| Intune device record | Device found in intended tenant | Pending | Pending |
| Enrollment status | Consistent with successful enrollment | Pending | Pending |
| Compliance state | Evaluated and recorded separately | Pending | Pending |
| Event logs | No unresolved error, or error documented | Pending | Pending |

## 7. Troubleshooting Record

| Field | Details |
|---|---|
| Issue observed | Not Recorded |
| Enrollment method | Not Recorded |
| Error code | Not Recorded |
| Error timestamp | Not Recorded |
| Relevant event ID | Not Recorded |
| Root cause | Not Determined |
| Corrective action | Not Recorded |
| Validation after fix | Pending |
| Microsoft documentation reference | Not Recorded |

## 8. Security Review

- [ ] Least-privilege access used.
- [ ] Enrollment was limited to an authorized test device.
- [ ] Enrollment settings were changed only with approval.
- [ ] Existing management was checked before enrollment.
- [ ] User privacy and ownership implications were considered.
- [ ] No production device was unintentionally enrolled.
- [ ] No secrets or raw diagnostic reports were committed to GitHub.
- [ ] Sensitive values were redacted from screenshots and logs.

## 9. Rollback and Cleanup

- [ ] Confirmed whether cleanup is required.
- [ ] Confirmed device ownership and business use.
- [ ] Selected the appropriate supported unenrollment procedure.
- [ ] Avoided using Wipe, Retire, Delete, and Disconnect interchangeably.
- [ ] Verified the resulting state in Windows.
- [ ] Verified the resulting state in Intune and Entra ID.
- [ ] Restored original tenant settings if required and approved.
- [ ] Documented any remaining device records or follow-up work.

Do not delete device records or remove management certificates blindly. Follow the supported procedure for the enrollment method and device ownership.

## 10. Lessons Learned

### What worked?

Record the successful steps and observations.

### What failed?

Record the error message, timestamp, and relevant event information without exposing sensitive data.

### Root cause

Document the confirmed cause rather than an assumption.

### Resolution

Record the corrective action and how the result was validated.

### Follow-up actions

List any required licensing, configuration, security, or documentation improvements.

## 11. Completion Status

- [ ] Prerequisites verified.
- [ ] Enrollment method documented.
- [ ] Enrollment attempted or completed.
- [ ] Validation completed.
- [ ] Troubleshooting evidence reviewed, if needed.
- [ ] Security review completed.
- [ ] Rollback plan documented.
- [ ] GitHub content reviewed for sensitive information.

**Final status:** Not Started / In Progress / Completed / Blocked

## 12. References

- [Windows enrollment guide](https://learn.microsoft.com/en-us/intune/intune-service/fundamentals/deployment-guide-enrollment-windows)
- [Windows automatic enrollment](https://learn.microsoft.com/en-us/mem/intune/enrollment/windows-enroll)
- [Enrollment restrictions](https://learn.microsoft.com/en-us/intune/device-enrollment/restrictions)
- [Troubleshoot Intune enrollment](https://learn.microsoft.com/en-us/troubleshoot/mem/intune/troubleshoot-device-enrollment-in-intune)
