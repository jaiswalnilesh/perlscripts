#!/usr/bin/perl -w
#ident "@(#) Scalar example 2 Atre.. 30 Nov 2007"

use strict;

#
# Initialising new variables..
#
my ( $sString, $iDigit ) = (); # Initialise with undefs;

$sString = "Anshuman Atre";
$iDigit = 23;

print "String [$sString] Digit [$iDigit]\n";

#
# Assigning values as a list..
#
( $sString, $iDigit ) = ( "New string $sString", ++ $iDigit );
print "New String [$sString] Digit [$iDigit]\n";
