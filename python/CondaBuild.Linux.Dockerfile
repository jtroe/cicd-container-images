FROM ghcr.io/jtroe/cicd-container-images/conda:latest

LABEL org.opencontainers.image.authors="jroebuck@esri.com"
LABEL org.opencontainers.image.description="Ubuntu-based image with miniconda3 and conda-build, for quickly building conda packages in your pipelines"
LABEL org.opencontainers.image.licenses=MIT
LABEL org.opencontainers.image.source=https://github.com/jtroe/cicd-container-images


# install psutil conda-build conda-verify into root environment
RUN source activate root && conda install psutil conda-build conda-verify && \
  # clean conda cache so that the caches don't get stored in the layer
  conda clean -afy