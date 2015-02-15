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

double ftest(double n1, double n2, double n3, double n4)
{
  double p;
  apop_data *testdata = apop_data_falloc((1,3),n1,n2,n3,n4) ;
  testdata = apop_test_fisher_exact(testdata);
  p = apop_data_get(testdata, 1);
  printf("%d", p);
  // p = gsl_matrix_get(testdata->matrix,1,0);
  // deallocate testdata (apop_data struct)
  apop_data_free(testdata);
  return p;
}
  
MODULE = Apophenia		PACKAGE = Apophenia		

int treble(x)
    int x

char* echo_str(str)
    char* str

int apop_db_open(filename)
    char &filename
        
int apop_table_exists(filename, remove)
    char &filename
    char remove

double ftest(n1, n2, n3, n4)
    double n1
    double n2
    double n3
    double n4
