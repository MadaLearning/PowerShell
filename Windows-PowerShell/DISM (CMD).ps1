#Mount Image

Dism /Get-ImageInfo /ImageFile:C:\images\install.wim

Dism /Mount-Image /ImageFile:C:\images\install.wim /index:1 /MountDir:C:\mount

#Add Drivers

Dism /Image:C:\mount /Add-Driver /Driver:C:\drivers\mydriver.inf #Single

Dism /Image:C:\mount /Add-Driver /Driver:C:\drivers /Recurse  #Multiple

Dism /Image:C:\mount /Get-Drivers

#Add Packages

Dism /Image:C:\mount /Add-Package /PackagePath:C:\Updates.msu (or *.cab)

#Enable or Disable Windows Features

Dism /Image:C:\mount /Get-Features

Dism /Image:C:\mount /Enable-Feature /FeatureName:TFTP /All 

Dism /Image:C:\mount /Disable-Feature /FeatureName:TFTP

Dism /online /Get-FeatureInfo /FeatureName:TFTP

#Unmount Image

Dism /Unmount-Image /MountDir:C:\mount /Commit