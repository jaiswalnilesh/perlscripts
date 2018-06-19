#!/usr/bin/perl

use Person;

my $person = Person->new("Rodney Martis", "33", "LBS", "Mumbai");
$person->print_person;

print "\n*************\n";
my $addr = Address->new("34","MGRoad","Pune");
my $person1 = Person->new_with_addr("Rodney", $addr);
$person1->print_person;

print "\n**Only Address******\n";
$person->print_addr;
print "\n***********\n";
$person1->print_addr;
