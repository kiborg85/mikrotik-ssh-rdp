$data = @(
'/ip firewall mangle add action=mark-connection chain=postrouting connection-state=new dst-port=3389 new-connection-mark=RDP_brut passthrough=yes protocol=tcp src-address-list=RDP_brut20'
'/ip firewall mangle add action=add-src-to-address-list address-list=RDP_black3 address-list-timeout=1d chain=postrouting connection-state=new dst-port=3389 protocol=tcp src-address-list=RDP_black2'
'/ip firewall mangle add action=add-src-to-address-list address-list=RDP_black2 address-list-timeout=15m chain=postrouting connection-mark=RDP_brut connection-state=new dst-port=3389 protocol=tcp src-address-list=RDP_black1'
'/ip firewall mangle add action=add-src-to-address-list address-list=RDP_black1 address-list-timeout=15m chain=postrouting connection-mark=RDP_brut connection-state=new dst-port=3389 protocol=tcp src-address-list=RDP_brut20'
'/ip firewall mangle add action=add-src-to-address-list address-list=RDP_brut21 address-list-timeout=5m chain=postrouting connection-state=new dst-port=3389 protocol=tcp src-address-list=RDP_brut20'
'/ip firewall mangle add action=add-src-to-address-list address-list=RDP_brut20 address-list-timeout=5m chain=postrouting connection-state=new dst-port=3389 protocol=tcp src-address-list=RDP_brut19'
'/ip firewall mangle add action=add-src-to-address-list address-list=RDP_brut19 address-list-timeout=5m chain=postrouting connection-state=new dst-port=3389 protocol=tcp src-address-list=RDP_brut18'
'/ip firewall mangle add action=add-src-to-address-list address-list=RDP_brut18 address-list-timeout=5m chain=postrouting connection-state=new dst-port=3389 protocol=tcp src-address-list=RDP_brut17'
'/ip firewall mangle add action=add-src-to-address-list address-list=RDP_brut17 address-list-timeout=5m chain=postrouting connection-state=new dst-port=3389 protocol=tcp src-address-list=RDP_brut16'
'/ip firewall mangle add action=add-src-to-address-list address-list=RDP_brut16 address-list-timeout=5m chain=postrouting connection-state=new dst-port=3389 protocol=tcp src-address-list=RDP_brut15'
'/ip firewall mangle add action=add-src-to-address-list address-list=RDP_brut15 address-list-timeout=5m chain=postrouting connection-state=new dst-port=3389 protocol=tcp src-address-list=RDP_brut14'
'/ip firewall mangle add action=add-src-to-address-list address-list=RDP_brut14 address-list-timeout=5m chain=postrouting connection-state=new dst-port=3389 protocol=tcp src-address-list=RDP_brut13'
'/ip firewall mangle add action=add-src-to-address-list address-list=RDP_brut13 address-list-timeout=5m chain=postrouting connection-state=new dst-port=3389 protocol=tcp src-address-list=RDP_brut12'
'/ip firewall mangle add action=add-src-to-address-list address-list=RDP_brut12 address-list-timeout=5m chain=postrouting connection-state=new dst-port=3389 protocol=tcp src-address-list=RDP_brut11'
'/ip firewall mangle add action=add-src-to-address-list address-list=RDP_brut11 address-list-timeout=5m chain=postrouting connection-state=new dst-port=3389 protocol=tcp src-address-list=RDP_brut10'
'/ip firewall mangle add action=add-src-to-address-list address-list=RDP_brut10 address-list-timeout=5m chain=postrouting connection-state=new dst-port=3389 protocol=tcp src-address-list=RDP_brut9'
'/ip firewall mangle add action=add-src-to-address-list address-list=RDP_brut9 address-list-timeout=5m chain=postrouting connection-state=new dst-port=3389 protocol=tcp src-address-list=RDP_brut8'
'/ip firewall mangle add action=add-src-to-address-list address-list=RDP_brut8 address-list-timeout=5m chain=postrouting connection-state=new dst-port=3389 protocol=tcp src-address-list=RDP_brut7'
'/ip firewall mangle add action=add-src-to-address-list address-list=RDP_brut7 address-list-timeout=5m chain=postrouting connection-state=new dst-port=3389 protocol=tcp src-address-list=RDP_brut6'
'/ip firewall mangle add action=add-src-to-address-list address-list=RDP_brut6 address-list-timeout=5m chain=postrouting connection-state=new dst-port=3389 protocol=tcp src-address-list=RDP_brut5'
'/ip firewall mangle add action=add-src-to-address-list address-list=RDP_brut5 address-list-timeout=5m chain=postrouting connection-state=new dst-port=3389 protocol=tcp src-address-list=RDP_brut4'
'/ip firewall mangle add action=add-src-to-address-list address-list=RDP_brut4 address-list-timeout=5m chain=postrouting connection-state=new dst-port=3389 protocol=tcp src-address-list=RDP_brut3'
'/ip firewall mangle add action=add-src-to-address-list address-list=RDP_brut3 address-list-timeout=5m chain=postrouting connection-state=new dst-port=3389 protocol=tcp src-address-list=RDP_brut2'
'/ip firewall mangle add action=add-src-to-address-list address-list=RDP_brut2 address-list-timeout=5m chain=postrouting connection-state=new dst-port=3389 protocol=tcp src-address-list=RDP_brut1'
'/ip firewall mangle add action=add-src-to-address-list address-list=RDP_brut1 address-list-timeout=5m chain=postrouting connection-state=new dst-port=3389 protocol=tcp'
'/ip firewall filter add action=accept chain=forward src-address-list=RDP-white'
'/ip firewall filter add action=drop chain=forward src-address-list=RDP_black3'
'/ip firewall filter add action=drop chain=forward src-address-list=RDP_brut21'
)

$login='api'
$pass='ipa'
$gw=(Get-WmiObject -Class Win32_IP4RouteTable | where { $_.destination -eq '0.0.0.0' -and $_.mask -eq '0.0.0.0'} | Sort-Object metric1 | select nexthop).nexthop
foreach ($d in $data) {
    Write-Host $i
    echo y | &("C:\plink.exe") -pw $pass $login@$gw "$d"
}
