# FirewallRuleAudit.ps1
# Audits firewall rules for risky configurations

$report = @()

# Common attack ports to flag
$riskyPorts = @(3389, 445, 21, 22, 23)

# Get all firewall rules
$rules = Get-NetFirewallRule -Enabled True | Where-Object { $_.Direction -eq 'Inbound' }

foreach ($rule in $rules) {
    $details = Get-NetFirewallPortFilter -AssociatedNetFirewallRule $rule
    $addresses = Get-NetFirewallAddressFilter -AssociatedNetFirewallRule $rule

    foreach ($port in $details) {
        foreach ($addr in $addresses) {
            $entry = [PSCustomObject]@{
                RuleName     = $rule.DisplayName
                Action       = $rule.Action
                Protocol     = $port.Protocol
                LocalPort    = $port.LocalPort
                RemoteAddr   = $addr.RemoteAddress
                Profile      = $rule.Profile
                RiskLevel    = ""
            }

            # Risk assessment
            if ($addr.RemoteAddress -eq "Any" -or $addr.RemoteAddress -eq "*") {
                $entry.RiskLevel += "Open to all; "
            }

            if ($riskyPorts -contains $port.LocalPort) {
                $entry.RiskLevel += "Uses risky port $($port.LocalPort); "
            }

            if ($entry.RiskLevel -ne "") {
                $report += $entry
            }
        }
    }
}

# Output to CSV
$timestamp = Get-Date -Format "yyyyMMdd-HHmm"
$reportPath = "$env:USERPROFILE\Documents\FirewallAudit-$timestamp.csv"
$report | Export-Csv -NoTypeInformation -Path $reportPath

Write-Output "Firewall audit completed. Report saved to $reportPath"