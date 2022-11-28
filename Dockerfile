FROM nvidia/cuda:11.2.1-devel-ubuntu20.04

# Install base utilities
RUN apt-get update && \
    apt-get install -y sudo
RUN sudo apt-get update && \
    sudo apt-get install -y build-essential  && \
    sudo apt-get install -y wget && \
    sudo apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install miniconda
ENV CONDA_DIR /opt/conda
RUN wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh && \
     /bin/bash ~/miniconda.sh -b -p /opt/conda

# Put conda in path so we can use conda activate
ENV PATH=$CONDA_DIR/bin:$PATH

# Install LaTeX build system
RUN apt-get -qq update && \
    export DEBIAN_FRONTEND=noninteractive && \
    apt-get install -y tzdata && \
    apt-get install -y texlive-latex-recommended texlive-latex-extra texlive-fonts-recommended texlive-fonts-extra texlive-xetex latexmk xindy

# Setup Environment
COPY environment.yml ~/environment.yml
RUN conda install -f ~/environment.yml
RUN conda activate quantecon