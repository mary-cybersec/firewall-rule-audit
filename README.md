# Firewall Rule Audit Script

This PowerShell project audits a Windows system’s inbound firewall rules and highlights risky configurations that could expose the device to external threats.

## What It Does

- Scans all **enabled inbound rules**
- Flags rules that:
  - Allow traffic from **any remote IP**
  - Use **commonly targeted ports** (e.g. RDP, SMB)
  - Are active and not restricted by profile

Outputs a timestamped `.csv` report listing:
- Rule name
- Protocol
- Port
- Remote address
- Detected risks

---

## How It Works

The script uses PowerShell cmdlets like:
- `Get-NetFirewallRule`
- `Get-NetFirewallPortFilter`
- `Get-NetFirewallAddressFilter`

It analyzes rules based on:
- Remote IP access (e.g. `Any`, `*`)
- Known attack surface ports: `3389`, `445`, `21`, etc.
- Whether the rule is active and direction is inbound

---

## How to Run

1. **Save the script** as `FirewallRuleAudit.ps1`
2. **Open PowerShell as Administrator**
3. Change directory:
   ```powershell
   cd "$env:USERPROFILE\Documents"
4. Run the script:
   ```powershell
   .\FirewallRuleAudit.ps1
5. Find the output CSV in your Documents folder

   Tools Used

 PowerShell (Windows built-in)
 CSV output for easy review
 Custom risk assessment logic










Why This Project Matters





Understanding and auditing firewall rules is a core blue team skill. This project demonstrates:



Scripting ability in PowerShell
Security-focused thinking
Hands-on analysis of real system configurations










Sample Output





Output file: FirewallAudit-YYYYMMDD-HHmm.csv

Sample fields:



RuleName: File and Printer Sharing (SMB-In)
LocalPort: 445
RemoteAddr: Any
RiskLevel: Open to all; Uses risky port 445










Security Note





The script is read-only and makes no changes to your system. It is intended for security auditing and educational purposes.
