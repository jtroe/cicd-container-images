FROM ghcr.io/jtroe/cicd-container-images/arcgis-conda:2.1.0

LABEL org.opencontainers.image.authors="jroebuck@esri.com"
LABEL org.opencontainers.image.description="Ubuntu-based image with miniconda and arcgis_learn==2.1.0"
LABEL org.opencontainers.image.licenses=MIT
LABEL org.opencontainers.image.source=https://github.com/jtroe/cicd-container-images

RUN conda install -c esri arcgis_learn==2.1.0 && \
  # clean conda cache so that the caches don't get stored in the layer
  conda clean -afy
