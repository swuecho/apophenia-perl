#define PERL_NO_GET_CONTEXT
#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

#include "ppport.h"

#include "apop.h"
#include "stdio.h"

double ftest(double n1, double n2, double n3, double n4)
{
  double p;
  apop_data *testdata = apop_data_falloc((1,3),n1,n2,n3,n4) ;
  testdata = apop_test_fisher_exact(testdata);
  p = apop_data_get(testdata, 1);
  // p = gsl_matrix_get(testdata->matrix,1,0);
  // deallocate testdata (apop_data struct)
  apop_data_free(testdata);
  return p;
}
 
void rake(char* db_name) {
    apop_db_open(db_name);
    apop_data * raked_data =  apop_rake(.margin_table="margins", .count_col="weight",
            .contrasts=(char*[]){"row", "col"}, .contrast_ct=2,
            .init_table="sample", .init_count_col="val");
    apop_query("begin;");
    apop_data_print(raked_data, .output_name="racked", .output_type='d');
    apop_query("commit;");
}

MODULE = Apophenia		PACKAGE = Apophenia		


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

void rake(db_name)
    char* db_name
// try to figure out why 
//  char &db_name
//  does not work
