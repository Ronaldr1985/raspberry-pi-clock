CC = clang

PREFIX = /usr/local

LIBS = -lbcm2835

# compiler flags:
#  -Wall turns on most, but not all, compiler warnings
CFLAGS  = -Wall $(INCS) $(LIBS)
