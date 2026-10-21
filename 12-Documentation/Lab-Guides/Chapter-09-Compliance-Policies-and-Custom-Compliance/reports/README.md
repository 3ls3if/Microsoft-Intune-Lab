# Reports

Store sanitized compliance exports and lab results here.

Recommended fields:
- Timestamp
- Device identifier (use a lab identifier where possible)
- Policy name
- Policy status
- Noncompliant setting
- Error code, if any
- Remediation performed
- Retest result

Do not commit access tokens, passwords, personal data, or unredacted
production-device exports. Generated reports should be treated as evidence,
not as a substitute for checking the current Intune portal state.
