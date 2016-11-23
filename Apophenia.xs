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


MODULE = Apophenia		PACKAGE = Apophenia		

double
sum(array)
        AV * array

double
mean(array)
        AV * array


