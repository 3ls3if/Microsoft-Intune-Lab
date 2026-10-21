# 01 — Intune Compliance Fundamentals

## Objectives

- Understand device compliance in Microsoft Intune.
- Distinguish compliance policies from configuration policies.
- Understand how compliance status integrates with Microsoft Entra Conditional Access.
- Identify licensing, permissions, and platform requirements.

## 1. What is device compliance?

An Intune compliance policy evaluates whether a managed device meets defined requirements.

Examples:
- Minimum operating system version.
- Password or screen-lock requirements.
- Device encryption.
- Firewall and antivirus requirements, where supported.
- Custom device properties reported by a discovery script.

Intune reports whether a device meets the policy requirements. Multiple assigned policies may affect the overall device compliance state.

## 2. Compliance versus configuration

| Capability | Compliance policy | Configuration policy |
|---|---|---|
| Main purpose | Evaluate device state | Configure device settings |
| Example | Require encryption | Configure BitLocker |
| Result | Compliant, noncompliant, error, or another reported state | Configuration applied, failed, or conflicted |
| Conditional Access integration | Yes, through device compliance status | Not directly as a compliance result |

A compliance policy does not necessarily remediate a device. Use configuration policies, remediation scripts, application deployment, or administrative actions to correct issues.

## 3. Architecture

1. An endpoint enrolls in Intune.
2. Intune assigns policies according to user or device group membership.
3. The device evaluates supported compliance requirements.
4. The device reports results to Intune.
5. Intune presents policy and device compliance status.
6. Optionally, Microsoft Entra Conditional Access uses device compliance to control access to supported resources.

Conditional Access is a separate enforcement layer. A compliance policy alone does not automatically block Microsoft 365 access.

## 4. Licensing and prerequisites

Verify your actual tenant subscriptions before beginning.

Required for the core lab:
- An Intune subscription that covers the enrolled user/device.
- A supported enrolled test device.
- Appropriate Intune administrator permissions.
- A dedicated test user or device group.

Conditional Access enforcement requires Microsoft Entra ID P1/P2 or a suitable subscription bundle, according to Microsoft's licensing terms.

Custom compliance also requires a supported platform and discovery-script workflow. Check the current platform-specific documentation before deployment.

## 5. Built-in and custom compliance

Built-in compliance uses the settings exposed by Intune for the selected platform.

Custom compliance uses:
1. A discovery script that reports device state.
2. A JSON rules file defining acceptable values.
3. A custom compliance policy connecting the script and rules.
4. An assignment to the intended test group or devices.

The discovery script reports data; the JSON rules determine whether the reported values satisfy the custom compliance requirement.

## 6. Security principles

- Start with a dedicated test group.
- Avoid automatic wipe or retirement actions in a learning lab.
- Test discovery scripts locally before uploading them.
- Collect only the data required for compliance.
- Review false positives and false negatives.
- Test Conditional Access separately and narrowly.
- Document a rollback plan before assigning a new policy.

## Official references

- https://learn.microsoft.com/en-us/intune/device-security/compliance/create-policy
- https://learn.microsoft.com/en-us/intune/device-security/compliance/custom-settings
- https://learn.microsoft.com/en-us/intune/device-security/compliance/create-custom-script
- https://learn.microsoft.com/en-us/intune/device-security/compliance/create-custom-json
- https://learn.microsoft.com/en-us/intune/intune-service/protect/create-conditional-access-intune
