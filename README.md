# Profiling with NVIDIA Nsight Tools Bootcamp
This repository contains learning materials and exercises for NVIDIA Nsight Tools. Gola is to learn how to profile your application with NVIDIA Nsight Systems,Compute and NVTX API calls to find performance limiters and bottlenecks and apply incremental parallelization strategies. The content was tested on **NVIDIA driver 515.65**.

- Introduction: Overview of profiling tools and Mini Weather application
- Lab 1: Profile Serial application to find hotspots using NVIDIA Nsight System
- Lab 2: Parallelise the serial application using OpenACC compute directives
- Lab 3: Optimizing loops 
- Lab 4: Apply incremental parallelization strategies and use profiler's report for the next step
- Lab 5: Nsight Compute Kernel Level Analysis
- [Optional]
    - Lab 6:Performance Analysis of an application using Nsight Systems and Compute (CUDA example)
    - Advanced: Multiprocess profiling 

## Target Audience

The target audience for this lab is researchers/graduate students and developers who are interested in getting hands on experience with the NVIDIA Nsight System through profiling a real life parallel application.

While Labs 1-5 do not assume any expertise in CUDA experience, basic knowledge of OpenACC programming (e.g: compute constructs), GPU architecture, and programming experience with C/C++ is desirable.

The Optional lab 6 requires basic knowledge of CUDA programming, GPU architecture, and programming experience with C/C++.

## Tutorial Duration

The lab material will be presented in a 2.5hr session. The link to the material is available for download at the end of each lab.


## Prerequisites:
To run this content you will need a machine with NVIDIA GPUs (Nsight Systems supports Pascal and above (SM 60+), and Nsight Compute supports Volta and above (SM 70+)).

- Install the [Docker](https://docs.docker.com/get-docker/) or [Singularity](https://sylabs.io/docs/]).
- Install Nvidia toolkit, [Nsight Systems (latest version)](https://developer.nvidia.com/nsight-systems) and [compute (latest version)](https://developer.nvidia.com/nsight-compute).
- The base containers required for the lab may require users to create a NGC account and generate an API key (https://docs.nvidia.com/ngc/ngc-catalog-user-guide/index.html#registering-activating-ngc-account)

## Creating containers
To start with, you will have to build a Docker or Singularity container.

### Docker Container
To build a docker container, run: 
`sudo docker build -t <imagename>:<tagnumber> .`

For instance:
`sudo docker build -t profiling:latest .`

The code labs have been written using Jupyter lab and a Dockerfile has been built to simplify deployment. In order to serve the docker instance for a student, it is necessary to expose port 8000 from the container, for instance, the following command would expose port 8000 inside the container as port 8000 on the lab machine:

`sudo docker run --rm -it --gpus=all -p 8888:8888 profiling:latest`

When this command is run, you can browse to the serving machine on port 8000 using any web browser to access the labs. For instance, from if they are running on the local machine the web browser should be pointed to http://localhost:8000. The `--gpus` flag is used to enable `all` NVIDIA GPUs during container runtime. The `--rm` flag is used to clean an temporary images created during the running of the container. The `-it` flag enables killing the jupyter server with `ctrl-c`. This command may be customized for your hosting environment.


Then, inside the container launch the Jupyter lab assigning the port you opened:

`jupyter-lab --ip 0.0.0.0 --port 8888 --no-browser --allow-root`


Once inside the container, open the jupyter lab in browser: http://localhost:8888, and start the lab by clicking on the `_start_profiling.ipynb` notebook.

### Singularity Container

To build the singularity container, run: 
`sudo singularity build _profiler.simg Singularity` . If you do not have `sudo` rights, you can build the singularity container with `--fakeroot` option: `singularity build --fakeroot _profiler.simg Singularity`

and copy the files to your local machine to make sure changes are stored locally:
`singularity run _profiler.simg cp -rT /labs ~/labs`

Then, run the container:
`singularity run --nv _profiler.simg jupyter-lab --notebook-dir=~/labs`

Once inside the container, open the jupyter lab in browser: http://localhost:8888, and start the lab by clicking on the `_start_profiling.ipynb` notebook.


## Known issues
- Please go through the list of exisiting bugs/issues or file a new issue at [Github](https://github.com/openhackathons-org/HPC_Profiler/issues).
