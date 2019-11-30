New-SmbShare -Name edrive2 -Path e:\ -FullAccess everyone

Get-SmbSession

Get-SmbSession | Close-SmbSession

Get-SmbOpenFile

Get-SmbOpenFile | Close-SmbOpenFile

Remove-SmbShare -Name edrive

==============================================
Get-SmbServerConfiguration

Get-SmbClientConfiguration