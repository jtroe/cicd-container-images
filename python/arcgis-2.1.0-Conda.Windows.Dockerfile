FROM ghcr.io/jtroe/cicd-container-images/conda-windows:latest

LABEL org.opencontainers.image.authors="jroebuck@esri.com"
LABEL org.opencontainers.image.description="Ubuntu-based image with miniconda and arcgis==2.1.0"
LABEL org.opencontainers.image.licenses=MIT
LABEL org.opencontainers.image.source=https://github.com/jtroe/cicd-container-images

# create arcgis environment w/ arcgis==2.1.0
RUN conda activate root && conda create -n arcgis -c esri arcgis==2.1.0 && \
  # clean conda cache so that the caches don't get stored in the layer
  conda clean -afy && conda activate arcgis

ENV PATH /opt/conda/envs/arcgis/bin:$PATH
RUN setx /M PATH "%PATH%;C:/Miniconda3/envs/arcgis/bin"