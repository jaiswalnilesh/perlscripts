#!/usr/bin/perl

use Animal;
use Cow;
use Goat;
use Horse;
use Mouse;

#Reference is a scalar
print ("\n*** Reference is a scalar\n");
my $name = "Golu";
my $animal = \$name;
print "Before bless: \$animal is of type ref($animal) \n";
bless $animal, Goat;
print "After bless: \$animal is of type ref($animal) \n";
$animal->speak;

#Reference is a Hash
print ("\n*** Reference is a hash\n");
my $animal = {_name=>"Gauri", _color=>"white"};
print "Before bless: \$animal is of type ref($animal) \n";
bless $animal, Cow;
print "After bless: \$animal is of type ref($animal) \n";
$animal->speak;

#Blessing the scalar reference inside a function
print ("\n*** Reference to scalar obtained from a class method\n");
my $animal = Horse->new("Toofan");
$animal->speak;

#Blessing the hash reference inside a function
print ("\n*** Reference to hash obtained from a class method\n");
my $animal = Mouse->mynew("Stuart Little", "white");
$animal->speak;

