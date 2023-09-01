#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

char arr[10000];

void mod_arr(char *arr, int lenght) {
    for(int j = 0; j < lenght; j++) {
        char k = arr[j];
        if(k == 'a' || k == 'e' || k == 'i' || k == 'o' || k == 'u' || k == 'y') {
            printf("0x%x", arr[j]);
        } 
        else {
            putchar(arr[j]);
        }
    }
}

int main(int argc, char* argv[]) {
    int lenght = 0;
    char chr;
    do {
        chr = fgetc(stdin);
        arr[lenght++] = chr;
    } while (chr != -1 && lenght < 10000);
    lenght--;
    
    if (chr != -1 && lenght >= 10000) {
        printf("ERROR. INPUT TOO BIG-UWU");
        return 0;
    }
    printf("\n");
    mod_arr(arr, lenght);
    return 0;
}
