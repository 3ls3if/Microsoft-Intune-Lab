
# Microsoft Intune Lab

A hands-on learning repository for Microsoft Intune, endpoint management, device security, compliance policies, application deployment, and automation.

This repository documents practical labs, reusable configuration examples, PowerShell scripts, and troubleshooting procedures developed while learning Microsoft Intune and the Microsoft Endpoint Management ecosystem.

## Objectives

- Learn Microsoft Intune administration through practical labs.
- Configure and manage Windows, macOS, iOS/iPadOS, and Android devices.
- Implement device compliance and configuration policies.
- Explore endpoint security, application deployment, and update management.
- Automate administrative tasks using PowerShell and Microsoft Graph API.
- Document testing, troubleshooting, and deployment procedures.
- Maintain reusable examples for learning and professional reference.

## Repository Structure

| Directory | Description |
|---|---|
| `01-Device-Management/` | Configuration profiles, Settings Catalog, and device restrictions |
| `02-Compliance-Policies/` | Compliance policies and custom compliance scripts |
| `03-Endpoint-Security/` | Security baselines, antivirus, firewall, BitLocker, and attack surface reduction |
| `04-Applications/` | Application deployment, detection scripts, and requirements |
| `05-Scripts-and-Remediations/` | PowerShell detection, remediation, and utility scripts |
| `06-Conditional-Access/` | Related Microsoft Entra Conditional Access configurations |
| `07-Identity-and-Enrollment/` | Entra join, Windows Autopilot, and enrollment restrictions |
| `08-Updates-and-Patching/` | Update rings, feature updates, and quality updates |
| `09-Device-Platform-Labs/` | Platform-specific Intune labs |
| `10-Reports-and-Monitoring/` | Compliance reports, inventory, and troubleshooting |
| `11-Graph-API-and-Automation/` | Microsoft Graph API, PowerShell, and JSON examples |
| `12-Documentation/` | Lab guides, architecture, and troubleshooting documentation |

## Current Labs

### 1. Company Portal Custom Compliance

**Location:** `02-Compliance-Policies/Custom-Compliance/Company-Portal/`

Files:

- `CompanyPortal-Compliance.json` — Custom compliance policy rules.
- `CompanyPortal-Detection.ps1` — PowerShell discovery script used to evaluate the selected compliance condition.

**Objective:** Learn how to evaluate a device condition using an Intune custom compliance policy and report the result to Intune.

Topics to document:

- Supported operating systems and prerequisites.
- Custom compliance policy requirements.
- Script output format and JSON rule definitions.
- Policy assignment and device synchronization.
- Compliance evaluation and troubleshooting.

**Note:** The Company Portal application and its installation state must be evaluated using a method supported by the target operating system. Validate the detection logic and the applicable Intune custom compliance requirements before deploying the policy.

## Lab Documentation Standard

For each new lab, document the following:

1. **Objective** — What the lab is intended to achieve.
2. **Prerequisites** — Required licenses, permissions, devices, and modules.
3. **Configuration** — Policy settings and implementation steps.
4. **Files** — Scripts, JSON configurations, and supporting resources.
5. **Assignment** — Target groups, filters, and deployment scope.
6. **Testing** — Validation steps and expected results.
7. **Troubleshooting** — Errors encountered and their resolutions.
8. **Rollback** — Steps to safely revert the configuration.

## Technologies

- Microsoft Intune
- Microsoft Entra ID
- Microsoft Graph API
- PowerShell
- JSON
- Windows endpoint management
- macOS, iOS/iPadOS, and Android management
- Git and GitHub

## Security Guidelines

- Never commit passwords, access tokens, client secrets, private keys, or credentials.
- Review exported policy configurations before committing them.
- Redact tenant IDs, user information, device identifiers, and other sensitive environment details where appropriate.
- Test policies and scripts on lab devices or a pilot group before production deployment.
- Follow the principle of least privilege.
- Validate all configurations against current Microsoft documentation.

## Learning Resources

- [Microsoft Intune Documentation](https://learn.microsoft.com/en-us/intune/)
- [Microsoft Graph Documentation](https://learn.microsoft.com/en-us/graph/)
- [Microsoft Graph PowerShell SDK](https://learn.microsoft.com/en-us/powershell/microsoftgraph/overview)
- [Microsoft Entra Documentation](https://learn.microsoft.com/en-us/entra/)

## Disclaimer

This repository is an independent learning and lab project. Configurations and scripts are provided for educational purposes and must be tested and validated in the target environment before production use.

Microsoft Intune and Microsoft Entra ID are Microsoft products. This repository is not an official Microsoft project.
