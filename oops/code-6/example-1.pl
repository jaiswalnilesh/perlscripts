#!/usr/bin/perl

use VCS;
use SM;
use SSMG;


# Interface Polymorphism
my @employees = (VCS->new("Rod"), 
		 SM->new("Rodney"), 
		 SSMG->new("Rodney Martis")
		);

foreach $emp (@employees) {
    print $emp->name(), " works in ", $emp->head(), "'s Org\n";
}


print ("\n***************\n");
my $employee = VCS->new("Rod");
$employee->act();
