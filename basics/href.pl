#!/usr/bin/perl -w
#ident "@(#) Hash reference.. Atre 11 Feb 2008"

use strict;

my %hColour = ( 'roses'  => 'red',
                'sky'    => 'blue',
                'grass'  => 'green',
                'lilies' => 'pink' );

my $hsRef = \%hColour;
my $sColour = 'lilies';

print "Lilies are ", ${ $hsRef } { lilies }, " in colour!\n";
print "Lilies are ", ${ $hsRef } { ${ sColour } }, " in colour!\n";
