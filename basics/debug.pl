#!/usr/bin/perl -wd
#ident "@(#) Debugging session.. Atre 31 Dec 2007"

use strict;

#-------------------------
# First define variables..
#-------------------------
my $iCnt = 10;
my $sStr = "This is a string";
my $sSubStr = ( $sStr =~ /([\w]+)/) [0];

print "String [$sStr] Sub-Str [$sSubStr]\n";

my $iRet = &increment ( $iCnt );

sub increment {
  my ( $iC ) = @_;

  ++ $iC;

  return ( $iC );
}
