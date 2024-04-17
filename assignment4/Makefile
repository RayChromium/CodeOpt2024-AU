# # For Java
# JFLAGS = -g
# JC = javac

# For C
CC          = gcc
CLINKER     = $(CC)
OPTFLAGS    = -O3 ###-std=gnu11    ####-std=c99
LFLAGS	    = -lm -lopenblas
# LFLAGS	    = -lm
CFLAGS  =   $(OPTFLAGS) $(LFLAGS) 

# .SUFFIXES: .java .class
# .java.class:
# 	$(JC) $(JFLAGS) $*.java

# CLASSES = mm.java

# default: classes mm mm_blas

# classes: $(CLASSES:.java=.class)

.c.o:
	$(CC) $(CFLAGS) -c $*.c
.f.o:
	$(F77) $(FFLAGS) -c $*.f

mm_blas: mm_blas.o
	$(CLINKER) $(CFLAGS) -o mm_blas mm_blas.o

float3cal: float3cal.o
	$(CLINKER) $(CFLAGS) -o float3cal float3cal.o
### run: 
###	srun -n 1 java mm 2000 &
###	srun -n 1 mm 2000 &

clean:
	$(RM) *.class *.o mm_blas
