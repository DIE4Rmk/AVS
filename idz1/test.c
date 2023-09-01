#include <stdio.h>
#include <stdlib.h>


int sign(int a) {
    return (a != 0) | (a >> 31);
}

int * mod_arr(int *arr, int n) {
    int *b = malloc(n * sizeof(*b));
    for (int i = 0; i < n; ++i) {
        b[i] = sign(arr[i]);
    }
    return b;
}

int main(int argc, char *argv[]) {
    int n = argc - 1;
    int *a = malloc(n * sizeof(*a));

    for (int i = 0; i < n; ++i) {
        a[i] = (int) strtol(argv[i + 1], NULL, 10);
    }

    int *b = mod_arr(a, n);
    for (int i = 0; i < n; ++i) {
        printf("%d ", b[i]);
    }
    printf("\n");

    free(a);
    free(b);
    return 0;
}
