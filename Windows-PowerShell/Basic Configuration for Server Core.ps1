#Set Computer management  (Server 2012 & 2016)

Set-NetFirewallRule -DisplayGroup "remote event log management" -Enabled True -PassThru

Set-NetFirewallRule -DisplayGroup "remote volume management" -Enabled true -PassThru

#Note: (You must enable this in remote computer and computer you sitting it)
==================================================================================================
#Basic Configuration on ServerCore using PowerShell

#Set Network Adapter

Get-NetIPInterface

New-NetIPAddress -InterfaceIndex 14 -IPAddress 10.10.1.201 -PrefixLength 24 -DefaultGateway 10.10.1.100

Set-DnsClientServerAddress -InterfaceIndex 14 -ServerAddresses 10.10.1.200,10.10.1.201
====================================================================================================
#Rename Computer & Join to domain

Add-Computer -DomainName matrix.local -NewName server-04 -Credential matrix\administrator -Restart -PassThru -Verbose

#Rename Computer only

Rename-Computer -NewName DC02

#Set time zone 

control timedate.cpl
========================================================================================================
#Create PowerShell Session

New-PSSession -ComputerName server01 -Credential matrix\administrator

Enter-PSSession 3 (Session ID)
=====================================================================================================
#Enable Remote Management

Configure-SMRemoting.exe -enable

Enable-PSRemoting
=========================================================================================================
#WinRM Negotiate Authentication Error (Client in WORKGROUP)

Get-Item WSMan:\localhost\Client\TrustedHosts | select name,value | format-list

Set-Item wsman:\localhost\Client\TrustedHosts "DC02" -Concatenate -Force

cmdkey /add:DC02 /user:administrator@matrix.local /pass:P@ssw0rd

Clear-Item WSMan:\localhost\Client\TrustedHosts        # (Clear All Hosts)

