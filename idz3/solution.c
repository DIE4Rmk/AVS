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
