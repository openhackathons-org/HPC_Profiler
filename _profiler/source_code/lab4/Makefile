# Copyright (c) 2020 NVIDIA Corporation.  All rights reserved. 

CC := nvc++
CFLAGS := -O3 -w
ACCFLAGS := -ta=tesla -Minfo=accel

FC := nvfortran
FFLAGS := -fast
LDFLAGS := -lnvhpcwrapnvtx

miniWeather_c: miniWeather_openacc.cpp
	${CC} ${CFLAGS} ${ACCFLAGS} -o miniWeather miniWeather_openacc.cpp 

miniWeather_f: miniWeather_openacc.f90
	$(FC) $(FFLAGS) $(ACCFLAGS) miniWeather_openacc.f90 -o miniWeather $(LDFLAGS)
    
clean:
	rm -f *.o miniWeather *.nsys-rep *.sqlite *.ncu-rep
