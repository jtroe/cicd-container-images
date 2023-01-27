FROM mcr.microsoft.com/windows/servercore:ltsc2022

ARG ARCGIS_PRO_3_CAB_URL
ARG ARCGIS_PRO_3_CAB1_URL
ARG ARCGIS_PRO_3_MSI_URL

LABEL org.opencontainers.image.authors="jroebuck@esri.com"
LABEL org.opencontainers.image.description="Windows-based image with ArcGIS Pro"
LABEL org.opencontainers.image.licenses=MIT
LABEL org.opencontainers.image.source=https://github.com/jtroe/cicd-container-images

WORKDIR /tmp

ENV ARCGIS_PRO_3_CAB_URL ${ARCGIS_PRO_3_CAB_URL}
ENV ARCGIS_PRO_CAB1_URL ${ARCGIS_PRO_3_CAB1_URL}
ENV ARCGIS_PRO_MSI_URL ${ARCGIS_PRO_3_MSI_URL}

# download pro msi and cabs and install
RUN powershell (New-Object System.Net.WebClient).DownloadFile($env:ARCGIS_PRO_3_CAB_URL, 'ArcGISPro.cab') && \
    powershell (New-Object System.Net.WebClient).DownloadFile($env:ARCGIS_PRO_3_CAB1_URL, 'ArcGISPro1.cab') && \
    powershell (New-Object System.Net.WebClient).DownloadFile($env:ARCGIS_PRO_3_MSI_URL, 'ArcGISPro.msi') && \
    msiexec.exe ArcGISPro.msi /qb ALLUSERS=1 ACCEPTEULA=YES CHECKFORUPDATESATSTARTUP=0 LOCK_AUTH_SETTINGS=FALSE ESRI_LICENSE_HOST=@geosaurus.esri.com SOFTWARE_CLASS=PROFESSIONAL AUTHORIZATION_TYPE=CONCURRENT_USE && \
    rm *.cab && rm *.msi

CMD ["cmd"]