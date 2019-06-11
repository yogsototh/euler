#include "dictionnary.c"
#define FILE_SIZE 2030

static Tree dictionnary;

char is_small_letter(char c) {
    return ('a' <= c) && (c <= 'z');
}
char is_letter(char c) {
    return (('A' <= c) && (c <= 'Z')) || is_small_letter(c);
}

char to_upper(char c) {
    if ( is_small_letter(c) )
        return 'A' - 'a' + c;
    return c;
}

void upper_str(char *str) {
    while (*str) {
        *str=to_upper(*str);
    }
}

char contains_english(char *decoded, int length) {
    int i;
    char tmpword[FILE_SIZE];
    int maxwordlen=0;
    int len=0;
    int badlen=0;
    int w=0;
    int nb_english_word=0;

    for (i=0; i<length ; i++) {
        if ( is_letter(decoded[i]) ) {
            tmpword[w]=to_upper(decoded[i]);
            w++;
        } else {
            tmpword[w+1]='\0';
            if (w>5) {
                fprintf(stderr,"%s\n",tmpword);
            }
            if (is_element(dictionnary,tmpword)) {
                fprintf(stderr,"WORD: %s\n",tmpword);
                nb_english_word++;
            }
            w=0;
        }
    }
    return nb_english_word > 0;
}

void decode(char *src, char *decoded, int code[], int length) {
    int i,j;
    for (i=0,j=0;i<length;i++) {
        decoded[i]= ((src[i]) ^ (code[j]));
        j = (j+1)%3;
    }
}

int sum (char *str) {
    int res=0;
    while (str != '\0') {
        res += *str;
    }
    return res;
}

int main (int argc, char **argv) {
    FILE *fd=fopen("cipher1-line.txt","r");
    char src[FILE_SIZE],decoded[FILE_SIZE];
    char *w;
    char str[4];
    int code[3];
    int length;
    int i,j,k;

    fprintf(stderr,"Dictionnary creation\n");
    create_dico_from_file("words-line.txt");
    test("YOUTH");

    if (! fd) {
        fprintf(stderr,"Couldn't read cipher.enc");
        return 1;
    }

    i=0;
    while (fgets(str,4,fd)) {
        for (w=src; (*w != '\n') && (*w != '\0'); w++)
            ;
        *w='\0';
        src[i]=atoi(str);
        i++;
    }
    src[i]='\0';
    length=i;
    fprintf(stderr,"length = %d\n",length);
    fclose(fd);

    // fprintf(stderr, "---\n");
    // for (i=0; i<length; i++) {
    //     fprintf(stderr, "%c", src[i]);
    // }
    // fprintf(stderr,"\n---\n");

    decoded[length]='\0';
    char *tst_str="TatiBus";
    upper_str(tst_str);
    fprintf(stderr, "TatiBus => %s\n", tst_str);

    for (i='z'; i>='a'; i--) {
        fprintf(stderr,"\n%c: ", i);
        code[0]=i;
        for (j='a'; j<='z'; j++) {
            code[1]=j;
            for (k='a'; k<='z'; k++) {
                code[2]=k;
                decode(src,decoded,code,length);
                if (contains_english(decoded, length)) {
                    printf("\ncode = %c,%c,%c", code[0],code[1],code[2]);
                    printf("decoded message: %s",decoded);
                    printf("Sum = ", sum(decoded));
                }
            }
        }
    }

    return 0;
}
