#!/usr/bin/perl -w
#ident "@(#) Make records.. Atre 22 Oct 2007"

use strict;

my ( $name, $rec, %ByName ) = ();

my $record = {
  FNAME => "Anshuman",
  SNAME => "Atre",
  EMPNO => "E035501",
  TITLE => "Sr. Software Engineer",
  DOB   => "11 Mar 1976",
  GROUP => "DCMG",
  VEHI  => [ "Activa", "Maruti Zen", "Bicycle" ],
};

$ByName { $record->{ FNAME } } = $record;

printf ( "I am [%s %s], and my vehicles are, [%s]\n",
$record->{ FNAME }, $record->{ SNAME }, join ( ", ", @{ $record->{ VEHI } } ) );

# Add one more vehicle..
push @{ $ByName { Anshuman } -> { VEHI } }, "Tricycle";

while ( ( $name, $rec ) = each %ByName ) {
  printf ( "[%s] is employee number [%s]\n", $name, $rec->{EMPNO} );
  printf ( "His vehicles are [%s]\n", join ( ", ", @{$rec->{VEHI}} ) );
}

