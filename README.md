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
