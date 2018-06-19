#!/usr/bin/perl

use VCS;
use SM;
use SSMG;
use Pune;

my $employee = VCS->new("Rodney", "Senior Software Engineer");

if ($employee->isa("SSMG")) {
    print $employee->name(), " is an SSMG employee \n";
}

if ($employee->isa("Pune")) {
    print $employee->name(), " is a Pune employee \n";
}
    
$employee->univ_method();
