
# Chapter 01 — Microsoft Intune Fundamentals

**Track:** Microsoft Intune Lab  
**Level:** Beginner  
**Learning type:** Theory + Practical Lab  
**Environment:** Microsoft Intune admin center, Microsoft Entra ID, optional Microsoft Graph PowerShell

---

## 1. Learning Objectives

By completing this chapter, you should be able to:

- Explain Microsoft Intune and its primary capabilities.
- Differentiate Mobile Device Management (MDM) from Mobile Application Management (MAM).
- Understand the relationship between Intune, Microsoft Entra ID, managed devices, and Microsoft Graph.
- Identify licensing, permissions, and lab prerequisites.
- Navigate the Intune admin center.
- Perform initial tenant discovery without changing configuration.
- Use Microsoft Graph PowerShell for read-only checks.
- Document findings, troubleshoot access issues, and follow security best practices.

## 2. What Is Microsoft Intune?

Microsoft Intune is a cloud-based endpoint management service used to manage supported devices and protect organizational data.

Administrators can use Intune to:

- Enroll supported devices.
- Deploy applications.
- Configure device settings.
- Evaluate device compliance.
- Apply endpoint security policies.
- Manage device configuration and lifecycle.
- Monitor device status and policy deployment.
- Support Bring Your Own Device (BYOD) and corporate-owned device scenarios.

Intune is commonly used with Microsoft Entra ID, Microsoft 365, and other Microsoft security services.

### 2.1 MDM vs. MAM

| Feature | MDM | MAM |
|---|---|---|
| Full name | Mobile Device Management | Mobile Application Management |
| Main focus | Device management | Application and organizational data protection |
| Enrollment | Generally involves device enrollment | Can support app protection without full device enrollment in supported scenarios |
| Examples | Configuration profiles, device restrictions, compliance policies | App protection policies, app PIN requirements, data transfer restrictions |
| Typical use | Corporate-managed endpoints | Protecting work data on supported applications and personal devices |

**Important:** Available capabilities vary by platform, enrollment method, application support, tenant configuration, and licensing.

## 3. Microsoft Intune Architecture

### 3.1 Core Components

| Component | Purpose |
|---|---|
| Microsoft Intune | Manages supported endpoints, configurations, applications, and compliance |
| Microsoft Entra ID | Provides identity, authentication, groups, and access control |
| Managed endpoint | A supported Windows, macOS, iOS/iPadOS, or Android device |
| Microsoft Graph | Provides APIs for accessing and managing supported Microsoft cloud resources |
| Conditional Access | Evaluates access conditions using identity, device, application, and other supported signals |
| Role-Based Access Control (RBAC) | Limits administrators to permitted actions and resources |
| Microsoft 365 | Provides productivity services that may integrate with device management and access controls |

### 3.2 High-Level Workflow

1. An administrator configures policies in Intune.
2. A supported device enrolls through an appropriate enrollment method.
3. Intune associates the device with the applicable management configuration.
4. Policies and applications are delivered according to platform capabilities and assignments.
5. Device status and compliance information become available for evaluation.
6. Administrators review results and troubleshoot issues.
7. Where configured and licensed, compliance and device signals can participate in Conditional Access decisions.

### 3.3 Important Concepts

- **Enrollment:** Establishes a supported management relationship between a device and Intune.
- **Configuration profile:** Applies supported settings to targeted devices or users.
- **Compliance policy:** Evaluates whether a device meets defined requirements.
- **Application deployment:** Installs or makes applications available through supported deployment methods.
- **Endpoint security policy:** Configures supported security controls.
- **Assignment:** Targets a policy or application to users or devices, usually through groups.
- **Scope tags:** Help limit the administrative visibility of supported resources.
- **RBAC:** Controls what an administrator can do.

## 4. Licensing and Prerequisites

Before beginning practical configuration, verify the requirements for your specific scenario.

### 4.1 Prerequisites Checklist

- [ ] Access to a Microsoft tenant.
- [ ] Access to the Intune admin center.
- [ ] An eligible Intune license assigned as required for the scenario.
- [ ] Appropriate administrative permissions.
- [ ] A dedicated lab account where possible.
- [ ] A test device for enrollment exercises.
- [ ] Internet connectivity to required Microsoft services.
- [ ] Microsoft Graph PowerShell, if completing the optional API exercise.

### 4.2 Licensing Considerations

Licensing requirements depend on the subscription, user or device scenario, operating system, and feature being used.

Before deploying policies, verify:

- Whether the subscription includes the required Intune capabilities.
- Whether the relevant license is assigned.
- Whether additional identity or security licensing is required.
- Whether the planned enrollment and management scenario is supported.
- Whether administrative permissions and consent are available.

