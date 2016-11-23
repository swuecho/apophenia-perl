#define PERL_NO_GET_CONTEXT
#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

#include "ppport.h"

#include "apop.h"
#include "stdio.h"


double sum(AV* array)
{
  int i;
  double sum = 0.0;
  int av_length = av_len(array) +1;
  gsl_vector* v = gsl_vector_alloc(av_length);
  for (i = 0; i < av_length; i++) {
      SV** elem = av_fetch(array, i, 0);
      gsl_vector_set(v, i, SvNV(*elem));
    }
  sum = apop_vector_sum(v);
  gsl_vector_free (v);
  return sum;
}

double mean(AV* array)
{
  int i;
  double mean= 0.0;
  int av_length = av_len(array) +1;
  gsl_vector* v = gsl_vector_alloc(av_length);
  for (i = 0; i < av_length; i++) {
      SV** elem = av_fetch(array, i, 0);
      gsl_vector_set(v, i, SvNV(*elem));
    }
  mean = apop_vector_mean(v);
  gsl_vector_free (v);
  return mean;
}
double var(AV* array)
{
  int i;
  double var= 0.0;
  int av_length = av_len(array) +1;
  gsl_vector* v = gsl_vector_alloc(av_length);
  for (i = 0; i < av_length; i++) {
      SV** elem = av_fetch(array, i, 0);
      gsl_vector_set(v, i, SvNV(*elem));
    }
  var = apop_vector_var(v);
  gsl_vector_free (v);
  return var;
}

double skew(AV* array)
{
  int i;
  double skew= 0.0;
  int av_length = av_len(array) +1;
  gsl_vector* v = gsl_vector_alloc(av_length);
  for (i = 0; i < av_length; i++) {
      SV** elem = av_fetch(array, i, 0);
      gsl_vector_set(v, i, SvNV(*elem));
    }
  skew = apop_vector_skew(v);
  gsl_vector_free (v);
  return skew;
}
double kurtosis(AV* array)
{
  int i;
  double kurtosis= 0.0;
  int av_length = av_len(array) +1;
  gsl_vector* v = gsl_vector_alloc(av_length);
  for (i = 0; i < av_length; i++) {
      SV** elem = av_fetch(array, i, 0);
      gsl_vector_set(v, i, SvNV(*elem));
    }
  kurtosis = apop_vector_kurtosis(v);
  gsl_vector_free (v);
  return kurtosis;
}


AV* t_test_arr(AV* l, AV* r) {
  int i;
  // init gsl_vector l
  int av_l_length = av_len(l) +1;
  gsl_vector* v_l = gsl_vector_alloc(av_l_length);
  for (i = 0; i < av_l_length; i++) {
      SV** elem = av_fetch(l, i, 0);
      gsl_vector_set(v_l, i, SvNV(*elem));
  }

  // init gsl_vector r
  int av_r_length = av_len(r) +1;
  gsl_vector* v_r = gsl_vector_alloc(av_r_length);
  for (i = 0; i < av_r_length; i++) {
      SV** elem = av_fetch(r, i, 0);
      gsl_vector_set(v_r, i, SvNV(*elem));
  }
  apop_data *test_out = apop_t_test(v_l, v_r);
/*
   apop_data_add_named_elmt(out, "mean left - right", diff);
   apop_data_add_named_elmt(out, "t statistic", stat);
   apop_data_add_named_elmt(out, "df", df);
   apop_data_add_named_elmt(out, "p value, 1 tail", GSL_MIN(pval,qval));
   apop_data_add_named_elmt(out, "confidence, 1 tail", 1 - GSL_MIN(pval,qval));
   apop_data_add_named_elmt(out, "p value, 2 tail", 1- two_tail);
   apop_data_add_named_elmt(out, "confidence, 2 tail", two_tail);
*/
   double diff = apop_data_get(test_out, .rowname="mean left - right");
   double t_stat = apop_data_get(test_out, .rowname="t statistic");
   double df  = apop_data_get(test_out, .rowname="df");
   double p_value_1_tail  = apop_data_get(test_out, .rowname="p value, 1 tail");
   double one_tail = apop_data_get(test_out, .rowname="confidence, 1 tail");
   double p_value_2_tail  = apop_data_get(test_out, .rowname="p value, 2 tail");
   double two_tail = apop_data_get(test_out, .rowname="confidence, 1 tail");
   AV* av= newAV();
   sv_2mortal((SV*)av);
   av_store(av,0, newSVnv(diff));
   av_store(av,1, newSVnv(t_stat));
   av_store(av,2, newSVnv(df));
   av_store(av,3, newSVnv(p_value_1_tail));
   av_store(av,4, newSVnv(one_tail));
   av_store(av,5, newSVnv(p_value_2_tail));
   av_store(av,6, newSVnv(two_tail));
   return av;

  /*int rv_size = test_out_vector->size;
  AV* av= newAV();
  sv_2mortal((SV*)av);
  for (i = 0; i < rv_size; i++)
    {
      av_store(av,i, newSVnv(gsl_vector_get(test_out_vector, i)));
    }
*/
    
  //TODO: return app_data outcome vector and then write perl wrapper
}



MODULE = Apophenia		PACKAGE = Apophenia		

double
sum(array)
        AV * array

double
mean(array)
        AV * array

double
var(array)
        AV * array

double
skew(array)
        AV * array


double
kurtosis(array)
        AV * array


AV*
t_test_arr(l, r)
        AV* l
        AV* r

