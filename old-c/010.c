#include <stdio.h>
#include <stdlib.h>

#define YES 1
#define NO 0

int t[300000];
int tlen=0;

char is_prime(int n) {
    int i;
    for (i=0; i<tlen ; i++) {
        if ( n % t[i] == 0 )
            return NO;
    }
    return YES;
}

void gen_prime_up_to(int n) {
    int i=2;
    while (i<n) {
        if ( i % 20000 == 0) {
            printf("%d pc\n", i*100/n);
        }
        if (is_prime(i)) {
            t[tlen]=i;
            tlen++;
        }
        i++;
    }
}

double sum_up_to(int n) {
    int i;
    double sum=0;
    gen_prime_up_to(n);
    printf("tlen = %d\n", tlen);
    for (i=0; i<tlen; i++) {
        printf("%d\n", t[i]);    
        sum+=t[i];
    }
    return sum;
}

int main(int argc, char *argv[]) {
    int val=2000000;
    int i;
    // double sum;
    printf("Sum up to %d is %lf\n",val, sum_up_to(val));
    // for (i=0; i<2000000 ; i++) {
    //     sum+=i;
    // }
    // printf("Sum up to %d is %lf\n",val, sum);
}
