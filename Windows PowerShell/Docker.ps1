Install-Module -Name dockermsftprovider -Repository psgallery -Force

Install-Package -Name docker -ProviderName dockermsftprovider 

Restart-Computer -Force
==========================================================================================
#On Nano Server

New-PSSession -ComputerName Nano-01.matrix.local -Credential matrix\administrator

Enter-PSSession ?

Install-Module -Name dockermsftprovider -Repository psgallery -Force

Install-Package -Name docker -ProviderName dockermsftprovider 

Restart-Computer -Force

netsh advfirewall firewall add rule name="docker daemon" dir=in action=allow protocol=tcp localport=2375

New-Item -Type file C:\ProgramData\docker\config\daemon.json 

Add-Content 'C:\ProgramData\docker\config\daemon.json' '{ "hosts": ["tcp://0.0.0.0:2375", "npipe://"] }'

Restart-Service docker
===============================================================================================================
#Install PowerShell Module for Docker

Register-PSRepository -Name dockerps-dev -SourceLocation https://ci.appveyor.com/nuget/docker-powershell-dev

Install-Module docker -Repository dockerps-dev -Scope CurrentUser

Get-Command -Module docker

===============================================================================================================

docker search microsoft

docker search microsoft --no-trunc

docker pull microsoft/windowsservercore

docker images

docker run -it microsoft/windowsservercore ping -t localhost

docker run -it --isolation=hyperv microsoft/windowsservercore ping -t localhost

docker ps

docker ps -a

docker top (imageName)
==========================================================================================

docker run --help

docker start (imageName)

docker stop (imageName)

docker attach (imageName)       #Enter inside Container

docker rm (imageName)