use strict;
use warnings;
use v5.20;

use Test::More tests => 2;
BEGIN { use_ok('Apophenia') };

# result from R
=for comment 
> t1 <-c(30.02, 29.00, 30.11, 29.97, 30.01, 29.99)
> t2 <-c(29.89, 29.93, 29.72, 29.98, 30.02, 29.98)                                                        
> t.test(t1,t2)

        Welch Two Sample t-test

        data:  t1 and t2
        t = -0.39613, df = 5.6595, p-value = 0.7065
        alternative hypothesis: true difference in means is not equal to 0
        95 percent confidence interval:
         -0.50878  0.36878
         sample estimates:
         mean of x mean of y 
             29.85     29.92 
=end comment
=cut

my $t1 = [30.02, 29.00, 30.11, 29.97, 30.01, 29.99];
my $t2 = [29.89, 29.93, 29.72, 29.98, 30.02, 29.98];
my $r_t_test = t_test($t1, $t2);
is($r_t_test->{df}, 10);

# {
#    'confidence, 1 tail'   0.637417653271446,
#    'df'                     10,
#    'mean left - right'    -0.0700000000000003,
#    'p value, 1 tail'      0.362582346728554,
#    'p value, 2 tail'      0.725164693457109,
#    't statistic'          -0.361613473219216
#}





