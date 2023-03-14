FROM ghcr.io/jtroe/cicd-container-images/arcgis-learn-conda:2.1.0

# install zip cli
RUN apt-get update && apt-get upgrade -y && \
  apt-get install -y zip gcc libkrb5-dev && \
  # clean the apt cache at the end of each apt command so that the caches don't get stored in the layer
  apt-get clean && rm -rf /var/lib/apt/lists/

# install sphinx + read the docs theme
RUN source activate arcgis && pip install sphinx==5.3.0 sphinx_rtd_theme==0.5.2
