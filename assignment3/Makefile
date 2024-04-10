# For C
CC          = gcc
CLINKER     = $(CC)
OPTFLAGS    = -O3
LFLAGS	    = -lm
CFLAGS      = $(OPTFLAGS) $(LFLAGS)

.c.o:
	$(CC) $(CFLAGS) -c $*.c

mm: mm.o
	$(CLINKER) $(CFLAGS) -o mm mm.o

clean:
	$(RM) *.o mm