# Set some variables
$VMName = "OSD-1607-TP-PC0001"
$IPAddress = "192.168.1.17"
$DHCPDescription = "TP Clients"
$DHCPServer = "DC01"
$DHCPScopeID = "192.168.0.0"
$Username = 'VIAMONSTRA\Administrator'
$Password = 'P@ssw0rd'
 
# Get the Mac Address from a VM and format it (add - in between the pairs of hexadecimal digits)
$Mac = (Get-VMNetworkAdapter -VMName $VMName ).MacAddress
$Mac = $Mac -replace '..(?!$)', '$&-'
 
# Print the Mac Address
# Write-Output $Mac
 
# Set credentials and allow remote administration via PowerShell to all hosts
winrm set winrm/config/client '@{TrustedHosts="*"}' | Out-Null
$pass = ConvertTo-SecureString -AsPlainText $Password -Force
$Cred = New-Object System.Management.Automation.PSCredential -ArgumentList $Username,$pass
 
# Connect to the DCHP Server and add the reservation
Invoke-Command -ComputerName $DHCPServer -Credential $Cred -ScriptBlock {
    param($DHCPScopeID, $DHCPServer, $Mac, $IPAddress, $DHCPDescription, $VMName)
    Add-DhcpServerv4Reservation -ScopeId $DHCPScopeID -ComputerName "$DHCPServer" -ClientId $Mac -IPAddress $IPAddress -Description $DHCPDescription -Name $VMName
} -ArgumentList ($DHCPScopeID, $DHCPServer, $Mac, $IPAddress, $DHCPDescription, $VMName)