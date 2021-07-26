# Enable Hyper-V
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V -All

# Environment Variable
[Environment]::SetEnvironmentVariable("[VAGRANT_DEFAULT_PROVIDER]","[hyperv]","User")
$env:VAGRANT_DEFAULT_PROVIDER = 'hyperv'

# Create a NAT switch
New-VMSwitch –SwitchName "NATSwitch" –SwitchType Internal
New-NetIPAddress –IPAddress 172.21.21.1 -PrefixLength 24 -InterfaceAlias "vEthernet (NATSwitch)"
New-NetNat –Name VagrantNATnetwork –InternalIPInterfaceAddressPrefix 172.21.21.0/24

# Forwarding Default Switch to WSL2
Get-NetIPInterface | where {$_.InterfaceAlias -eq 'vEthernet (WSL)' -or $_.InterfaceAlias -eq 'vEthernet (Default Switch)'} | Set-NetIPInterface -Forwarding Enabled