#include <stdio.h>
#include <stdlib.h>

// ...existing code...

#ifdef NODEREQ_MAIN
int main(int argc, char *argv[]) {
    // ...existing code...
    printf("Nodereq runtime started\n");
    // ...existing code...
    return 0;
}
#endif
