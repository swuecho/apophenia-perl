%module Apophenia
%{
 #include "apop.h"
%}

extern void apop_vector_log(gsl_vector *v); 
extern long double apop_vector_sum(const gsl_vector *in); 
