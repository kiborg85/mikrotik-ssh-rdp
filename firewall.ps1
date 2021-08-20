#get-eventlog -LogName Security -after ((Get-date).AddDays(-1)) | Where-Object {$_.InstanceID -eq "4624" -and $_.ReplacementStrings[8] -eq "10"} |`
# select-object {$_.TimeGenerated;$_.ReplacementStrings[5];$_.ReplacementStrings[18]}
 $ip = get-eventlog -LogName Security -after ((get-date).AddMinutes(-2)) | Where-Object {$_.InstanceID -eq "4624" -and $_.ReplacementStrings[8] -eq "10"} | `
 select-object {$_.ReplacementStrings[18]} | select-object -first 1
 $ipadr = $ip.'$_.ReplacementStrings[18]'
 Write-Host $ipadr
echo y | &("C:\Windows\System32\plink.exe") -pw "ipa" api@10.20.36.1 "/ip firewall address-list add address=$ipadr list=RDP-white timeout=3000 comment=$env:COMPUTERNAME"