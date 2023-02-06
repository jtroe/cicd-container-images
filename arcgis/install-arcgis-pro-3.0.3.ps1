# start msi service
(Get-Service -name msiserver).Start()

$wc = New-Object System.Net.WebClient
$wc.DownloadFile($env:ARCGIS_PRO_3_CAB_URL, 'ArcGISPro.cab') ; Unblock-File ./ArcGISPro.cab ;
$wc.DownloadFile($env:ARCGIS_PRO_3_CAB1_URL, 'ArcGISPro1.cab') ; Unblock-File ./ArcGISPro1.cab ;
$wc.DownloadFile($env:ARCGIS_PRO_3_MSI_URL, 'ArcGISPro.msi') ; Unblock-File ./ArcGISPro.msi ;
$wc.DownloadFile($env:ARCGIS_PRO_3_INI_URL, 'setup.ini') ; Unblock-File ./setup.ini ;

# install arcgis pro 3
Start-Process 'msiexec' -ArgumentList '/i C:\tmp\ArcGISPro.msi /quiet /qn /norestart /log C:\tmp\arcgisinstall.log ALLUSERS=1 ACCEPTEULA=YES CHECKFORUPDATESATSTARTUP=0 LOCK_AUTH_SETTINGS=FALSE ESRI_LICENSE_HOST=@geosaurus.esri.com SOFTWARE_CLASS=PROFESSIONAL AUTHORIZATION_TYPE=CONCURRENT_USE' -Wait

# add arcgis python to path
setx PATH "$env:PATH;C:\Program Files\ArcGIS\Pro\bin\Python\envs\arcgispro-py3\Scripts;C:\Program Files\ArcGIS\Pro\bin\Python\envs\arcgispro-py3;C:\Program Files\ArcGIS\Pro\bin\Python\Scripts"

# nix install files
rm ArcGISPro.cab ; rm ArcGISPro1.cab ; rm ArcGISPro.msi ; rm setup.ini ;
