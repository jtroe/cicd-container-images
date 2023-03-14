FROM ghcr.io/jtroe/cicd-container-images/conda:latest

# install zip cli
RUN apt-get update && apt-get upgrade -y && \
  apt-get install -y zip gcc libkrb5-dev && \
  # clean the apt cache at the end of each apt command so that the caches don't get stored in the layer
  apt-get clean && rm -rf /var/lib/apt/lists/

# create arcgis environment w/ arcgis==2.1.0
RUN source activate root && conda create -n arcgis python=3.9 && \
  # clean conda cache so that the caches don't get stored in the layer
  conda clean -afy

# install sphinx + read the docs theme
RUN source activate arcgis && pip install sphinx==5.3.0 sphinx_rtd_theme==0.5.2

RUN echo "source activate arcgis" > ~/.bashrc
ENV PATH /opt/conda/envs/arcgis/bin:$PATH


