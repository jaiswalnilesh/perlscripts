#!/usr/bin/perl -w
#ident "@(#) Read data from /bin/ps.. Atre 29 Jul 2009"

use strict;

open ( PS, "/bin/ps -ef |" ) ||
die "Failed to open ps for read: $!\n";

while ( <PS> ) {
  chomp;
  print "Data [$_]\n";
}

close ( PS ) ||
die "Failed to close ps after read: $!\n";
