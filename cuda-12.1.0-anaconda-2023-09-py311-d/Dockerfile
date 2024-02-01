FROM nvidia/cuda:12.1.0-devel-ubuntu20.04

ENV DEBIAN_FRONTEND=noninteractive
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

# Install base utilities
RUN apt-get update && \
    apt-get install -y sudo

# Install tzdata
# ENV TZ=Etc/UTC
# RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN apt-get install -y tzdata

# Install developer tools
RUN apt-get install -y build-essential && \
    apt-get install -y wget && \
    apt-get install -y git && \
    apt-get install -y python3-pip

# Install LaTeX build system
RUN apt-get install -y texlive-latex-recommended texlive-latex-extra texlive-fonts-recommended texlive-fonts-extra texlive-xetex latexmk xindy dvipng ghostscript cm-super

# Clean apt
RUN sudo apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install miniconda
ENV CONDA_DIR /opt/conda
RUN wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh && \
     /bin/bash ~/miniconda.sh -b -p /opt/conda
RUN rm -rf Miniconda3-latest-Linux-x86_64.sh

# Put conda in path so we can use conda activate
ENV PATH=$CONDA_DIR/bin:$PATH

# Setup Environment
COPY environment.yml .
RUN conda env create -f environment.yml
RUN echo "source activate quantecon" > ~/.bashrc
ENV PATH /opt/conda/envs/quantecon/bin:$PATH

# Install JAX
RUN nvcc --version
RUN pip install torch torchvision pyro-ppl
RUN pip install "numpyro[cuda]" -f https://storage.googleapis.com/jax-releases/jax_cuda_releases.html
# Note: always install jax[cuda] last to ensure proper CUDA+CUDANN version linking
RUN pip install --upgrade "jax[cuda12_pip]" -f https://storage.googleapis.com/jax-releases/jax_cuda_releases.html