Do not assume a feature is available solely because you can open the admin center.

**Official reference:**  
https://learn.microsoft.com/en-us/intune/fundamentals/licensing

## 5. Lab Architecture and Safety

### 5.1 Lab Components

| Component | Purpose |
|---|---|
| Intune admin center | Portal for inspecting and managing Intune resources |
| Microsoft Entra ID | Identity and access management |
| Lab administrator | Performs authorized discovery and configuration |
| Lab user | Used for later enrollment and policy testing |
| Test device | Used for safe practical exercises |
| GitHub repository | Stores documentation, scripts, and sanitized evidence |

### 5.2 Security Rules

1. Start with read-only discovery.
2. Use a lab tenant whenever possible.
3. Do not experiment on production devices without authorization.
4. Verify the tenant and signed-in account before making changes.
5. Use least-privilege administrative roles.
6. Do not store passwords, tokens, private keys, or secrets in Git.
7. Redact sensitive user, tenant, and device information before publishing.
8. Review staged changes before committing them.
9. Document changes and rollback procedures for future implementation labs.

## 6. Practical Lab 01A — Intune Admin Center Discovery

### Objective

Explore the Intune admin center and record the initial environment without modifying any configuration.

### Step 1 — Open the Portal

Navigate to:

https://intune.microsoft.com/

Sign in using an account authorized to access the tenant.

### Step 2 — Verify Tenant Context

Confirm that you are working in the intended tenant. Record the tenant display name if permitted by your organization's documentation policy.

Do not publish sensitive tenant details unnecessarily.

### Step 3 — Inspect Available Areas

Depending on your permissions and the current portal layout, inspect:

- Devices
- Enrollment
- Configuration profiles
- Compliance policies
- Endpoint security
- Applications
- Reports
- Tenant administration
- Roles and scope tags

Portal labels may change over time.

### Step 4 — Review Existing Resources

Where authorized, inspect:

- Existing managed devices.
- Device groups.
- Configuration profiles.
- Compliance policies.
- Application assignments.
- Endpoint security policies.
- Administrative roles.

Do not create, assign, delete, sync, wipe, or retire resources during this discovery exercise.

### Step 5 — Record Findings

Update:

`12-Documentation/Lab-Guides/Chapter-01-Intune-Fundamentals/tenant-baseline.md`

Use `Not Verified`, `Not Reviewed`, or `Not Tested` when evidence is unavailable.

### Expected Result

You should understand the main areas of the portal, know whether your account has the necessary access, and have a documented starting baseline.

## 7. Practical Lab 01B — Microsoft Graph PowerShell

This optional lab uses Microsoft Graph to read organization and managed-device information.

Run these commands only against a tenant you are authorized to access.

### Step 1 — Open PowerShell

From macOS Terminal, use your configured shortcut:

```bash
pwsh
```

### Step 2 — Install the Authentication Module

```powershell
Install-Module Microsoft.Graph.Authentication -Scope CurrentUser
Import-Module Microsoft.Graph.Authentication
```

If prompted to trust the repository, review the prompt and follow your organization's software installation policy.

### Step 3 — Connect to Microsoft Graph

```powershell
Connect-MgGraph -Scopes @(
    "Organization.Read.All",
    "DeviceManagementManagedDevices.Read.All"
)

Get-MgContext |
    Select-Object TenantId, Account, Scopes
```

These are delegated permission scopes. Organizational consent may be required.

### Step 4 — Retrieve Organization Information

```powershell
$orgResponse = Invoke-MgGraphRequest `
    -Method GET `
    -Uri "https://graph.microsoft.com/v1.0/organization?`$select=id,displayName"

$orgResponse.value |
    Select-Object displayName, id
```

Verify that the returned organization corresponds to the intended tenant.

### Step 5 — Retrieve a Sample of Managed Devices

```powershell
$deviceResponse = Invoke-MgGraphRequest `
    -Method GET `
    -Uri "https://graph.microsoft.com/v1.0/deviceManagement/managedDevices?`$select=deviceName,operatingSystem,complianceState&`$top=10"

$deviceResponse.value |
    Select-Object deviceName, operatingSystem, complianceState
