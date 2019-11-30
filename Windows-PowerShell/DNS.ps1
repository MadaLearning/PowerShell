# Installing DNS

Add-WindowsFeature DNS -IncludeManagementTools

=======================================================

# Install the DNS server role on Nano Server

Enable-WindowsOptionalFeature -Online -FeatureName DNS-Server-Full-Role

==========================================================================

# Recursion Scopes 


#Disable recursion for the default recursion scope

Set-DnsServerRecursionScope -Name . -EnableRecursion $False

#creates a new recursion scope called (InternalAdatumClients)

Add-DnsServerRecursionScope -Name "InternalAdatumClients" -EnableRecursion $True

#Define which clients are part of the recursion scope

Add-DnsServerQueryResolutionPolicy -Name "RecursionControlPolicy" -Action ALLOW -ApplyOnRecursion -RecursionScope "InternalAdatumClients" -ServerInterfaceIP "EQ,10.24.60.254"

=================================================================================================================================================================================

# Implement DNS policies

#create a subnet for DNS clients in New York

Add-DnsServerClientSubnet -Name "NYCSubnet" -IPv4Subnet "172.16.0.0/24"

#create a DNS zone scope for New York DNS clients

Add-DnsServerZoneScope -ZoneName "Adatum.com" -Name "NYCZoneScope"

#create a specific IP address record for clients in the New York City zone scope

Add-DnsServerResourceRecord -ZoneName "Adatum.com" -A -Name "www" -IPv4Address "172.16.0.41" -ZoneScope "NYCZoneScope"

#create the policy that instructs the DNS server to respond based upon the previously defined factors

Add-DnsServerQueryResolutionPolicy -Name "NYCPolicy" -Action ALLOW -ClientSubnet "eq,NYCSubnet" -ZoneScope "NYCZoneScope,1" -ZoneName "Adatum.com"

=========================================================================================================================================================

# Add a primary zone

Add-DnsServerPrimaryZone -Name "Contoso.com" -ZoneFile "Contoso.com.dns" -DynamicUpdate None

#change the Contoso.com Primary Zone Dynamic Update settings

Set-DnsServerPrimaryZone -Name "Contoso.com" -DynamicUpdate "NonsecureAndSecure"

# Create a secondary zone

Add-DnsServerSecondaryZone -Name "Adatum.com" -ZoneFile "Adatum.com.dns" -MasterServers 172.16.0.10

# Create an AD DS-integrated primary zone

Add-DnsServerPrimaryZone -Name "Contoso.com" -ReplicationScope "Domain"

# Configure secure dynamic updates

Set-DnsServerPrimaryZone -Name "Contoso.com" -DynamicUpdate "Secure"

# Create and configure stub zones

Add-DnsServerStubZone -Name "Contoso.com" -MasterServers "172.16.0.66" -ZoneFile "Contoso.dns"

# Configure a GlobalNames zone

Set-DnsServerGlobalNameZone –AlwaysQueryServer $true

Add-DnsServerPrimaryZone –Name GlobalNames –ReplicationScope Forest


============================================================================================

# Configure delegation

#creates the sales.adatum.com delegated zone in the existing Adatum.com zone

Add-DnsServerZoneDelegation -Name "Adatum.com" -ChildZoneName "Sales" -NameServer "ns1.Sales.Adatum.com" -IPAddress 172.16.0.136

=====================================================================================================================================

# create resource records

Add-DnsServerResourceRecord -ZoneName "Contoso.com" -A -Name "lon-svr2" -AllowUpdateAny -IPv4Address "172.16.0.27" -TimeToLive 01:00:00 -AgeRecord

=======================================================================================================================================================

# Configuring zone aging and scavenging

Set-DnsServerZoneAging Contoso.com -Aging $True -ScavengeServers 172.16.0.10

#Enable DNS server aging/scavenging

Set-DnsServerScavenging -RefreshInterval 7.00:00:00

=======================================================================

# Configuring zone scopes

#create subnet for DNS clients in New York and another for clients in London

Add-DnsServerClientSubnet -Name "NYCSubnet" -IPv4Subnet "172.16.0.0/24"
Add-DnsServerClientSubnet -Name "LONSubnet" -IPv4Subnet "172.16.1.0/24"

#create the DNS zone scopes for New York and London DNS clients

Add-DnsServerZoneScope -ZoneName "Adatum.com" -Name "NYCZoneScope"
Add-DnsServerZoneScope -ZoneName "Adatum.com" -Name "LONZoneScope"

#Configuring records in zone scopes

Add-DnsServerResourceRecord -ZoneName "Adatum.com" -A -Name "www" -IPv4Address "172.16.0.41" -ZoneScope "NYCZoneScope"
Add-DnsServerResourceRecord -ZoneName "Adatum.com" -A -Name "www" -IPv4Address "172.16.1.22" -ZoneScope "LONZoneScope"

#Configuring policies for zones

Add-DnsServerQueryResolutionPolicy -Name "NYCPolicy" -Action ALLOW -ClientSubnet "eq,NYCSubnet" -ZoneScope "NYCZoneScope,1" -ZoneName "Adatum.com"
Add-DnsServerQueryResolutionPolicy -Name "LONPolicy" -Action ALLOW -ClientSubnet "eq,LONSubnet" -ZoneScope "LONZoneScope,1" -ZoneName "Adatum.com"

=========================================================================================================================================================

# Analyze zone level statistics

Get-DnsServerStatistics -ZoneName "Adatum.com"