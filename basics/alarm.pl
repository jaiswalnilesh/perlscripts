#!/usr/bin/perl -w
#ident "@(#) Simple alarm clock.. Atre 28 Jul 2009"

use strict;

sub usage {
  warn "usage: $0 <timeout>\n";
  exit 1;
}

sub handler {
  warn "Alarm expired!\n";
  exit 1;
}

&usage () unless @ARGV;
my $iTimeout = shift;
my $sString = undef;

&usage () unless $iTimeout =~ /^\d+$/;

++ $|;

eval {
  local $SIG { ALRM } = \&handler;
  alarm $iTimeout;
  print "Enter input within [$iTimeout] secs.: ";
  $sString = <STDIN>;
  alarm 0; # Cancel the alarm..

  chomp $sString;
  print "You entered [$sString]\n";
};

print "After alarm cancellation..\n";
