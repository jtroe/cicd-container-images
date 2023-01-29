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

COPY ./install-arcgis-pro-3.0.3.ps1 /tmp

# download pro msi and cabs and install
RUN powershell ./install-arcgis-pro-3.0.3.ps1

CMD ["cmd"]
