# Before 'make install' is performed this script should be runnable with
# 'make test'. After 'make install' it should work as 'perl Apophenia.t'

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use strict;
use warnings;

use Test::More tests => 4;
BEGIN { use_ok('Apophenia') };

#########################

# Insert your test code below, the Test::More module is use()ed here so read
# its man page ( perldoc Test::More ) for help writing this test script.

is(treble(1), 3);
is(treble(2), 6);
is(echo_str("abc"), "abc");
apop_db_open("./sample.db");

is(apop_table_exists("sample", 'n'),1);
