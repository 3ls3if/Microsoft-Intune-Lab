
# Chapter 01 — Microsoft Intune Fundamentals

## Objective

Understand Microsoft Intune architecture, device and application
management, licensing prerequisites, and the relationship between
Intune and Microsoft Entra ID.

## Learning Outcomes

- Explain the purpose of Microsoft Intune.
- Differentiate MDM and MAM.
- Understand tenants, enrollment, assignments, and compliance.
- Identify key Intune architecture components.
- Review tenant configuration safely.
- Use Microsoft Graph PowerShell for read-only inspection.

## Architecture

Microsoft Intune is a cloud-based endpoint management service.
Microsoft Entra ID provides identity, authentication, groups, and
integration with Conditional Access.

Intune manages supported devices and applications through policies,
assignments, enrollment workflows, and management actions.

## Practical Labs

### Lab 01A — Tenant Discovery

1. Open the Intune admin center.
2. Review tenant status and available licensing.
3. Inspect device management, compliance, apps, and endpoint security.
4. Record observations in `tenant-baseline.md`.
5. Do not modify production policies.

### Lab 01B — Microsoft Graph

1. Install the Microsoft Graph Authentication module.
2. Authenticate with delegated read permissions.
3. Inspect the Graph connection context.
4. Retrieve organization information.
5. Query managed-device inventory.
6. Disconnect from Graph.

## Validation

- [ ] Intune admin center access verified.
- [ ] Tenant and licensing details reviewed.
- [ ] Core management sections inspected.
- [ ] Graph authentication tested, if available.
- [ ] Read-only device query tested, if available.
- [ ] Sensitive information excluded from documentation.

## Security

- Use least-privileged access.
- Protect credentials and tokens.
- Redact tenant-specific information.
- Use a dedicated lab tenant for future configuration changes.

## References

- https://learn.microsoft.com/en-us/intune/
- https://learn.microsoft.com/en-us/intune/fundamentals/licensing
- https://learn.microsoft.com/en-us/intune/endpoint-manager-overview
- https://learn.microsoft.com/en-us/graph/

## Completion Criteria

The chapter is complete when the learner can explain the core
architecture, identify relevant prerequisites, document the tenant
baseline, and perform the optional read-only Graph exercise.
