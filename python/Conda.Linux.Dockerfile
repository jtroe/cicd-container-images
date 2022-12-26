FROM ubuntu:22.04

LABEL org.opencontainers.image.authors="jroebuck@esri.com"
LABEL org.opencontainers.image.description="Ubuntu-based image with miniconda3 and conda-build, for quickly building conda packages in your pipelines"
LABEL org.opencontainers.image.licenses=MIT
LABEL org.opencontainers.image.source=https://github.com/jtroe/cicd-container-images

# force bash
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

ENV DEBIAN_FRONTEND=noninteractive
# install build/dev tools
RUN apt-get update && apt-get upgrade -y && \
  apt-get install -y curl bzip2 vim-tiny p7zip git gcc make tzdata gettext-base libglib2.0-0 locales wget && \
  # clean the apt cache at the end of each apt command so that the caches don't get stored in the layer
  apt-get clean && rm -rf /var/lib/apt/lists/
RUN locale-gen "en_US.UTF-8"

# install miniconda
RUN cd /opt && wget -O miniconda3.sh https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh && \
  bash /opt/miniconda3.sh -b -p /opt/conda && \
  # remove install from layer
  rm miniconda3.sh

# add conda to PATH
ENV PATH /opt/conda/bin:$PATH

# set default shell to load .bashrc
SHELL ["/bin/bash", "-l", "-c"]