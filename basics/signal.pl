#!/usr/bin/perl -w
#ident "@(#) Setup a simple signal handler.. Atre 28 Jul 2009"

use strict;

sub handler {
  my ( $iSig ) = @_;

  warn "Got signal [SIG$iSig]\n";
  return;
}

#
# Setup handler..
#
$SIG { INT } = \&handler;
$SIG { HUP } = \&handler;
$SIG { TERM } = "IGNORE";

#
# Proceed with your work..
#
while ( 1 ) {
  sleep 1000;
}

exit 0;
