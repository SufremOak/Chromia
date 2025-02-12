#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

int x;

int main(void);
// void rtcmt();
void init(void);

void loadfFunc() {
  // implementation needed
}

void rtcmt(int *argv, int *argc) {
  //  const int prompt = "#> ";
  while (true) {
//    printf($prompt);
    switch (x) {
    
      case ':h':
        printf("Chromia Runtime - help\n");
        printf("Commands:\n");
        printf("loadf <path> - Load a .cr binary file\n");
        printf("quit - quit Chromia Runtime\n");
        printf("runU - run current code\n");
        printf("Info: you can input C++ code and Obj-C code in there\n");
      break;
      case 'loadf':
        loadfFunc(); // <-- need to implement it
        break;
    }
  }
}

int main(void) {
  printf("Chromia Runtime v01\n");
  return 0;
}
