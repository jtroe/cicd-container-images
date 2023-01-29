$wc = New-Object System.Net.WebClient
$wc.DownloadFile($env:ARCGIS_PRO_3_CAB_URL, 'ArcGISPro.cab')
Unblock-File ./ArcGISPro.cab
$wc.DownloadFile($env:ARCGIS_PRO_3_CAB1_URL, 'ArcGISPro1.cab')
Unblock-File ./ArcGISPro1.cab
$wc.DownloadFile($env:ARCGIS_PRO_3_MSI_URL, 'ArcGISPro.msi')
Unblock-File ./ArcGISPro.msi
    
msiexec.exe /i ArcGISPro.msi /qb ALLUSERS=1 ACCEPTEULA=YES CHECKFORUPDATESATSTARTUP=0 LOCK_AUTH_SETTINGS=FALSE ESRI_LICENSE_HOST=@geosaurus.esri.com SOFTWARE_CLASS=PROFESSIONAL AUTHORIZATION_TYPE=CONCURRENT_USE
rm ArcGISPro.cab
rm ArcGISPro1.cab
rm ArcGISPro.msi
