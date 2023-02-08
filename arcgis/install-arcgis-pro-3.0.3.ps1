# start msi service
(Get-Service -name msiserver).Start()

# install chocolatey
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'));

# install desktop runtime dependency
choco install dotnet-6.0-desktopruntime -y

$wc = New-Object System.Net.WebClient
$wc.DownloadFile($env:ARCGIS_PRO_3_CAB_URL, 'ArcGISPro.cab')
Unblock-File ./ArcGISPro.cab
$wc.DownloadFile($env:ARCGIS_PRO_3_CAB1_URL, 'ArcGISPro1.cab')
Unblock-File ./ArcGISPro1.cab
$wc.DownloadFile($env:ARCGIS_PRO_3_MSI_URL, 'ArcGISPro.msi')
Unblock-File ./ArcGISPro.msi

# install arcgis pro 3
msiexec.exe /i ArcGISPro.msi /quiet /qn /norestart /log C:/tmp/arcgisinstall.log ALLUSERS=1 ACCEPTEULA=YES CHECKFORUPDATESATSTARTUP=0 LOCK_AUTH_SETTINGS=FALSE ESRI_LICENSE_HOST=@geosaurus.esri.com SOFTWARE_CLASS=PROFESSIONAL AUTHORIZATION_TYPE=CONCURRENT_USE

setx PATH "$env:PATH;C:\Program Files\ArcGIS\Pro\bin\Python\envs\arcgispro-py3\Scripts;C:\Program Files\ArcGIS\Pro\bin\Python\envs\arcgispro-py3;C:\Program Files\ArcGIS\Pro\bin\Python\Scripts"

# nix install files
rm ArcGISPro.cab
rm ArcGISPro1.cab
rm ArcGISPro.msi
