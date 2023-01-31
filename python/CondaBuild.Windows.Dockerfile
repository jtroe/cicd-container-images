FROM ghcr.io/jtroe/cicd-container-images/conda-windows:latest

LABEL org.opencontainers.image.authors="jroebuck@esri.com"
LABEL org.opencontainers.image.description="Windows-based image with miniconda3 and conda-build, for quickly building conda packages in your pipelines"
LABEL org.opencontainers.image.licenses=MIT
LABEL org.opencontainers.image.source=https://github.com/jtroe/cicd-container-images

# install psutil conda-build conda-verify into root environment
RUN conda activate root && conda install psutil conda-build conda-verify && conda clean -afy