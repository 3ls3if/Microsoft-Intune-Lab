# 02 — Built-in Compliance Policy Lab

## Objective

Create a Windows compliance policy, assign it to a lab group, and validate the device's compliance state.

## Prerequisites

- Intune admin center access.
- A Windows device enrolled in Intune.
- A dedicated test group.
- Permissions to create compliance policies and assign them.

## Step 1 — Create a test group

In Microsoft Entra admin center:

1. Open Groups.
2. Create a security group named `SG-Intune-Compliance-Lab`.
3. Add only the intended lab user or device, according to your assignment design.
4. Verify that production devices and users are excluded.

## Step 2 — Create the compliance policy

1. Open https://intune.microsoft.com/.
2. Navigate to Devices > Compliance.
3. Select Create policy.
4. Select Windows 10 and later.
5. Name the policy `CMP-09-WIN-Baseline-Lab`.
6. Add a description explaining that this is a test policy.
7. Configure supported settings, for example:
   - Minimum operating system version.
   - Firewall requirement, if available.
   - Antivirus or encryption requirements supported by the platform.
8. Configure conservative actions for noncompliance.
9. Do not configure automatic wipe or retirement.
10. Assign the policy to `SG-Intune-Compliance-Lab`.
11. Review and create.

Select requirements that your test device can realistically satisfy. Do not blindly copy production requirements into the lab.

## Step 3 — Trigger synchronization

On the test device:

1. Open Settings.
2. Navigate to Accounts > Access work or school.
3. Select the connected work account.
4. Open Info, if available.
5. Select Sync.

The exact Windows interface may differ by version and enrollment method. You can also use Company Portal to initiate a sync when supported.

## Step 4 — Validate

In Intune:

1. Open Devices and select the test device.
2. Inspect its compliance status.
3. Open the compliance policy's device status view.
4. Inspect per-setting details.
5. Record the result and timestamp.

New assignments may take time to evaluate. Do not interpret a pending or unknown state as proof that the device is compliant.

## Step 5 — Test a controlled failure

Use a disposable test device and a reversible setting that you can safely change.

1. Record the original setting.
2. Change the setting so that it violates the test policy.
3. Synchronize the device and allow evaluation time.
4. Record the reported result.
5. Restore the original setting.
6. Synchronize again and verify the result recovers.

Do not disable essential protection on a production device to create a demonstration.

## Evidence checklist

- [ ] Policy name and settings.
- [ ] Assignment group.
- [ ] Test device and OS version.
- [ ] Initial compliance status.
- [ ] Per-setting result.
- [ ] Controlled failure result, if tested.
- [ ] Restored state and final result.

## Troubleshooting

If the policy is not visible or does not evaluate:
- Verify the platform and assignment.
- Verify the device is enrolled and checking in.
- Confirm the test user/device belongs to the targeted group.
- Check for conflicting or overlapping policies.
- Allow time for evaluation and reporting.

## Official reference

https://learn.microsoft.com/en-us/intune/device-security/compliance/create-policy
