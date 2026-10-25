# 07 — Exercises and Review

## Exercise 1 — Defender Antivirus
- [ ] Record the initial Defender state.
- [ ] Create and assign the Antivirus policy.
- [ ] Verify the effective state using Get-MpComputerStatus.
- [ ] Compare the local state with Intune's policy status.

## Exercise 2 — Windows Firewall
- [ ] Record all firewall profile states.
- [ ] Create and assign the Firewall policy.
- [ ] Verify profile state using Get-NetFirewallProfile.
- [ ] Explain how you would recover if a firewall change blocked RDP.

## Exercise 3 — BitLocker
- [ ] Check TPM and BitLocker readiness.
- [ ] Verify recovery-key escrow through the approved management workflow.
- [ ] Configure the disk encryption policy for the lab device.
- [ ] Record volume and protection status.
- [ ] Explain why deleting a policy is not the same as decrypting a volume.

## Exercise 4 — Attack Surface Reduction
- [ ] Confirm Defender Antivirus is the primary provider.
- [ ] Configure one supported ASR rule in Audit mode.
- [ ] Inspect the effective rule state.
- [ ] Review available audit evidence.
- [ ] Document the checks required before changing to Block mode.

## Exercise 5 — Troubleshooting
- [ ] Identify a policy conflict or simulate a configuration issue safely.
- [ ] Find the policy and setting involved.
- [ ] Record the root cause.
- [ ] Correct the assignment or conflicting configuration.
- [ ] Validate the final state.

## Review questions

1. When should you use an endpoint security policy instead of a security baseline?
2. Why can multiple policies managing the same setting cause conflicts?
3. What is the difference between Defender being installed and real-time protection being active?
4. Why should firewall changes be tested with out-of-band access available?
5. Why must BitLocker recovery-key escrow be verified?
6. Why should ASR rules generally be audited before blocking?
7. What can a local PowerShell report prove, and what must still be verified in Intune?
8. How does device compliance differ from configuring a security control?

## Acceptance criteria

- All four security areas have been reviewed.
- At least one policy has been deployed and validated on a lab device.
- Local evidence has been compared with Intune status.
- Conflicts and troubleshooting results have been documented.
- Rollback has been planned and verified where changes were made.
- Sensitive data has been removed from repository evidence.

## Official references

- https://learn.microsoft.com/en-us/intune/intune-service/protect/endpoint-security-policy
- https://learn.microsoft.com/en-us/intune/device-configuration/endpoint-security/antivirus
- https://learn.microsoft.com/en-us/intune/device-configuration/endpoint-security/disk-encryption
- https://learn.microsoft.com/en-us/intune/protect/endpoint-security-asr-policy
