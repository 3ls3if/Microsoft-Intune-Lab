# Endpoint Security Reports

Store sanitized lab reports here.

Suggested report fields:
- Collection timestamp
- Lab device name or pseudonymous identifier
- Windows edition and build
- Defender Antivirus status
- Firewall profile status
- BitLocker volume status
- ASR rule identifiers and action values
- Intune policy result
- Troubleshooting notes

The PowerShell audit script writes JSON reports locally to the Windows device.
Copy only sanitized reports into this repository.

Never commit:
- BitLocker recovery keys
- Passwords or access tokens
- Personal data not required for the exercise
- Unredacted production-device inventory
- Sensitive security investigation data
