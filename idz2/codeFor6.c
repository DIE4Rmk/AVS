#include <stdio.h>
#include <stdlib.h>

char arr[10000];

void mod_arr(char *arr, int lenght) {
    register int i asm("r12");
    for(i = 0; i < lenght; i++) {
        char k = arr[i];
        if(k == 'a' || k == 'e' || k == 'i' || k == 'o' || k == 'u' || k == 'y') {
            printf("0x%x", arr[i]);
        } 
        else {
            putchar(arr[i]);
        }
    }
}

int main(int argc, char* argv[]) {
    register char chr asm("r11");
    register int lenght asm("r12");
    lenght = 0;
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
