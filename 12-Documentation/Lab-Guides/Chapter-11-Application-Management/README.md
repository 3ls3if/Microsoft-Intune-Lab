# Chapter 11 — Application Management

## Learning objectives
- Understand Intune application management architecture.
- Deploy Win32 applications.
- Deploy Microsoft Store applications.
- Deploy Microsoft 365 Apps.
- Configure requirements and detection rules.
- Understand dependencies and supersedence.
- Monitor, troubleshoot, and roll back deployments.

## Prerequisites
- Microsoft Intune tenant and appropriate licenses.
- Supported, enrolled Windows test device.
- Microsoft Entra security groups.
- Windows packaging machine.
- Microsoft Win32 Content Prep Tool.
- Legitimate test MSI installer.

## Lab application names
- APP-11-WIN-ContosoApp
- APP-11-WIN-StoreApp
- APP-11-WIN-Microsoft365

## Lessons
1. Application Management Fundamentals
2. Win32 App Deployment Lab
3. Microsoft Store App Deployment
4. Microsoft 365 Apps Deployment
5. App Dependencies and Supersedence
6. Application Validation and Troubleshooting
7. Security, Rollback and Exercises

## Scripts
- scripts/Get-InstalledApplications.ps1

## Configuration
- config/application-management-lab.json

## Safety
Use a dedicated test group and test device. Validate installer
signatures, silent installation, detection rules, and uninstall
behavior before production deployment.

Do not commit software installers, license keys, credentials,
or sensitive deployment evidence.
