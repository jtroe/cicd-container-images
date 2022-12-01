FROM mcr.microsoft.com/windows/servercore:ltsc2022

LABEL org.opencontainers.image.authors="jroebuck@esri.com"
LABEL org.opencontainers.image.description="Windows-based image with miniconda3 and conda-build, for quickly building conda packages in your pipelines"
LABEL org.opencontainers.image.licenses=MIT
LABEL org.opencontainers.image.source=https://github.com/jtroe/cicd-container-images

WORKDIR /tmp

# install miniconda
RUN powershell (New-Object System.Net.WebClient).DownloadFile('https://repo.anaconda.com/miniconda/Miniconda3-latest-Windows-x86_64.exe', 'miniconda3.exe') && \
    powershell Unblock-File miniconda3.exe && \
    miniconda3.exe /InstallationType=JustMe /RegisterPython=1 /S /D=C:\Miniconda3 && \
    del miniconda3.exe

# add conda to PATH
ENV PATH C:\Miniconda3\Library\bin:$PATH

CMD ["cmd"]

RUN conda init && conda clean -afy

# install psutil conda-build conda-verify into root environment
RUN conda activate root && conda install psutil conda-build conda-verify && conda clean -afy