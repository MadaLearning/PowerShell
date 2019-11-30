Get-PhysicalDisk | ft FriendlyName,CanPool,Size,MediaType

Get-PhysicalDisk | where size -EQ 5368709120 | Set-PhysicalDisk -MediaType SSD

Get-PhysicalDisk | Where Size -EQ 7516192768 | Set-PhysicalDisk -MediaType HDD

#To Convert GB to byte (https://www.convertunits.com/from/GB/to/byte)