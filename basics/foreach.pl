#!/usr/bin/perl -w
#ident "@(#) Modify the contents of an array using foreach.. Atre 11 Feb 2008"

use strict;

my $sVal = undef;
my @liArr = ( 1 .. 10 ); # Initialise an array..
print "Array liArr contains [", join ( ' ', @liArr ), "]\n";

#
# Modify the array..
#
foreach $sVal ( @liArr ) {
  print "Val [$sVal] Incremented Val to [", ++ $sVal, "] in foreach loop..\n";
}
print "Array now liArr contains [", join ( ' ', @liArr ), "]\n";
