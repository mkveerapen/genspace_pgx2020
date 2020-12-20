# Copyright (c) Jupyter Development Team.
# Distributed under the terms of the Modified BSD License.
ARG BASE_CONTAINER=jupyter/minimal-notebook
FROM $BASE_CONTAINER

LABEL maintainer="Jupyter Project <jupyter@googlegroups.com>"

USER root

# R pre-requisites
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    fonts-dejavu \
    unixodbc \
    unixodbc-dev \
    r-cran-rodbc \
    gfortran \
    gcc \
    openjdk-8-jre-headless  && \
    rm -rf /var/lib/apt/lists/*

USER jovyan

# Fix for devtools https://github.com/conda-forge/r-devtools-feedstock/issues/4
#RUN ln -s /bin/tar /bin/gtar

# R packages
RUN conda install --quiet --yes \
    'r-base=4.0.3' \
    'r-caret=6.*' \
    'r-crayon=1.3*' \
    'r-devtools=2.3*' \
    'r-forecast=8.12*' \
    'r-hexbin=1.28*' \
    'r-htmltools=0.4*' \
    'r-htmlwidgets=1.5*' \
    'r-irkernel=1.1*' \
    'r-nycflights13=1.0*' \
    'r-randomforest=4.6*' \
    'r-rcurl=1.98*' \
    'r-rmarkdown=2.2*' \
    'r-rodbc=1.3*' \
    'r-rsqlite=2.2*' \
    'r-shiny=1.4*' \
    'r-tidyverse=1.3*' \
    'unixodbc=2.3.*' \
    'r-tidymodels=0.1*' \
    && \
    conda clean --all -f -y && \
    fix-permissions "${CONDA_DIR}"

RUN Rscript -e 'install.packages("fmsb", repos = "https://cloud.r-project.org")'
RUN Rscript -e 'install.packages("ggplot2", repos = "https://cloud.r-project.org")'
# Install e1071 R package (dependency of the caret R package)
RUN conda install --quiet --yes r-e1071

COPY ./resources/ /home/jovyan

