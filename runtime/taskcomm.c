#include <stdio.h>
#include <stdlib.h>

// ...existing code...

#ifdef TASKCOMM_MAIN
int main(int argc, char *argv[]) {
    // ...existing code...
    printf("Taskcomm runtime started\n");
    // ...existing code...
    return 0;
}
#endif
