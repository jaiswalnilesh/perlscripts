#!/usr/bin/perl -w
#ident "@(#) Attempt bidirectional pipes.. Atre 29 Jul 2009"

use strict;
use IPC::Open2;

local ( * READER, * WRITER );
my $iSum = 2;
my $iPid = open2 ( \* READER, \* WRITER, "/usr/bin/bc -l" ) ||
           die "Failed to open bidirectional pipe with bc: $!\n";

foreach ( 1 .. 5 ) {
# print "Sum [$iSum] Writing [$_] times..\n"; # Uncomment for debug..
  print WRITER "$iSum + $iSum\n";
  ( $iSum = <READER> ) =~ s/\n//g; # Chomp..
}

close ( WRITER ) ||
die "Failed to close write end: $!\n";

close ( READER ) ||
die "Failed to close read end: $!\n";

waitpid ( $iPid, 0 );

print "Sum is [$iSum]\n";
