CC=gcc
SRC=dev/NSModules/*.c
CFLAGS=-Wall -Wextra -Werror -Wno-unused-parameter -Wno-unused-variable -Wno-unused-function -Wno-unused-value -Wno-unused-but-set-variable -Wno-unused-result -Wno-unused-label -Wno-unused-local-typedefs -Wno-unused-const-variable -Wno-unused-macros
LDFLAGS=-shared -fPIC

all: $(SRC)
	$(CC) $(CFLAGS) $(LDFLAGS) -o libNSModules.so $(SRC)
	@mkdir lib
	@mv libNSModules.so lib
	sudo -E ./dev/devenv