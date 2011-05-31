#include <stdio.h>
#include <stdlib.h>
// Dictionnaries
typedef struct _node {
    char final;
    struct _node *sons[26];
} node;

typedef struct _node *Tree;
static Tree dictionary=NULL;
#define true 1
#define false 0

Tree addword(Tree d, char *word) {
    // fprintf(stderr,"addword %s\n",word);
    int index = word[0] - 'A';
    int i;
    if (d == NULL) { 
        d = (Tree)malloc(sizeof(node)); 
        d->final=false;
        for (i=0; i<26; i++) {
            d->sons[i]=NULL;
        }
    }
    if (word[0] != '\0') { 
        d->sons[index]=addword(d->sons[index],word+1); 
    } else {
        d->final = true;
    }
    return d;
}

void _show_tree(Tree t, int nb_tabs) {
    int i,j;
    if (t == NULL) {
        return;
    }
    for (j=0; j<nb_tabs; j++) { fprintf(stderr,"."); }
    if (t->final) { fprintf(stderr, "*\n"); }
    for (i=0;i<26;i++) {
        if (t->sons[i] != NULL) {
            fprintf(stderr,"%c\n",i+'A');
            _show_tree(t->sons[i],nb_tabs+1);
        }
    }
}

void show_tree(Tree t) {
    _show_tree(t,0);
}

char is_element(Tree d, char *word) {
    // fprintf(stderr,"is_element: %s\n", word);
    if (d==NULL) { 
        // fprintf(stderr,"d is NULL\n");
        return false; 
    }
    if (*word=='\0') { 
        // fprintf(stderr,"End of word\n");
        return d->final; 
    }
    return is_element(d->sons[word[0]-'A'], word+1);
}

#define MAX_WORD_SIZE 128
void create_dico_from_file(char *filename) {
    FILE *fd=fopen(filename,"r");
    int len;
    char word[MAX_WORD_SIZE];
    char *w;

    if (fd == NULL) {
        fprintf(stderr,"Unable to open the file: '%s'", filename);
        exit(1);
    }

    while (fgets(word, MAX_WORD_SIZE, fd)) {
        for (w=word; (*w != '\n') && (*w != '\0'); w++)
            ;
        *w='\0';
        dictionary=addword(dictionary,word);
    }
    close(fd);
}

int test(char *word) {
    printf("%s: %d\n", word, is_element(dictionary,word));
}

// int main(int argc, char **argv) {
//     create_dico_from_file("words-line.txt");
// }
