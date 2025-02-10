SRC_ROOT=../
PATH=/lib/chromia
JSLIB=chromiaJs.js
CLIB=chromiaC.h
CPPLIB=chromiaCpp.hpp
OBJCLIB=chromiaObjc.h
TSLIB=chromiaTs.js,chromiaTs.d.ts
CHROMIAOUT_BIN=/usr/local/Chromia/bin
CHROMIA_NIX=/usr/local/Chromia/nix

configure:
	mkdir /usr/local/Chromia
	mkdir /usr/local/Chromia/library
	mkdir /usr/local/Chromia/Applications
	mkdir /usr/local/Chromia/bin
	mkdir /usr/local/Chromia/nix
	gcc $(SRC_ROOT)/source/crsh.c -o $(CHROMIAOUT_BIN)/sh
	gcc $(SRC_ROOT)/source/mknix.c -o $(CHROMIAOUT_BIN)/mknix
	gcc $(SRC_ROOT)/source/knl.c -o $(CHROMIAOUT_BIN)/kern
	gcc $(SRC_ROOT)/source/crrt.cpp -Wall -Wextra -lstdc++ -o $(CHROMIA_NIX)/runtime 

install-c:
	cp chromiaC.h /usr/local/include
	
install-objc:
	cp chromiaObjc.h /usr/local/include

install-cpp:
	cp chromiaCpp.hpp 

