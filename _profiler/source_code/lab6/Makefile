# Copyright (c) 2022 NVIDIA Corporation.  All rights reserved. 

CC := nvcc
CFLAGS := -x cu -lnvToolsExt -lineinfo -arch=native
ACCFLAGS := -Minfo=accel

FC := nvfortran
FFLAGS := -fast
LDFLAGS := -lnvhpcwrapnvtx 
    
jacobi: jacobi.cpp
	${CC} -o jacobi jacobi.cpp  

jacobi_step1: jacobi_step1.cpp
	${CC} -o jacobi_step1 ${CFLAGS} jacobi_step1.cpp
    
jacobi_step2: jacobi_step2.cpp
	${CC} -o jacobi_step2 ${CFLAGS} jacobi_step2.cpp

jacobi_step3: jacobi_step3.cpp
	${CC} -o jacobi_step3 ${CFLAGS} jacobi_step3.cpp
    
jacobi_step4: jacobi_step4.cpp
	${CC} -o jacobi_step4 ${CFLAGS} jacobi_step4.cpp

jacobi_step5: jacobi_step5.cpp
	${CC} -o jacobi_step5 ${CFLAGS} jacobi_step5.cpp
    
jacobi_step6: jacobi_step6.cpp
	${CC} -o jacobi_step6 ${CFLAGS} jacobi_step6.cpp

jacobi_step7: jacobi_step7.cpp
	${CC} -o jacobi_step7 ${CFLAGS} jacobi_step7.cpp
    
jacobi_step8: jacobi_step8.cpp
	${CC} -o jacobi_step8 ${CFLAGS} jacobi_step8.cpp
    
clean:
	rm -f *.o jacobi_step1 jacobi_step2 jacobi_step3 jacobi_step4 jacobi_step5 jacobi_step6 jacobi_step7 jacobi_step8 jacobi *.nsys-rep *.sqlite *.ncu-rep
