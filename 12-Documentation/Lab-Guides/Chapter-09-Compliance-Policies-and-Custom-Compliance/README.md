# Chapter 09 — Compliance Policies and Custom Compliance

## Objectives
- Understand Intune device compliance and its relationship to Conditional Access.
- Create a built-in compliance policy.
- Build a Windows custom compliance discovery script and JSON rule.
- Validate compliance status and troubleshoot evaluation errors.
- Document rollback and security controls.

## Lab prerequisites
- Microsoft Intune subscription.
- Enrolled, supported Windows test device.
- Test user/device group.
- Appropriate Intune administrator permissions.
- Microsoft Entra ID P1/P2 or a suitable subscription if testing Conditional Access.

## Contents
- `01-Compliance-Fundamentals.md`
- `02-Built-in-Compliance-Lab.md`
- `03-Custom-Compliance-Lab.md`
- `04-Troubleshooting-and-Rollback.md`
- `05-Exercises-and-Validation.md`
- `scripts/Test-CompanyPortalCompliance.ps1`
- `config/company-portal-compliance.json`
- `reports/README.md`
- `evidence/README.md`

## Safety
Use a disposable lab device and a dedicated test group. Do not configure
automatic wipe or retire actions for this exercise. Validate all discovery
results before using compliance status in Conditional Access.

## Official references
- https://learn.microsoft.com/en-us/intune/device-security/compliance/create-policy
- https://learn.microsoft.com/en-us/intune/device-security/compliance/custom-settings
- https://learn.microsoft.com/en-us/intune/device-security/compliance/create-custom-script
- https://learn.microsoft.com/en-us/intune/device-security/compliance/create-custom-json
- https://learn.microsoft.com/en-us/intune/intune-service/protect/create-conditional-access-intune
