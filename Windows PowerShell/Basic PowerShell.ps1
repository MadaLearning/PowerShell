Get-Help

Get-Alias
=========================
Get-Command
gcm

gcm *eventlog

Get-EventLog -LogName *

Help Get-EventLog -Full
==============================
Get-Service
gsv
==============================
Show-Command Get-Service
================================
Stop-Process -Name BITS -WhatIf

Stop-Process -Name * -Confirm

$ConfirmPreference = "Low"

Start-Service -Name BITS 

Start-Service -Name BITS -Confirm ="High"

$ConfirmPreference ="High"
===========================================
#Which command displays a list of Windows Firewall rules? What parameter of that command would display only enabled rules?

1-Run: 
help *firewall*
or 
Get-Command *firewall*
or
man *firewall* 

2-These display a list of commands that use those keywords in their names.
 
   This should lead you to the Get-NetFirewallRule command.
****************************************************************************
#Which native Windows PowerShell command formats a new disk volume?


1. Run: 

help *format*
or 
Get-Command -Verb Format 
or
man *format*

These display a list of commands. This should lead you to the Format-Volume command.
****************************************************************************************
#Use Get-FirewallRules to display a list of enabled Windows Firewall rules.

To display a list of enabled firewall rules, run:
 
Get-NetFirewallRule -Enabled True
*********************************************************
#Use Get-NetIPAddress to display a list of all local IPv4 addresses.

To display a list of all local IPv4 addresses, run: 

Get-NetIPAddress –AddressFamily IPv4
*********************************************************
#Use Set-Service to configure the BITS service to start automatically.

To set the startup type of the BITS service, run:
 
Set-Service –Name BITS –StartupType Automatic 
*********************************************************
#Use Get-EventLog to display the 10 most recent local Security event log entries. 
#Note that you may not have privleges to retrieve the entries, but the command should run without error.

To display the newest 10 entries from the Security event log, run: 

Get-EventLog –LogName Security –Newest 10 
=================================================================================================================