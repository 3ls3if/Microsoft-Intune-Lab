# Chapter 10 — Endpoint Security Policies

## Objectives
- Understand Intune endpoint security architecture.
- Configure Defender Antivirus and Windows Firewall.
- Understand BitLocker policy deployment and recovery.
- Test ASR policies in Audit mode before considering Block mode.
- Validate local state and troubleshoot policy conflicts.

## Prerequisites
- Eligible Microsoft Intune subscription.
- Enrolled, supported Windows test device.
- Appropriate Intune RBAC permissions.
- Dedicated lab assignment group.
- Safe access to the device if a firewall policy affects connectivity.
- Verified BitLocker recovery-key escrow before encryption testing.
- Defender Antivirus as the primary antivirus for applicable ASR policies.

## Lab policy names
- ES-10-WIN-Defender-Antivirus-Lab
- ES-10-WIN-Firewall-Lab
- ES-10-WIN-BitLocker-Lab
- ES-10-WIN-ASR-Audit-Lab

## Contents
- `01-Endpoint-Security-Fundamentals.md`
- `02-Defender-Antivirus-Lab.md`
- `03-Windows-Firewall-Lab.md`
- `04-BitLocker-Lab.md`
- `05-ASR-Policies-Lab.md`
- `06-Validation-Troubleshooting-and-Rollback.md`
- `07-Exercises-and-Review.md`
- `scripts/Get-EndpointSecurityState.ps1`
- `config/endpoint-security-lab.json`
- `reports/README.md`
- `evidence/README.md`

## Safety
Use a disposable test device and a dedicated group. Do not configure automatic
wipe or retirement actions for this lab. Do not test firewall lock-down over
a single remote management path without console or out-of-band access.

Verify BitLocker recovery-key escrow before enabling encryption. Start ASR
in Audit mode and investigate application impact before enforcing Block mode.

## Official documentation
- https://learn.microsoft.com/en-us/intune/intune-service/protect/endpoint-security-policy
- https://learn.microsoft.com/en-us/intune/device-configuration/endpoint-security/antivirus
- https://learn.microsoft.com/en-us/intune/device-configuration/endpoint-security/disk-encryption
- https://learn.microsoft.com/en-us/intune/protect/endpoint-security-asr-policy
- https://learn.microsoft.com/en-us/intune/device-security/overview
