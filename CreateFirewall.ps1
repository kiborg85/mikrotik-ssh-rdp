$login=api
$pass=ipa
$gw=(Get-WmiObject -Class Win32_IP4RouteTable | where { $_.destination -eq '0.0.0.0' -and $_.mask -eq '0.0.0.0'} | Sort-Object metric1 | select nexthop).nexthop
echo y | &("C:\plink.exe") -pw $pass $login$gw "/ip firewall mangle add chain=postrouting  protocol=tcp dst-port=3389 connection-state=new action=add-src-to-address-list address-list=RDP_brut1 address-list-timeout=5m"    
for ($i=20; $i -gt 0; $i--) {
    Write-Host $i
    echo y | &("C:\plink.exe") -pw $pass $login$gw "/ip firewall mangle add chain=postrouting  protocol=tcp dst-port=3389 connection-state=new src-address-list=RDP_brut$i action=add-src-to-address-list address-list=RDP_brut$($i+1) address-list-timeout=5m"
}
