FROM ghcr.io/jtroe/cicd-container-images/conda-build:latest

LABEL org.opencontainers.image.authors="jroebuck@esri.com"
LABEL org.opencontainers.image.description="Conda environment for testing Esri Geosaurus v2.1.1 WIP"
LABEL org.opencontainers.image.licenses=MIT
LABEL org.opencontainers.image.source=https://github.com/jtroe/cicd-container-images

COPY ./python/geosaurus-v2.1.1.yml .
SHELL ["/bin/bash", "-l", "-c"]
RUN /opt/conda/bin/conda env create -f geosaurus-v2.1.1.yml && /opt/conda/bin/conda clean -afy
RUN /opt/conda/bin/conda init
RUN echo "source /opt/conda/bin/activate geosaurus_test" > ~/.bashrc
ENV PATH /opt/conda/envs/geosaurus_test/bin:$PATH