```

This query requests up to ten managed-device records.

An empty result may be normal if no devices are enrolled or visible to the account.

### Step 6 — Disconnect

```powershell
Disconnect-MgGraph
```

### Optional Cleanup

If the module was installed only for this exercise and no other scripts depend on it, you may remove it:

```powershell
Uninstall-Module Microsoft.Graph.Authentication
```

Do not uninstall shared dependencies without checking whether other workflows use them.

## 8. Validation Checklist

| Validation | Expected Result |
|---|---|
| Intune portal access | Portal opens with an authorized account |
| Tenant context | Intended tenant is confirmed |
| Licensing | Relevant requirements are verified or recorded as pending |
| Device inventory | Authorized device records are visible, or an empty result is documented |
| Graph authentication | `Get-MgContext` displays the intended account and tenant |
| Organization query | Organization information is returned if permissions allow |
| Device query | Device records or an empty collection are returned if the request is authorized |
| Session cleanup | Graph session is disconnected after testing |
| Documentation | `tenant-baseline.md` is updated with verified results |

## 9. Troubleshooting

| Issue | Checks and Recommended Action |
|---|---|
| Cannot open Intune admin center | Verify the account, tenant, permissions, licensing, and network access |
| Intune sections are missing | Check role permissions, administrative scope, licensing, and current portal layout |
| Graph module installation fails | Verify PowerShell version, repository access, and installation permissions |
| Graph sign-in fails | Check the installed module, network access, and authentication requirements |
| Graph returns access denied | Review requested scopes, consent, administrative permissions, and tenant policy |
| No managed devices are returned | Confirm tenant context, enrollment status, and permissions; an empty result is not automatically an error |
| Results contain sensitive information | Redact details before saving logs or publishing evidence |

Do not bypass organizational access controls to resolve a permissions issue. Request the required access through an authorized administrator.

## 10. Rollback and Cleanup

This chapter is designed as a read-only lab. No Intune configuration changes should be required.

If you completed the optional Graph exercise:

1. Run `Disconnect-MgGraph`.
2. Close the PowerShell session if you no longer need it.
3. Remove the optional module only if it is not needed by other scripts.
4. Verify that no configuration or device actions were performed accidentally.
5. Ensure that exported information is appropriately protected.

Do not delete tenant resources as part of this chapter.

## 11. Exercises

Complete the following tasks to reinforce your understanding.

- [ ] Explain the difference between MDM and MAM.
- [ ] Identify the responsibilities of Intune and Microsoft Entra ID.
- [ ] Draw a simple architecture diagram showing the administrator, Intune, Entra ID, and a managed device.
- [ ] Verify the licensing and access prerequisites for your lab.
- [ ] Complete the read-only portal discovery exercise.
- [ ] Update `tenant-baseline.md` with verified results.
- [ ] Run the optional Graph queries if authorized.
- [ ] Explain why an empty device query does not necessarily indicate a failure.
- [ ] Identify three actions that should be avoided during read-only discovery.

## 12. GitHub Deliverables

The chapter uses the existing repository structure:

```text
12-Documentation/
└── Lab-Guides/
    └── Chapter-01-Intune-Fundamentals/
        ├── README.md
        ├── tenant-baseline.md
        └── Chapter-01-Microsoft-Intune-Fundamentals-Notes.md
```

### Commit the Notes

From the repository root:

```bash
cd ~/Desktop/Intune_Policies

git status

git add \
  "12-Documentation/Lab-Guides/Chapter-01-Intune-Fundamentals/Chapter-01-Microsoft-Intune-Fundamentals-Notes.md" \
  "12-Documentation/Lab-Guides/Chapter-01-Intune-Fundamentals/tenant-baseline.md"

git diff --cached

git commit -m "Add Chapter 01 Intune fundamentals study notes"

git push origin main
```

Review `git diff --cached` before committing. Confirm that the staged files contain no credentials, access tokens, or sensitive tenant data.

## 13. Chapter Completion Record

| Task | Status |
|---|---|
| Read the fundamentals section | Pending |
| Understand the architecture | Pending |
| Review licensing and prerequisites | Pending |
| Complete portal discovery | Pending |
| Update tenant baseline | Pending |
| Complete optional Graph lab | Optional |
| Review security and troubleshooting | Pending |
| Commit and push documentation | Pending |

Update each status as you complete the task.

## 14. Official References

- [Microsoft Intune documentation](https://learn.microsoft.com/en-us/intune/)
- [Microsoft Intune licensing](https://learn.microsoft.com/en-us/intune/fundamentals/licensing)
- [Get started with Intune](https://learn.microsoft.com/en-us/intune/fundamentals/get-started)
- [Microsoft Graph documentation](https://learn.microsoft.com/en-us/graph/)
- [Install Microsoft Graph PowerShell](https://learn.microsoft.com/en-us/powershell/microsoftgraph/installation)

---

**End of Chapter 01 — Microsoft Intune Fundamentals**

