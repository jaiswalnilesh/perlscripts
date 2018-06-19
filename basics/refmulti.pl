#!/bin/perl -w

use strict;

my $aref = [ 1, 2, 3, [ 4, 5, 6, [ 7, 8, 9 ] ] ];
print "AREF 3x2 [", $aref->[3][2], "]\n";
print "AREF 3x3 [", $aref->[3][3][0], "]\n";
