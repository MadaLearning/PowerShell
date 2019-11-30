#Be sure that you in the following Windows Server 2016 DVD path (PS f:\NanoServer> )

Import-Module .\NanoServerImageGenerator -Verbose

New-NanoServerImage -Edition Standard -DeploymentType guest -MediaPath F:\ -TargetPath c:\temp\nano-01.vhdx -ComputerName nano-01 -DomainName matrix.local

#OR

New-NanoServerImage -Edition Standard -DeploymentType guest -MediaPath F:\ -TargetPath c:\temp\nano-01.vhdx -ComputerName nano-01 -DomainName matrix.local -InterfaceNameorIndex Etherner -ipv4address 10.10.1.140 -ipv4subnetmask 255.255.255.0 -ipv4gateway 10.10.1.100 -ipv4dns 10.10.1.200

New-VM -Name nano-01 -Generation 2 -MemoryStartupBytes 1gb -VhdPath c:\temp\nano-01.vhdx
==============================================================================================
#Add Package to Nano Server

Edit-NanoServerImage -BasePath c:\nanoserver -TargetPath c:\temp\nano-01.vhdx -Package microsoft-nanoserver-iis-package
==================================================================================================
#Create PowerShell Session

New-PSSession -ComputerName nano-01 -Credential matrix\administrator

Enter-PSSession 3 (Session ID)