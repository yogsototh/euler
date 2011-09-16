#include <stdio.h>
#include <stdlib.h>

#include "array.h"

int potential_good_str(char *str) {
    int nb_spaces=0;
    int nb_ascii=0;
    int nb_non_ascii=0;
    int nb_words=0;
    int wordlen=0;
    int maxwordlen=0;
    int len;
    while (*str) {
        if (*str == ' ') nb_spaces++;
        if (((*str >= 'a') && (*str <= 'z')) ||  
           ((*str >= 'A') && (*str <= 'Z')) )
        {
            nb_ascii++;
            wordlen++;
        } else {
            if ((*str == ' ') || (*str == '.')) {
                if (wordlen>maxwordlen) {
                    maxwordlen = wordlen;
                }
                if (wordlen>3) {
                    nb_words++;
                }
            }
            wordlen=0;
        }
        if ((*str < 'A') || (*str > 'z')) nb_non_ascii++;
        len++;
        str++;
    }
    return (nb_words > 50);
}

int decode(Array str, Array code, Array res) {
    int i;
    empty_Array(res);
    if (str->length > res->max_length) {
        return 1;
    }
    for (i=0;i<str->length;i++) {
        push(res, str->chr[i] ^ code->chr[ i % code->length ]);
    }
    return 0;
}


int readInt(int *value, FILE* fd) {
    int tmp=0;
    int c=0;
    for(c=fgetc(fd); (c != EOF) &&  (c >= '0') && (c <= '9') ; c=fgetc(fd) ) {
        tmp=10*tmp + (c-'0');
    }
    *value=tmp;
    return c != EOF;
}

void fill_content(char *filename, Array content) {
    FILE *fd = NULL;
    int value;
    // ouverture du fichier
    fd = (FILE *)fopen(filename, "r");
    if (fd == NULL) {
        fprintf(stderr, "Impossible d'ouvrir %s\n", filename);
        exit(2);
    }

    // lecture du fichier
    while ( readInt(&value,fd) ) {
        push(content,value);
    }
    pop(content);

    fclose(fd);
}

int rec_crack(Array content, Array code, Array decoded, char *buffer) {
    int i;
    char tmp[4];
    int sum=0;
    char *str;
    if (code->length == code->max_length) {
        decode(content,code,decoded);
        if (potential_good_str(str_Array(decoded,buffer))) {
            fprintf(stderr,"Code: %s\nResult: %s\n",str_Array(code,tmp),buffer);
            for (str=buffer; *str; str++) {
                sum += *str;
            }
            fprintf(stderr, "Somme: %d\n",sum);
        }
    } else {
        if (code->length == 1) {
            fprintf(stderr,"%c",((code->chr[0]>20) && (code->chr[0]<127))?code->chr[0]:'.');
        }
        for (i='a';i<='z';i++) {
            push(code,i);
            rec_crack(content,code,decoded,buffer);
            pop(code);
        }
    }
    return 0;
}

int crack(Array content) {
    Array decoded=new_Array(content->max_length);
    Array code=new_Array(3);
    char *buffer=(char *)malloc(2000);
    /*
    char tmp[4];
    char *str;
    int sum;

    // ---
    push(code,'g');
    push(code,'o');
    push(code,'d');
    decode(content,code,decoded);
    fprintf(stderr,"Code: %s\nResult: %s\n",str_Array(code,tmp),str_Array(decoded,buffer));
    for (str=buffer; *str; str++) {
        sum += *str;
    }
    fprintf(stderr, "Somme: %d\n",sum);
    // ---
    */

    rec_crack(content,code,decoded,buffer);
}

int main (int argc, char **argv) {

    Array content=new_Array(2000);

    // récupération des arguments
    if (argc<2) {
        fprintf(stderr, "Usage %s [file]\n", argv[0]);
        exit(1);
    }

    // rempli content avec le contenu du fichier 1
    fill_content(argv[1], content);

    crack(content);

    free(content);
    return 0;
}
