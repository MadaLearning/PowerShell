Enter-PSSession -VMName server09 -Credential matrix\administrator

Invoke-Command -VMName server09 -ScriptBlock {Get-VM} -Credential matrix\administrator

New-PSSession -VMName server09 -Credential matrix\administrator

Copy-Item -ToSession (Get-PSSession) -Path F:\song.mp3 -Destination C:\Users   #copy from Host to vm

==============================================================================================
#Configure Nested Virtualization

Get-VM

Get-VMProcessor -VMName NanoHyper-V | FL *

Set-VMProcessor -VMName NanoHyper-V -ExposeVirtualizationExtensions $true

#Example

Set-VMMemory -VMName "Windows 10 Enterprise" -DynamicMemoryEnabled $false

Set-VMProcessor -VMName "Windows 10 Enterprise" -Count 2

Get-VMNetworkAdapter -VMName "Windows 10 Enterprise" | Set-VMNetworkAdapter -MacAddressSpoofing On

Set-VMProcessor -VMName "Windows 10 Enterprise" -ExposeVirtualizationExtensions $true

=============================================================================================================
#VM Resource Metering

Enable-VMResourceMetering -VMName server-09

Measure-VM server-09

Measure-VM server-09 | Format-List

Reset-VMResourceMetering -VMName server-09

Disable-VMResourceMetering -VMName server-09
===================================================================================================================
#Create VHD

New-VHD -Path 'e:\temp\disk1.vhdx' -Dynamic -SizeBytes 5gb  -LogicalSectorSizeBytes 4096

Mount-VHD -Path 'e:\temp\disk1.vhdx'

Dismount-VHD -Path 'e:\temp\disk1.vhdx'

Install-WindowsFeature -Vhd 'e:\temp\disk1.vhdx' -Name web-server -IncludeManagementTools
============================================================================================
#Pass-Through Disks

Get-Disk 

Set-Disk -Number 2 -IsOffline $true

Add-VMHardDiskDrive -VMName server-13 -ControllerType SCSI -DiskNumber 2
===============================================================================================================================
#Create vmDisk for Linux

New-VHD -Path 'E:\Virtual Machines\Hyper-V\Virtual Hard Disks\Kali-2018.1.vhdx' -SizeBytes 60gb -Dynamic -BlockSizeBytes 1mb

====================================================================================================================================
#Secure Boot

Set-VMFirmware -VMName server-09 -EnableSecureBoot Off

Set-VMFirmware -VMName ubuntu-04 -SecureBootTemplate microsoftueficertificateauthority

======================================================================================================
#Upgrade Hyper-V Version

Get-VM

Get-VMHostSupportedVersion

Update-VMVersion -VM serverb

======================================================================================
#Export & Import VM

Export-VM nano-01, nano-02 -Path E:\Export

Import-VM -Path 'E:\Export\nano-01\Virtual Machines\0B57F760-389A-4146-B18D-60B3C0A50BB1.vmcx'

=========================================================================================================
#DDA Configuration

Get-PnpDevice -PresentOnly

Get-PnpDevice -FriendlyName e*

Get-PnpDevice -FriendlyName e* | Format-List

Get-PnpDeviceProperty -InstanceId root\elxplus\0000

Get-PnpDeviceProperty -InstanceId root\elxplus\0000 | Format-List
======================================================================================================
#Checkpoint

Checkpoint-VM server-11

Get-VMCheckpoint -VMName server-11

Restore-VMCheckpoint -Name -VMName server-11

=================================================================================================================================
#Hyper-V Network

Add-VMNetworkAdapter -VMName server-11 -SwitchName private

Get-NetAdapterVmq
======================================================================

#Turn hypervisor on and off

bcdedit /set hypervisorlaunchtype off

bcdedit /set hypervisorlaunchtype auto

