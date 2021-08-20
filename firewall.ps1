$login=api
$pass=ipa
 $ip = get-eventlog -LogName Security -after ((get-date).AddMinutes(-2)) | Where-Object {$_.InstanceID -eq "4624" -and $_.ReplacementStrings[8] -eq "10"} | select-object {$_.ReplacementStrings[18]} | select-object -first 1
 $ipadr = $ip.'$_.ReplacementStrings[18]'
 Write-Host $ipadr
 $gw=(Get-WmiObject -Class Win32_IP4RouteTable | where { $_.destination -eq '0.0.0.0' -and $_.mask -eq '0.0.0.0'} | Sort-Object metric1 | select nexthop).nexthop
echo y | &("C:\Windows\System32\plink.exe") -pw $pass $login$gw "/ip firewall address-list add address=$ipadr list=RDP-white timeout=3000 comment=$env:COMPUTERNAME"
