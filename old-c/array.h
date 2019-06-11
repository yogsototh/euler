#ifndef ARRAY
#define ARRAY

#define true 1
#define false 0

typedef struct t_array {
    char *chr;
    int length; 
    int max_length;
} *Array;

void free_Array(Array array) {
    free(array->chr);
    free(array);
}

Array new_Array(int size) {
    fprintf(stderr,"Malloc new_Array: struct\n");
    Array array = (Array)malloc(sizeof(struct t_array));
    if (! array)
        return NULL;
    fprintf(stderr,"Malloc new_Array: array->chr\n");
    array->chr = (char *)malloc(size);
    if (! array->chr) {
        free(array);
        return NULL;
    }
    array->length=0;
    array->max_length=size;
    return array;
}

char *str_Array(Array array, char *tmp) {
    int i;

    if (!tmp) {
        fprintf(stderr,"Malloc str_Array\n");
        tmp=(char *)malloc(array->length+1);
    }
    for (i=0; i<array->length; i++){
        tmp[i]=array->chr[i];
    }
    tmp[i]='\0';
    return tmp;
}

char *show_Array(Array array, char *res) {
    int i,j;
    int t;
    if (res == NULL) {
        fprintf(stderr,"Malloc show_Array\n");
        res=(char *)malloc(4*array->max_length + 1);
    }

    fprintf(stderr,"Length = %d\n", array->length);
    for (i=0,j=0;i<array->length;i++) {
        t = array->chr[i];
        if (t>=100) {
            res[j++]=t/100 + '0';
            j++;
        }
        if (t>=10) {
            res[j++]=t/10 - 10*(t/100) + '0';
        }
        res[j++]=t - 10*(t/10) - 100*(t/100) + '0';
        res[j++]=',';
    }
    res[j]='\0';

    return res;
}

int push (Array array, char value) {
    if (array->length < array->max_length) {
        array->chr[array->length]=value;
        array->length++;
        return true;
    }
    return false;
}

int pop(Array array) {
    if (array->length == 0)
        return -1;
    array->length--;
    return array->chr[array->length];
}
void empty_Array(Array array) {
    array->length = 0;
}

#endif
