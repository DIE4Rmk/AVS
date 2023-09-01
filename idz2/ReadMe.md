# ИДЗ-2 Рахильский Марк БПИ-218 ВАР-7.

# Task - заменить гласные на 0xDD

##Оценка 5

### C code.
```c
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
    int i = 0;
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
```

### Компиляция программы без оптимизации
```sh
gcc -O0 -Wall -masm=intel code5.c -S -o code5.s
```


### Компиляция программы с оптимизацией
```sh
gcc -O0 -Wall -masm=intel -fno-asynchronous-unwind-tables -fno-stack-protector -fno-exceptions code5.c -S -o code5MOD.s
```

### Прогоны модифицириованного ассемб. кода и обычного.

| Входные данные  | code5MOD.s      | code5.s         |
|-----------------|:---------------:|:---------------:|
| [bcd]           |    [bcd]        |    [bcd]        |
| [abce]          | [0x61bc0x65]    | [0x61bc0x65]    |
| [y]             |    [0x79]       |    [0x79]       |



##Оценка 6

### C code.
```c
#include <stdio.h>
#include <stdlib.h>

char arr[10000];

void mod_arr(char *arr, int lenght) {
    register int i asm("r12"); //забрали регистр r12 для i
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
    register char chr asm("r11"); // r11 - chr
    register int lenght asm("r12"); // r12 - leght
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
```

### Прогоны модифицириованного ассемб. кода и обычного.

| Входные данные  | code5MOD.s      |    codeFor6.s   |
|-----------------|:---------------:|:---------------:|
| [bcd]           |    [bcd]        |    [bcd]        |
| [abce]          | [0x61bc0x65]    | [0x61bc0x65]    |
| [y]             |    [0x79]       |    [0x79]       |

### Сравнение
Код с регистрами на ~20 строк меньше, чем code5.s


###Прочее
Зип архив содержит:

ReadMe.md- отчет

variant4.c - СЛУЧАЙНО сделанный другой вариант, так же можно проверить

code5.c - код на оценку 5 с ф-ией и переменными

code5.s - не модиф. .s код

code5MOD.s - МОДИФ. .s код

codeFor6.c - код на оценку 6, добавлены регистры, немного изменен.

codeFor6.s - откомментированный .s код , модифицированный также, как и code5MOD.s

