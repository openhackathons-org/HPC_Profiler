# HPC Profiler Bootcamp

### Prerequisites:
- **GPU**: NVIDIA GPUs with Pascal and above (SM 60+) for Nsight Systems, Volta and above (SM 70+) for Nsight Compute
- **Container Runtime**: Install [Docker](https://docs.docker.com/get-docker/) or [Singularity](https://sylabs.io/docs/)
- **NVIDIA Toolkit**: Install NVIDIA toolkit, [Nsight Systems (latest version)](https://developer.nvidia.com/nsight-systems) and [Nsight Compute (latest version)](https://developer.nvidia.com/nsight-compute)
- **NGC Account**: Building the base container image requires users to create a NGC account and generate an API key (https://docs.nvidia.com/ngc/ngc-catalog-user-guide/index.html#registering-activating-ngc-account)To run code, enable code execution and file creation in Settings > Capabilities.

### Tested environment

We tested and ran all labs on a DGX machine equipped with an A100 and H100 GPUs (80GB).

| Tool/Environment | Version | Details |
|------------------|---------|---------|
| HPC Docker Image | 2025.11 | nvhpc:25.11-devel-cuda_multi-ubuntu22.04 |
| Nsight Systems | 2025.5.1 | 2025.5.1.121-255136380782v0 |
| Nsight Compute | 2025.2.1 | 2025.2.1.0 |

### Docker Container

To run the labs, you will need access to a single GPU. Build a Docker container by following these steps:

1. Open a terminal window and navigate to the directory where the Dockerfile is located (e.g., cd ~/HPC-Profiler)
2. To build the docker container, run:

```
sudo docker build -t hpc-profiler:latest .
```
3. To run the built container:

```
docker run --rm -it --gpus=all -p 8888:8888 \
    --cap-add=SYS_ADMIN --cap-add=SYS_PTRACE --security-opt seccomp=unconfined \
    -v /path/to/_profiler:/workspace/_profiler \
    -w /workspace/_profiler \
    hpc-profiler:latest
```

The code labs have been written using Jupyter Lab and a Dockerfile has been built to simplify deployment. To serve the docker instance, it is necessary to expose port 8888 from the container. The following command will expose port 8888 inside the container as port 8888 on the host machine.

When this command is run, you can browse to the serving machine on port 8888 using any web browser to access the labs. For instance, if running on the local machine, the web browser should be pointed to http://localhost:8888.

**Flag descriptions:**
- `--gpus=all` enables all NVIDIA GPUs during container runtime
- `--rm` cleans up temporary images created during the running of the container
- `--cap-add=SYS_ADMIN` and `--cap-add=SYS_PTRACE` grant necessary permissions for profiling tools
- `--security-opt seccomp=unconfined` allows profiling operations that require system calls
- `-it` enables interactive mode and killing the jupyter server with `ctrl-c`
- `-v` mounts local directories in the container filesystem
- `-w` sets the working directory inside the container

This command may be customized for your hosting environment.

Once inside the container, open the jupyter lab in browser: http://localhost:8888, and start the lab by clicking on the `_start_profiling.ipynb` notebook.