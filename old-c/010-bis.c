#include <stdio.h>
#include <stdlib.h>
#include <math.h>

#define YES 1
#define NO 0

int main(int argc, char *argv[]) {
    int limit=2000000;
    int i,m;
    int crosslimit=sqrt(2000000);
    char *sieve=(char *)malloc(sizeof(char)*limit); 
    double sum;
    
    for (i=0;i<limit;i++) 
        sieve[i]=NO;
    
    for (i=4;i<limit;i+=2) {
        sieve[i]=1;
    }
    
    for (i=3; i<crosslimit; i+=2) {
        if (!sieve[i]) {
            for ( m=i*i ; m<limit; m+=2*i ) {
                sieve[m]=YES;
            }
        }
    }
    sum=0;
    for (i=2;i<limit;i++) {
        if (!sieve[i]) { 
            sum += i; 
        }
    }
    printf("%lf\n",sum);
}
