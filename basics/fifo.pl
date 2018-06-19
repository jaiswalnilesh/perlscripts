#!/usr/bin/perl -w
#ident "@(#) Demonstrate use of FIFO.. Atre 29 Jul 2009"

use strict;
use POSIX qw ( mkfifo );

=pod
 
 Ensure that you don't have "./fifo". Start this script in
 the background as:
 $ ./fifo.pl &

 Now read from the fifo:

 $ while true ; do
 > cat ./fifo
 > sleep 1
 > done

 You will see the writer and reader in action.

=cut
use Fcntl;

my $sFifo = "./fifo";
my $sData = "This is line no: ";
my $i = 0;

mkfifo ( $sFifo, 0666 ) ||
die "Failed to make FIFO [$sFifo]: $!\n";

++ $|;

while ( 1 ) {
  if ( ! -p $sFifo ) {
    warn "Missing FIFO [$sFifo]: $!\n";
    exit 1;
  }

  sysopen ( FIFO, $sFifo, O_WRONLY ) ||
  die "Failed to open FIFO [$sFifo] for write: $!\n";

  print FIFO $sData, ++ $i, "\n";

  close ( FIFO ) ||
  die "Failed to close FIFO [$sFifo] after write: $!\n";

  select ( undef, undef, undef, 0.250 ); # Sleep for 0.25 secs..
}
