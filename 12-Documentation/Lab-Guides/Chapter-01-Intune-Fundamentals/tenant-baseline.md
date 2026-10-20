
# Microsoft Intune Tenant Baseline

## 1. Lab Overview

- **Chapter:** 01 — Microsoft Intune Fundamentals
- **Purpose:** Record the initial tenant configuration before implementing Intune policies.
- **Environment:** Lab / Test / Production
- **Assessment Date:** YYYY-MM-DD
- **Administrator:** Lab Administrator
- **Status:** Initial Assessment

## 2. Tenant Information

| Item | Value |
|---|---|
| Tenant display name | Not Verified |
| Tenant ID | Not Recorded |
| Microsoft Entra ID access | Not Verified |
| Intune admin center access | Not Verified |
| Microsoft 365 subscription | Not Verified |
| Intune subscription/license | Not Verified |
| Microsoft Entra licensing | Not Verified |
| Microsoft Graph access | Not Tested |

**Security note:** Do not commit tenant identifiers, user details, access tokens, or other sensitive environment information to a public repository unless authorized.

## 3. Licensing and Prerequisites

| Requirement | Status | Notes |
|---|---|---|
| Eligible Intune license available | Not Verified | Check assigned licenses and service plans |
| Test user available | Not Verified | Prefer a dedicated lab account |
| Required administrative role | Not Verified | Verify the minimum role required |
| Microsoft Entra licensing verified | Not Verified | Check identity and Conditional Access requirements |
| Test device available | Not Verified | Identify a supported device before enrollment |
| Internet connectivity | Not Verified | Confirm access to required Microsoft services |
| Microsoft Graph PowerShell | Not Tested | Optional for Chapter 01 |

## 4. Intune Configuration Review

| Area | Status | Observations |
|---|---|---|
| MDM authority | Not Verified | Record the configured authority, if visible |
| Device enrollment | Not Reviewed | Inspect enrollment options and restrictions |
| Managed devices | Not Reviewed | Check whether devices are enrolled |
| Device groups | Not Reviewed | Identify suitable lab groups |
| Configuration profiles | Not Reviewed | Inspect existing profiles without changing them |
| Compliance policies | Not Reviewed | Inspect existing compliance policies |
| Endpoint security | Not Reviewed | Review available security policy categories |
| Applications | Not Reviewed | Inspect application deployment options |
| Conditional Access | Not Reviewed | Review only if authorized; do not modify |
| RBAC and scope tags | Not Reviewed | Record the administrator's permitted scope |
| Audit and reporting | Not Reviewed | Identify available reporting options |

## 5. Device Inventory

| Device Name | Platform | Enrollment State | Lab Device? |
|---|---|---|---|
| Not Recorded | Not Verified | Not Verified | Not Verified |

Only record devices you are authorized to document. Use sanitized names or placeholders when publishing this repository.

## 6. Microsoft Graph PowerShell Checks

- **PowerShell installed:** Not Tested
- **Microsoft Graph Authentication module:** Not Tested
- **Graph sign-in:** Not Tested
- **Organization information query:** Not Tested
- **Managed device query:** Not Tested
- **Permissions and consent:** Not Verified
- **Graph session disconnected after testing:** Not Verified

### Validation Results

| Test | Expected Result | Actual Result |
|---|---|---|
| Intune admin center | Portal accessible with authorized account | Pending |
| Tenant details | Authorized information visible | Pending |
| Graph authentication | Sign-in succeeds, if tested | Pending |
| Organization query | Organization response returned, if tested | Pending |
| Managed device query | Device records or an empty collection returned, if tested | Pending |

## 7. Security and Change Control

- [ ] Dedicated lab user identified.
- [ ] Test device identified before enrollment.
- [ ] Administrative permissions reviewed.
- [ ] Existing policies inspected without modification.
- [ ] No production assignments changed.
- [ ] No credentials, tokens, or private keys stored in Git.
- [ ] Sensitive tenant and device information reviewed for redaction.

## 8. Risks and Outstanding Items

| Item | Risk / Impact | Next Action |
|---|---|---|
| Licensing not verified | Some features may be unavailable | Verify subscription and service plans |
| Test device not identified | Device-specific exercises cannot proceed safely | Select an authorized lab device |
| Existing policies not reviewed | Future assignments could conflict with existing settings | Review policies before creating new ones |

Update this section as findings emerge.

## 9. Baseline Conclusion

The initial assessment documents the current level of access, licensing verification, available devices, and readiness for practical Intune exercises.

- **Current readiness:** Pending assessment.
- **Next step:** Complete the read-only tenant discovery exercise in Chapter 01.
- **Production changes:** None planned for this assessment.

Resolve licensing, permissions, and lab-device prerequisites before making configuration changes.

## 10. References

- [Microsoft Intune documentation](https://learn.microsoft.com/en-us/intune/)
- [Microsoft Intune licensing](https://learn.microsoft.com/en-us/intune/fundamentals/licensing)
- [Get started with Intune](https://learn.microsoft.com/en-us/intune/fundamentals/get-started)
- [Microsoft Graph documentation](https://learn.microsoft.com/en-us/graph/)

---

**Document maintenance:** Update this file when the tenant baseline changes. Record the date and describe significant changes rather than overwriting important findings without explanation.
