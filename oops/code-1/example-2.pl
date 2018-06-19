#!/usr/bin/perl

use Cow;
use Sheep;
use Horse;

print "\n***Way-1***\n";
Cow::speak();
Sheep::speak();
Horse::speak();

print "\n\n***Way-2***\n";
Cow->speak();
Sheep->speak();
Horse->speak();

print "\n\n***Way-3***\n";
@farm = qw(Cow Horse Sheep);
foreach $animal(@farm) {
    $animal->speak();
}

print "\n\n***Way-4***\n";
$method="speak";
Cow->$method();
Sheep->$method();
Horse->$method();
