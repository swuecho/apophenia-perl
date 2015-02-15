#define PERL_NO_GET_CONTEXT
#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

#include "ppport.h"

#include "apop.h"
#include "stdio.h"

char* echo_str(char *str) {
    return str;
}   
int treble(int x) {
    x*=3;
    return x;
}

MODULE = Apophenia		PACKAGE = Apophenia		

int treble(x)
    int x

char* echo_str(str)
    char* str

int apop_db_open(filename)
    char * filename
        
int apop_table_exists(filename, remove)
    char* filename
    char remove
