Bootstrap: docker
From: nvcr.io/nvidia/nvhpc:25.11-devel-cuda_multi-ubuntu22.04

%environment
    export XDG_RUNTIME_DIR=
    export DEBIAN_FRONTEND=noninteractive
    export UV_SYSTEM_PYTHON=1
    export PATH="$PATH:/root/.cargo/bin:/root/.local/bin"
    
    # Set NVIDIA HPC SDK environment variables
    export NVHPC_ROOT=/opt/nvidia/hpc_sdk/Linux_x86_64/25.11
    export CUDA_HOME=${NVHPC_ROOT}/cuda/12.9
    export CUDA_PATH=${CUDA_HOME}/targets/x86_64-linux
    
    # Update PATH with compiler and CUDA binaries
    export PATH=${NVHPC_ROOT}/compilers/bin:${CUDA_PATH}/bin:${PATH}
    
    # Update library paths
    export LD_LIBRARY_PATH=${CUDA_PATH}/lib:${CUDA_PATH}/lib64:${NVHPC_ROOT}/compilers/lib:${LD_LIBRARY_PATH}
    
    # Update C/C++ include paths
    export CPATH=${CUDA_PATH}/include:${CPATH}

%post
    build_tmp=$(mktemp -d) && cd ${build_tmp}
    
    export DEBIAN_FRONTEND=noninteractive
    export UV_SYSTEM_PYTHON=1
    
    apt-get -y update
    apt-get -y dist-upgrade
    
    # Install system dependencies
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
        build-essential \
        nvidia-modprobe \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*
    
    # Install UV package manager
    curl -LsSf https://astral.sh/uv/install.sh | sh
    export PATH="/root/.cargo/bin:${PATH}"
    
    # Install JupyterLab
    /root/.cargo/bin/uv pip install jupyterlab
    
    # Create workspace directory
    mkdir -p /workspace/_profiler
    
    cd /
    rm -rf ${build_tmp}

%files
    _profiler/ /labs

%runscript
    "$@"

%labels
    Author NVIDIA
    Version 2025.11
    Description HPC Profiler Bootcamp with NVIDIA HPC SDK and Nsight Tools

%help
    This container provides the HPC Profiler Bootcamp environment with:
    - NVIDIA HPC SDK 25.11
    - CUDA 12.9
    - Nsight Systems and Compute profiling capabilities
    - JupyterLab interface
    
    To run:
    singularity run --nv _profiler.simg jupyter-lab --notebook-dir=~/labs