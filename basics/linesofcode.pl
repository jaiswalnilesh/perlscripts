#!/usr/bin/perl -w
#ident "@(#) Actual lines of code.. Atre 07 Feb 2008"

while (<DATA>) {
  s/\n//;                       # Chomp..
  next if ( m@/\*@ .. m@\*/@ ); # Strip C comments..
  s@//.*@@;                     # Strip C++ comments..   

  #-----------------------------------
  # Count and print valid lines code..
  #-----------------------------------
  if ( /\S/ ) {
    ++ $i;
    print "$_\n";
  }
}

=pod
#----------------
# Alternate way..
#----------------
print grep {
       ! ( m@/\*@ .. m@\*/@ ) && # Strip C comments..
         ( s@//.*@@ || 1 )    && # Strip C++ comments and make true..
         ( /\S/ && ++ $i )       # If non-white, count..
      } <DATA>;                  # From file..
=cut

print "\n----\nTotal lines of code [$i]\n";

__DATA__
#include <stdio.h>
#include <errno.h>
#include <iostream>
using namespace std;

int main ( int argc, char ** argv ) {

 int i = 2, j = 3, k = 11; // Initialise variables.. 

 /*
  * Do something with the variables..
  */

  i = j * k; /* i is the product of j and k.. */
  k = k * k; // Now square up k..

/*
  j = j % 2; // Find the modulus of j..

 //  KEEPING COMMENTED 
  */
  ( void ) fprintf ( stdout, "i [%d] j [%d] k [%d]\n", i, j, k );
  fflush ( stdout );

  return ( 0 );
}
