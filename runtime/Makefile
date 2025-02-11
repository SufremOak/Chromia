SOUT=/usr/local/Chromia
CC=gcc
CFLAGS=-Wall -Wextra
TARGET=cr.runtime
TARGET_DIR=$(SOUT)/Library/etc/sbin
SYS_DIR=$(SOUT)/Library/system

all:
	echo "Compiling runtime/main.c ..."
	$(CC) $(CFLAGS) ./main.c -o main.o
	echo "Compiling runtime/nodereq.c ..."
	$(CC) $(CFLAGS) ./nodereq.c -o nodereq.o
	echo "Compiling runtime/sysnq.c ..."
	$(CC) $(CFLAGS) ./sysnq.c -o sysnq.o
	echo "Compiling runtime/taskcomm.c"
	$(CC) $(CFLAGS) ./taskcomm.c -o taskcomm.o
	@mkdir build
	mv main.o ./build/main.o
	mv nodereq.o ./build/nodereq.o
	mv sysnq.o ./build/sysnq.o
	mv taskcomm.o ./build/taskcomm.o
	echo "Runtime compiled sucessfully."
