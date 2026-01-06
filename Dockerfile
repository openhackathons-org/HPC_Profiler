# Copyright (c) 2022 NVIDIA Corporation.  All rights reserved. 

# To build: $ sudo docker build -t profiling:latest .
# To run: $ sudo docker run --rm -it --gpus=all -p 8888:8888 profiling:latest
# Finally, open http://127.0.0.1:8888/

FROM nvcr.io/nvidia/nvhpc:25.11-devel-cuda_multi-ubuntu22.04

COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /bin/

ENV DEBIAN_FRONTEND=noninteractive
ENV UV_SYSTEM_PYTHON=1

# Set NVIDIA HPC SDK environment variables
ENV NVHPC_ROOT=/opt/nvidia/hpc_sdk/Linux_x86_64/25.11
ENV CUDA_HOME=${NVHPC_ROOT}/cuda/12.9
ENV CUDA_PATH=${CUDA_HOME}/targets/x86_64-linux

# Update PATH with compiler and CUDA binaries
ENV PATH=${NVHPC_ROOT}/compilers/bin:${CUDA_PATH}/bin:${PATH}

# Update library paths
ENV LD_LIBRARY_PATH=${CUDA_PATH}/lib:${CUDA_PATH}/lib64:${NVHPC_ROOT}/compilers/lib:${LD_LIBRARY_PATH}

# Update C/C++ include paths
ENV CPATH=${CUDA_PATH}/include:${CPATH}

# Install system dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    python3 \
    python3-pip \
    python3-dev \
    git \
    vim \
    curl \
    wget \
    zip \
    unzip \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN uv pip install jupyterlab

COPY _profiler /_profiler

WORKDIR /_profiler

CMD ["jupyter-lab", "--no-browser", "--allow-root", "--ip=0.0.0.0", "--port=8888", "--ServerApp.token=", "--ServerApp.password=", "--notebook-dir=/_profiler"]
