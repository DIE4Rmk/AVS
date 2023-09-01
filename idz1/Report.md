# ИДЗ Рахильский Марк БПИ-218 ВАР-4.

# Task - если a[i] > 0 -> b[i] = 1 /если a[i] == 0 -> b[i] = 0 /если a[i] < 0 -> b[i] = -1. 

##Оценка 5

### C code.
```c
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
```

### Компиляция программы без оптимизации
```sh
gcc -O0 -Wall -masm=intel test.c -S -o testEmpt.s
```


### Компиляция программы с оптимизацией
```sh
gcc -O0 -Wall -masm=intel -fno-asynchronous-unwind-tables -fno-stack-protector -fno-exceptions test.c -S -o test.s
```

### Прогоны модифицириованного ассемб. кода и обычного.

| Входные данные  | test.s            | testEmpt.s    |
|-----------------|:---------------:|:---------------:|
| [1 2 3 4]       | [1 1 1 1]       | [1 1 1 1]       |
| [2 0 -2 2 0]    | [1 0 -1 1 0]    | [1 0 -1 1 0]    |
| [0 0 0]         | [0 0 0]         |[0 0 0]          |

### Комментарии и другие критерии
Исходный код использовал функции, локальные переменные (не глобальные), ассемблированный код был откомментирован,
элементы, подлежащие подозрению на сложность читаемости убраны. В функциях в комментариях указаны переданные и возварщаемые параметры.
Очевидные данные были проигнорированы. Параметры в коде передаются через argv и argc!

### Содержание зип архива
Архив содержит отчет Report.md
код на Си - test.c
НЕ МОДИФИЦ. код - testEmpt.s и его вывод - testEmpt.out
Модиф код - test.s и его вывод - assmCode.out




