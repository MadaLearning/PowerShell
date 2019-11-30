# Install the DHCP server role

Add-WindowsFeature DHCP -IncludeManagementTools

====================================================
# Authorize the DHCP server

Add-DhcpServerInDC -DnsName lon-svr2.contoso.com

=====================================================
# Create a DHCP IPv4 scope

Add-DhcpServerv4Scope -Name "London" -StartRange 172.16.0.1 -EndRange 172.16.0.254 -SubnetMask 255.255.255.0

==============================================================================================================
# Create a Superscope

Add-DhcpServerv4Superscope -SuperscopeName "London" -ScopeId 172.16.8.0,172.16.16.0

====================================================================================
# Create a Multicast Scope

Add-DhcpServerv4MulticastScope -ComputerName "lon-svr2.Contoso.com" -Name "London WDS multicast scope" -StartRange 224.0.0.1 -EndRange 224.0.1.254

======================================================================================================================================================
# Configure a DHCP reservation

Add-DhcpServerv4Reservation -ScopeId 172.16.8.0 -IPAddress 172.16.8.22 -ClientId 02-60-8C-00-7A-5E -Description "LON-SVR3"

================================================================================================================================
# Configure DHCP Server Options

Set-DhcpServerv4OptionValue -ComputerName LON-SVR2.contoso.com -DnsServer 172.16.0.10 -DnsDomain contoso.com -Router 172.16.0.1

======================================================================================================================================
# Configure DHCP Scope Options

Set-DhcpServerv4OptionValue -ComputerName LON-SVR2.contoso.com -ScopeId 172.16.8.0 -DnsServer 172.16.0.10 -DnsDomain contoso.com -Router 172.16.0.1

=====================================================================================================================================================
# create a DHCP IPv6 scope

Add-DhcpServerv6Scope -Prefix 2001:DB5:0:2A4C:: -Name "LondonScope"

=============================================================================
# Add Option 60 in the DHCP

Add-DhcpServerv4OptionDefinition -ComputerName MyDHCPServer -Name PXEClient -Description "PXE Support" -OptionId 060 -Type String

#And to set the Option value for a scope:

Set-DhcpServerv4OptionValue -ComputerName MyDHCPServer -ScopeId "MyScope" -OptionId 060 -Value "PXEClient"

=====================================================================================================================================
# Perform export and import of a DHCP server

Export-DhcpServer –ComputerName lon-svr2 -Leases -File C:\lon-svr2_export.xml -verbose

Import-DhcpServer –ComputerName LON-SVR3 -Leases –File C:\lon-svr2_export.xml -BackupPath "C:\dhcpbackup\" -Verbose

=================================================================================================================
# Configure DHCP failover

Add-DhcpServerv4Failover -ComputerName lon-svr2.adatum.com -Name SFO-SIN-Failover -PartnerServer lon-svr3.adatum.com -ScopeId 172.16.0.0 -SharedSecret "Pa$$w0rd"