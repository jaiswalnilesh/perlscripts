#!/usr/bin/perl -w
#ident "@(#) Array example 1 Atre.. 30 Nov 2007"

#----------------------------
# LHS => Array, RHS => List..
#----------------------------
my @liArray = ( 1 .. 10 ); # Initialise..

print "Printing numbers from 1 to 10..\n";
print "$_\n" foreach ( @liArray );

my @lsArray = ( A .. Z );
print "\nPrinting alphabets A - Z\n";
print "$_\n" foreach ( @lsArray );

#--------------------------
# Using the 'qw' operator..
#--------------------------
my @lsArr = qw ( One Two Three Four Five Six Seven Eight Nine Ten );
print "\nPrinting words One - Ten\n";
print "$_\n" foreach ( @lsArr );

#------------------
# Assiging Arrays..
#------------------
@lsArray = @lsArr;
print "\nAfter assigning lsArr to lsArray:\n";
print "$_\n" foreach ( @lsArray );

#-------------------
# Size of an array..
#-------------------
my $iSize = scalar @lsArray;
print "\nSize of lsArray is [$iSize], last index is [", $#lsArray, "]\n";

#---------------------
# Reversing an array..
#---------------------
@lsArray = reverse @lsArr;
print "\nAfter assigning lsArr to lsArray (reversed):\n";
print "$_\n" foreach ( @lsArray );

#---------------------------
# Reversing in another way..
#---------------------------
print "Reversing in another way..\n";
@lsArray = map { $lsArray [-$_] } ( 1 .. $#lsArray + 1 );
print "$_\n" foreach ( @lsArray );
