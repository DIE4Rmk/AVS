# ИДЗ-3 Рахильский Марк БПИ-218 ВАР-10.

# Task - степенной ряд гиперб. тангенса.

##Оценка 6

### C code.
```c
#include <stdio.h>
#include <math.h>
#include <stdlib.h>

double get_laplas_plus(double x) {
    register int i asm("r12");
    i = 2;
    double factor = 2;
    double rez1 = x + 1;

    while(1) {
        double lambda1 = (pow(x, i) / factor);
        rez1 += lambda1;
        if(abs(lambda1) <= (0.0005 * rez1)) {
            return rez1;
        }
        
        i += 1;
        factor *= i;
    }
}


int main(int argc, char* argv[]) {
    double x;
    scanf("%lf", &x);
    
    double rez1 = get_laplas_plus(x);
    double rez2 = 1 / rez1;
    printf("%lf", (rez1 - rez2) / (rez1 + rez2));
    return 0;
}
```
### Важно - под точностью я продразумеваю разницу между i-й и i+1 й шагом. Изначально программа
### компилировалась через cpp (СЛУЧАЙНО) и все былок ок, однако через Си она немного изменяет тысячные.
### Прошу простить за это. 



### Компиляция программы без оптимизации
```sh
gcc -O0 -Wall -masm=intel solution.c -S -o sol.s
```

###Объектный файл
```sh
gcc solution.c -lm
```

### Компиляция программы с оптимизацией
```sh
gcc -O0 -Wall -masm=intel -fno-asynchronous-unwind-tables -fno-stack-protector -fno-exceptions code5.c -S -o code5MOD.s
```

### Прогоны модифицириованного ассемб. кода и обычного. (СОВПАДАЕТ С ПРОГОНАМИ С РЕГИСТРАМИ И БЕЗ)

| Входные данные  | solMod.s        |    sol.s        |
|-----------------|:---------------:|:---------------:|
| [1]             |    [0.724138]   |    [0.724138]   |
| [2]             |    [0.960000]   |    [0.960000]   |
| [3]             |    [0.994935]   |    [0.994935]   |



### Сравнение
Код с регистрами на ~20 строк меньше, чем solNoReg.s


###Прочее
Зип архив содержит:

ReadMe.md- отчет


solution.c - код на си

sol.s - не модиф. .s код

solMod.s - МОДИФ. .s код, откомментированный.

solNoReg.c - .s код без регистров.
