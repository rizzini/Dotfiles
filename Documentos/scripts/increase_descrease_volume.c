#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

int main () {
        pid_t x;      // a special kind of int
        char kil[20] = "kill -s 9 ";

        x = fork();
        if (x < 0) {  // just in case fork fails
                puts("fork failure");
                exit(-1);
        }
        else if (x == 0) { // therefore this block will be the child process
                execlp("mpg123", "mpg123", "-q", "/home/lucas/Documentos/scripts/increase_descrease_volume.mp3", 0);
        }
}
