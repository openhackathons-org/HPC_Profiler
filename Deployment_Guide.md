# HPC Profiler Bootcamp Deployment Guide

## Prerequisites

To run this bootcamp you will need a machine with NVIDIA GPUs. The profiling tools require:

- **GPU**: NVIDIA GPUs with Ampere architecture and above (SM 80+) for Nsight Systems and Nsight Compute.
- **Container Runtime**: Install [Docker](https://docs.docker.com/get-docker/) or [Singularity](https://sylabs.io/docs/)
- **NVIDIA Toolkit**: Install NVIDIA toolkit, [Nsight Systems (latest version)](https://developer.nvidia.com/nsight-systems) and [Nsight Compute (latest version)](https://developer.nvidia.com/nsight-compute)
- **NGC Account**: Building the base container image requires users to create a NGC account and generate an API key (https://docs.nvidia.com/ngc/ngc-catalog-user-guide/index.html#registering-activating-ngc-account)

## Tested Environment

We tested and ran all labs on a DGX machine equipped with A100 and H100 GPUs (80GB).

| Tool/Environment | Version | Details |
|------------------|---------|---------|
| HPC Docker Image | 2025.11 | nvhpc:25.11-devel-cuda_multi-ubuntu22.04 |
| Nsight Systems | 2025.5.1 | 2025.5.1.121-255136380782v0 |
| Nsight Compute | 2025.2.1 | 2025.2.1.0 |

## Deploying the Labs

### Running Docker Container

To run the labs, you will need access to a single GPU. Build a Docker container by following these steps:

1. Open a terminal window and navigate to the directory where the Dockerfile is located (e.g., `cd ~/HPC-Profiler`)

2. To build the docker container, run:
```bash
sudo docker build -t hpc-profiler:latest .
```

3. To run the built container:
```bash
docker run --rm -it --gpus=all -p 8888:8888 \
    --cap-add=SYS_ADMIN --cap-add=SYS_PTRACE --security-opt seccomp=unconfined \
    -v /path/to/_profiler:/workspace/_profiler \
    -w /workspace/_profiler \
    hpc-profiler:latest
```

**Flag descriptions:**
- `--rm` cleans up temporary images created during the running of the container
- `-it` enables interactive mode and killing the jupyter server with `ctrl-c`
- `--gpus=all` enables all NVIDIA GPUs during container runtime
- `--cap-add=SYS_ADMIN` and `--cap-add=SYS_PTRACE` grant necessary permissions for profiling tools
- `--security-opt seccomp=unconfined` allows profiling operations that require system calls
- `-v` mounts local directories in the container filesystem
- `-w` sets the working directory inside the container
- `-p` explicitly maps port 8888

When this command is run, you can browse to the serving machine on port 8888 using any web browser to access the labs. For instance, if running on the local machine, the web browser should be pointed to http://localhost:8888.

4. Once inside the container, open the jupyter lab in browser: http://localhost:8888, and start the lab by clicking on the `_start_profiling.ipynb` notebook.

5. As soon as you are done with the labs, shut down jupyter lab by selecting **File > Shut Down** and exit the container by typing `exit` or pressing `ctrl + d` in the terminal window.

### Running Singularity Container

1. Build the labs Singularity container with:
```bash
sudo singularity build _profiler.simg Singularity
```

If you do not have `sudo` rights, you can build the singularity container with the `--fakeroot` option:
```bash
singularity build --fakeroot _profiler.simg Singularity
```

2. Copy the files to your local machine to ensure changes are stored locally:
```bash
singularity run _profiler.simg cp -rT /labs ~/labs
```

3. To run the built container:
```bash
singularity run --nv _profiler.simg jupyter-lab --notebook-dir=~/labs
```

The `--nv` flag enables NVIDIA GPU support.

4. Once inside the container, open the jupyter lab in browser: http://localhost:8888, and start the lab by clicking on the `_start_profiling.ipynb` notebook.

5. When you finish these notebooks, shut down jupyter lab by selecting **File > Shut Down** in the top left corner, then shut down the Singularity container by typing `exit` or pressing `ctrl + d` in the terminal window.

## Troubleshooting

### ERR_NVGPUCTRPERM: Permission Issue with GPU Performance Counters

If you encounter `ERR_NVGPUCTRPERM` error when profiling, ensure the container is started with `--cap-add=SYS_ADMIN`. For a permanent solution, enable access on the host: `sudo sh -c 'echo "options nvidia NVreg_RestrictProfilingToAdminUsers=0" > /etc/modprobe.d/nvidia-profiling.conf'` then reboot. 

See [NVIDIA's solutions guide](https://developer.nvidia.com/nvidia-development-tools-solutions-err_nvgpuctrperm-permission-issue-performance-counters) for details.

