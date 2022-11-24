# Copyright (c) 2020 NVIDIA Corporation.  All rights reserved. 

CC := nvc++
CFLAGS := -O3 -w -ldl
ACCFLAGS := -Minfo=accel
NVTXLIB := -I/opt/nvidia/hpc_sdk/Linux_x86_64/22.7/cuda/11.0/include

FC := nvfortran
FFLAGS := -fast
LDFLAGS := -lnvhpcwrapnvtx 
    
miniWeather_c: miniWeather_serial.cpp
	${CC} ${CFLAGS} ${ACCFLAGS} -o miniWeather miniWeather_serial.cpp ${NVTXLIB} 

miniWeather_f: miniWeather_serial.f90
	$(FC) $(FFLAGS) $(ACCFLAGS) miniWeather_serial.f90 -o miniWeather $(LDFLAGS)
    
clean:
	rm -f *.o miniWeather *.nsys-rep *.sqlite *.ncu-rep
