#include <stdio.h>
#include <sys/wait.h>
#include <sys/types.h>
#include <unistd.h>
#include <stdlib.h>
#include <string.h>


int main(int argc, char **argv) {
    // Load config files, of any

    // Run command loop
    lsh_loop();

    // Perform any shitdown/cleanup

    return EXIT_SUCCESS;
}