#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

char arrCh[10000];

bool getAns(int counter, char *arr, int n, int i) {
    if(counter == n) {
        printf("\n");
        for(int j = i; j < i + n; j++) {
            putchar(arrCh[j]);
        }
        return true;
    }
    else return false;
}

int main(int argc, char* argv[]) {
    int i = 0;
    int lenght = 0;
    char chr;
    do {
        chr = fgetc(stdin);
        arrCh[lenght++] = chr;
    } while (chr != -1 && lenght < 10000);
    lenght--;
    
    if (chr != -1 && lenght >= 10000) {
        printf("ERROR. INPUT TOO BIG-UWU");
        return 0;
    }
    
    
    int n = arrCh[lenght - 1] - '0';
    i = lenght - 3;
    int counter = 1;
    do {
        if(arrCh[i] < arrCh[i + 1]) {
            counter++;
            if(getAns(counter, arrCh, n, i)){
                return 0;
            }
        }
        else {
            counter = 1;
        }
        i--;
    } while(true);
    return 0;
}
